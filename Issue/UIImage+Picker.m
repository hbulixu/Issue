//
//  UIImage+Picker.m
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "UIImage+Picker.h"

@implementation UIImage (Picker)

+ (UIImage *)imageWithPickerInfo:(NSDictionary*)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        return image;
    }
    return info[UIImagePickerControllerOriginalImage];
}

@end
