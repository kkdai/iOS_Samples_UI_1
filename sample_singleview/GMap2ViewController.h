//
//  GMap2ViewController.h
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/9.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GMap2ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIView *gMV;
@property (strong, nonatomic) NSMutableSet  *markers;
@end
