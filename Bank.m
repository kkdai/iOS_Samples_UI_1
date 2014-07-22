//
//  Bank.m
//  FindWU
//
//  Created by Evan Lin on 2014/7/18.
//  Copyright (c) 2014年 Adriaenssen BVBA. All rights reserved.
//

#import "Bank.h"

@implementation Bank : NSObject

- (id) init
{
    self = [super init];
    _address = [[NSString alloc] init];
    _name = [[NSString alloc] init];
    _phone = [[NSString alloc] init];
    _area = [[NSString alloc] init];
    _add_num = [[NSString alloc] init];
    return self;
}
@end
