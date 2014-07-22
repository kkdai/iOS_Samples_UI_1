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
#import "Bank.h"

@interface SVViewController : UIViewController <SVInheritParentDelegate> {
    //
    NSString *currentAttrib;
    NSMutableArray *bankWebArray;
    Bank *aBank;
    NSMutableString *currentElementValue;  //用于存储元素标签的值
    BOOL storingFlag; //查询标签所对应的元素是否存在
    NSArray *elementToParse;  //要存储的元素
}
@property (weak, nonatomic) IBOutlet Quartz2DView *drawingView;
@property (weak, nonatomic) SVInheritParent *obj1;
-(void) drawRect:(CGRect)rect;

@end
