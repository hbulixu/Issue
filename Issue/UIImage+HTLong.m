/*
 * UIImage+HTLong.m
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
 */

#import "UIImage+HTLong.h"
#import <objc/runtime.h>

static Method imageNamedMethod = nil;
static Method imageWithContentsOfFileMethod = nil;
static Method initWithContentsOfFileMethod = nil;

@implementation UIImage (HTLong)

#pragma mark - Private class methods

+ (NSString*)retinaImageName:(NSString*)imageName {
    NSString* filename = [[imageName lastPathComponent] stringByDeletingPathExtension];
    NSString* extension = [imageName pathExtension];
    NSString* directory = [imageName stringByDeletingLastPathComponent];
    
    // Append retina tag
    if (![filename hasSuffix:@"@2x"]) {
        filename = [filename stringByAppendingString:@"@2x"];
    }
    return [directory stringByAppendingPathComponent:extension.length?[filename stringByAppendingPathExtension:extension]:filename];
}

+ (NSString*)longImageName:(NSString*)imageName{
    BOOL isLong = [UIScreen mainScreen].bounds.size.height == 568.0f;
    
    NSString* filename = [[imageName lastPathComponent] stringByDeletingPathExtension];
    NSString* extension = [imageName pathExtension];
    NSString* directory = [imageName stringByDeletingLastPathComponent];
    
    BOOL hasRetinaTag = [filename hasSuffix:@"@2x"];
    
    // Remove retina tag temporary
    if (hasRetinaTag) {
        filename = [filename substringToIndex:filename.length - [@"@2x" length]];
    }
    
    // Append long tag
    if (isLong && ![filename hasSuffix:@"-568h"]) {
        filename = [filename stringByAppendingString:@"-568h"];
    }
    
    // Append retina tag again
    if (hasRetinaTag) {
        filename = [filename stringByAppendingString:@"@2x"];
    }
    
    return [directory stringByAppendingPathComponent:extension.length?[filename stringByAppendingPathExtension:extension]:filename];
}

#pragma mark - Public class methods

+ (void)initialize {
    if(!imageNamedMethod) {
        imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
        method_exchangeImplementations(imageNamedMethod,
                                       class_getClassMethod(self, @selector(longImageNamed:)));
    }
    if (!initWithContentsOfFileMethod) {
        initWithContentsOfFileMethod = class_getInstanceMethod(self, @selector(initWithContentsOfFile:));
        method_exchangeImplementations(initWithContentsOfFileMethod,class_getInstanceMethod(self, @selector(initWithContentsOfLongFile:)));
    }
    if (!imageWithContentsOfFileMethod) {
        imageWithContentsOfFileMethod = class_getInstanceMethod(self, @selector(imageWithContentsOfFile:));
        method_exchangeImplementations(imageWithContentsOfFileMethod, class_getInstanceMethod(self, @selector(imageWithContentsOfLongFile:)));
    }
}

+ (UIImage *)longImageNamed:(NSString *)imageName {
    UIImage* image = [UIImage longImageNamed:[self longImageName:imageName]];
    if (image == nil) {
        image = [UIImage longImageNamed:imageName];
    }
    return image;
}

+ (UIImage*)imageWithContentsOfLongFile:(NSString*)path {
    UIImage* image = [self imageWithContentsOfLongFile:[self longImageName:path]];
    if (image == nil) {
        image = [self imageWithContentsOfLongFile:path];
    }
    return image;
}

#pragma mark - Initializers

- (id)initWithContentsOfLongFile:(NSString*)path{
    NSFileManager* filemanager = [NSFileManager defaultManager];
    NSString* longPath = [UIImage longImageName:path];
    if ([filemanager fileExistsAtPath:longPath] || [filemanager fileExistsAtPath:[UIImage retinaImageName:longPath]]) {
        return [self initWithContentsOfLongFile:longPath];
    }
    return [self initWithContentsOfLongFile:path];
}

@end