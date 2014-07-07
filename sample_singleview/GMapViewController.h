//
//  GMapViewController.h
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/7.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *map1;
@property (strong, nonatomic) IBOutlet GMSMapView *gMap1;
@end
