//
//  ITComment.h
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITModel.h"
#import "ITUser.h"

@interface ITComment : ITModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger writerID;
@property (nonatomic, strong) ITUser *writer;
@property (nonatomic) NSInteger photoID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *createdAt;

@end
