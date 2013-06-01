//
//  ITIssue.h
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITModel.h"

@interface ITIssue : ITModel

@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *createdAt;

@end
