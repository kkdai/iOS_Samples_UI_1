//
//  GMapViewController.m
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/7.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "GMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface GMapViewController ()

@end

@implementation GMapViewController{
    //GMSMapView *mapView_;
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
    NSTimer *timer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.zoomGestures = NO;
    mapView_.settings.scrollGestures = NO;
    mapView_.settings.rotateGestures = NO;
    mapView_.settings.tiltGestures = NO;
    self.view = mapView_;
}


- (void)moveCamera {
    GMSCameraPosition *camera = mapView_.camera;
    float zoom = fmaxf(camera.zoom - 0.1f, 17.5f);
    
    GMSCameraPosition *newCamera =
    [[GMSCameraPosition alloc] initWithTarget:camera.target
                                         zoom:zoom
                                      bearing:camera.bearing + 10
                                 viewingAngle:camera.viewingAngle + 10];
    [mapView_ animateToCameraPosition:newCamera];
}

- (void)viewDidAppear:(BOOL)animated {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f/30.f
                                             target:self
                                           selector:@selector(moveCamera)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
