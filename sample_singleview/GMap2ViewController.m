//
//  GMap2ViewController.m
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/9.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "GMap2ViewController.h"

@interface GMap2ViewController ()<GMSMapViewDelegate> {
    GMSMapView *mapView;
    BOOL firstLocationUpdate;
}

@end

@implementation GMap2ViewController

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
    // Do any additional setup after loading the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6];
    
    mapView = [GMSMapView mapWithFrame:(self.gMV.bounds) camera:camera];
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    /*
     [mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

    */
    
    _markers = [[NSMutableSet alloc] init];
    
    // Setup markers
    int i = 0;
    for (i=0; i < 4; i++) {
        GMSMarker *marker1 =  [[GMSMarker alloc]init];
        marker1.position = CLLocationCoordinate2DMake(-33+i, 150-i);
        marker1.title = @"測試marker1";
        marker1.snippet = @"測試marker1 ...";
        marker1.appearAnimation = kGMSMarkerAnimationPop;
        //marker1.map = mapView;
        [_markers addObject:marker1];
    }
    
    [self drawMarkers];
    
    mapView.delegate = self;
    
    [_gMV addSubview:mapView];
    //self.view = mapView;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.myLocationEnabled = YES;
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMyLoc:(id)sender {
}

#pragma mark - Markers handles
- (void)drawMarkers{
    for (GMSMarker *obj in _markers) {
        obj.map = mapView;
    }
}

#pragma mark - Marer delegate
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    UIView *infoWin = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = marker.title;
    label.frame = CGRectMake(14,11,175,16);
    [infoWin addSubview:label];
    return infoWin;
}

#pragma mark - KVO updates
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (firstLocationUpdate) {
        firstLocationUpdate = YES;
        CLLocation *localtion = [change objectForKey:NSKeyValueChangeNewKey];
        mapView.camera = [GMSCameraPosition cameraWithTarget:localtion.coordinate zoom:14];
    }
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
