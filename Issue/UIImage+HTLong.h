/*
 * UIImage+HTLong.h
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, February 2013
 *
 * Copyright (C) 2013 GunWoo Choi
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 *  0. You just DO WHAT THE FUCK YOU WANT TO.
 *  
 *  How To Use It
 *  -------------
 *
 *  1.  Add UIImage+HTLong.h and UIImage+HTLong.m to your project.
 *
 *  2.  Check your target membership.
 *
 *  3.  Just use imageNamed:, initWithContentsOfFile:, imageWithContentsOfFile: methods like you did before.
 *
 *  4.  For example, If current device has long [UIImage imageNamed:@"some_image"] will try with "some_image-568h".
 *      When result is nil, It will try with "some_image" again.  If current device has short screen, It will try
 *      just with "some_image".
 *
 *  5.  아 영어 쓰기 힘들다.
 *
 */

#import <UIKit/UIKit.h>

@interface UIImage (HTLong)

@end