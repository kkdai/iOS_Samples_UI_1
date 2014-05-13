//
//  SVInheritChild.m
//  sample_singleview
//
//  Created on 2014/5/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "SVInheritChild.h"

@implementation SVInheritChild
- (void) method_1
{
    //Specific child method, other using parent.
    NSLog(@"--------child method_1--------------");
    //Parent callback and delegate
    [super.delegate didCallBack:@"child call back1"];
}
@end
