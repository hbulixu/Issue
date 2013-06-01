//
//  HTConfig.h
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTConfig : NSObject{
    @private
    NSDictionary* configData;
}
+ (HTConfig*)sharedInstance;
+ (void)setConfigFilePath:(NSString*)path;
- (NSString*)stringForKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;
- (NSInteger)integerForKey:(NSString*)key;
- (double)doubleForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;
@end
