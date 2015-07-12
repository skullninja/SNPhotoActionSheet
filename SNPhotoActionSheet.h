//
//  SNPhotoActionSheet.h
//
//  Created by Dave Peck on 7/11/15.
//  Copyright (c) 2015 Skull Ninja Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNPhotoActionSheet;

@protocol SNPhotoActionSheetDelegate <NSObject>

- (void)photoActionSheet:(SNPhotoActionSheet *)actionSheet photoSelected:(UIImage *)photo;
- (void)photoActionSheetCameraOptionSelected:(SNPhotoActionSheet *)actionSheet;
- (void)photoActionSheetDidDismiss:(SNPhotoActionSheet *)actionSheet;

@end

@interface SNPhotoActionSheet : UIActionSheet

@property (nonatomic, weak) UIViewController<SNPhotoActionSheetDelegate> *presentingViewController;

- (id)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

/** Replaces ShowInView **/
- (void)showInViewController:(UIViewController<SNPhotoActionSheetDelegate> *)viewController;

- (void)showAlertWithMessage:(NSString *)message;

@end
