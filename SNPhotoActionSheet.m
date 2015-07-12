//
//  SNPhotoActionSheet.m
//
//  Created by Dave Peck on 7/11/15.
//  Copyright (c) 2015 Skull Ninja Inc. All rights reserved.
//

#import "SNPhotoActionSheet.h"

@interface SNPhotoActionSheet ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SNPhotoActionSheet

- (id)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title
                       delegate:nil
              cancelButtonTitle:@"Cancel"
         destructiveButtonTitle:nil
              otherButtonTitles:@"Take a Photo", @"Choose From Albums", nil];
    if (self) {
        [self setDelegate:self];
    }
    return self;
}

- (void)showInViewController:(UIViewController<SNPhotoActionSheetDelegate> *)viewController {
    [super showInView:viewController.view];
    self.presentingViewController = viewController;
}

#pragma mark - Photo Selection

- (void)takePicture {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showAlertWithMessage:@"Unable to access your camera."];
        return;
    }
    
    [self.presentingViewController photoActionSheetCameraOptionSelected:self];
}

- (void)selectPicture {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self showAlertWithMessage:@"Unable to access your photos."];
        return;
    }
    
    UIImagePickerController *picker = [self imagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.presentingViewController presentViewController:picker animated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = NO;
    [picker setDelegate:self];
    return picker;
}

#pragma mark - Show Alert

- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil
                              ];
    
    [alertView show];
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.cancelButtonIndex != buttonIndex) {
        if (buttonIndex == 0) {
            [self takePicture];
        } else if(buttonIndex == 1){
            [self selectPicture];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.presentingViewController photoActionSheet:self photoSelected:image];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.presentingViewController photoActionSheetDidDismiss:self];
    }];
}
@end
