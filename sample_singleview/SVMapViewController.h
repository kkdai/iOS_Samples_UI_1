//
//  SVMapViewController.h
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/7.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SVMapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
