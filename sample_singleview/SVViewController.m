 //
//  SVViewController.m
//  sample_singleview
//
//  Created on 2014/3/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "SVViewController.h"

@interface SVViewController ()
@end

@implementation SVViewController
{
    SVInheritParent *obj1;
}
@synthesize drawingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    CGRect frame = CGRectMake(20, 45, 140, 21);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [self.view addSubview:label];
    [label setText:@"Number of sides:"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    lineView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lineView];

    
    //[drawingView setNeedsDisplay];

    {
//        CGRect frame = CGRectMake(20, 45, 140, 21);
//        UILabel *label = [[UILabel alloc] initWithFrame:frame];
//        [drawingView addSubview:label];
//        [label setText:@"Number of sides:"];
    }
    
    
    [self listSubviewsOfView:self.view];
    NSLog(@"------------------------");
    [self listSubviewsOfView:drawingView];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, drawingView.bounds.size.width, 30)];
    lineView2.backgroundColor = [UIColor yellowColor];
    [drawingView addSubview:lineView2];
    NSLog(@"------------------------");
    [self listSubviewsOfView:drawingView];
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES); // 360 degree (0 to 2pi) arc
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"%@", subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 1)];
//    lineView.backgroundColor = [UIColor blackColor];
//
//    [self.view addSubview:lineView];


-(IBAction)startScaleTransform:(id)sender
{
    self.view.transform = CGAffineTransformMakeScale(2,2);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    self.view.transform = CGAffineTransformMakeScale(1,1);
    self.view.alpha = 1.0;
    [UIView commitAnimations];
    obj1 = [[SVInheritChild alloc] initWithDelegate:self];
    [obj1 method_1];
}

#pragma mark Callback Delegate
-(void)didCallBack:(NSString*) callback_str;
{
    NSLog(callback_str);
}
@end
