//
//  SVViewController.h
//  sample_singleview
//
//  Created on 2014/3/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartz2DView.h"
#import "SVInheritParent.h"
#import "SVInheritChild.h"

@interface SVViewController : UIViewController <SVInheritParentDelegate>
@property (weak, nonatomic) IBOutlet Quartz2DView *drawingView;
@property (weak, nonatomic) SVInheritParent *obj1;
-(void) drawRect:(CGRect)rect;

@end
