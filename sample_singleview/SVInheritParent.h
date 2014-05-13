//
//  SVInheritParent.h
//  sample_singleview
//
//  Created on 2014/5/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SVInheritParentDelegate <NSObject>

@required
-(void) didCallBack:(NSString*) callback_str;
@optional
@end

@interface SVInheritParent : NSObject
- (id) initWithDelegate :(id<SVInheritParentDelegate>)delegate;
- (void) method_1;
+(void) class_method_1;
@property (weak, nonatomic) id<SVInheritParentDelegate> delegate;
@end


