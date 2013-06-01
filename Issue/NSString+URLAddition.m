//
//  NSString+URLAddition.m
//  iDongNe
//
//  Created by 건우 최 on 12. 5. 10..
//  Copyright (c) 2012년 6566gun@gmail.com. All rights reserved.
//

#import "NSString+URLAddition.h"
#import "HTARCSupport.h"

@implementation NSString (URLAddition)
-(NSString *)URLEncodedStringWithEncoding:(NSStringEncoding)encoding{
    NSMutableString * output = [NSMutableString string];
    unsigned char *str = (unsigned char *)[self cStringUsingEncoding:encoding];
    size_t len = strlen((char *)str);
    for (size_t i = 0; i < len; i++){
        unsigned char thisChar = str[i];
        if (thisChar == ' '){
            [output appendString:@"%20"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || 
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')){
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSDictionary *)urlParameters{
    NSArray* params = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (NSString* param in params){
        NSArray* kv = [param componentsSeparatedByString:@"="];
        if (kv.count < 2){
            continue;
        }
        NSString* k = [[kv objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* v = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dic setObject:v forKey:k];
    }
    return [NSDictionary dictionaryWithDictionary:dic];
}
@end
