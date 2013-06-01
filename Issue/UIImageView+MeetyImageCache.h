//
//  UIImageView+MeetyImageCache.h
//  meety_ios
//
//  Created by 최건우 on 13. 1. 25..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetyImageCache.h"

@interface UIImageView (MeetyImageCache)

- (void) setImageWithURL:(NSURL *)url;
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage;
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

- (void) setImageWithURL:(NSURL *)url key:(NSString*)key;
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage;
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

- (void) setImageWithRequest:(NSURLRequest *)request;
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage;
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key;
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage;
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

@end