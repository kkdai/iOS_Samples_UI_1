//
//  SVInheritParent.m
//  sample_singleview
//
//  Created on 2014/5/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "SVInheritParent.h"

@implementation SVInheritParent
- (id) initWithDelegate :(id<SVInheritParentDelegate>)delegate
{
    _delegate = delegate;
    id _id = [super init];
    return _id;
}

- (void) method_1
{
    NSLog(@"--------method_1--------------");
    [_delegate didCallBack:@"call back1"];
}

+(void) class_method_1
{
    NSLog(@"--------class_method_1--------------");
}
@end
