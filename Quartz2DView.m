//
//  Quartz2DView.m
//  sample_singleview
//
//  Created by 林 宜鋒 on 2014/3/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "Quartz2DView.h"

@implementation Quartz2DView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
    }
    return self;
}

-(void) drawRect:(CGRect) rect{
    //(step 1)
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //(step 2)
    CGAffineTransform t0 = CGContextGetCTM( context );
    t0 = CGAffineTransformInvert(t0);
    CGContextConcatCTM(context, t0);
    //(step 3)
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);// CGContextSetRGBFillColor(CGContextRef ,r,g,h,alpha)
    CGContextAddRect( context , CGRectMake( 0, 0,100, 100));//CGRectMake(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
    CGContextClosePath(context);
    CGContextDrawPath(context,kCGPathFill);
    //(step 4)
    CGContextRestoreGState(context);
}
@end
