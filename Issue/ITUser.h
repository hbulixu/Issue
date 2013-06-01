//
//  ITUser.h
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITModel.h"

@interface ITUser : ITModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString *username;

@end
