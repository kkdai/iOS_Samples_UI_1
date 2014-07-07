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
    
    /* Option 1. view on XIB is class GSMMapView */
    //BEcause gMap1 is GSMMapView so just assigm camera is fine.
    self.gMap1.camera = camera;
    
     /* Option 2. add a map as a subview */
    //Create whole new one in code
    GMSMapView *map2 = [GMSMapView mapWithFrame:CGRectMake(0, 0, 100, 100) camera:camera];
    [self.view addSubview:map2];

    /* Option 3. add a map to a subview already on the XIB */
    //Use UIView and addSubView
    GMSMapView *map3 = [GMSMapView mapWithFrame:self.map1.bounds camera:camera];
    [self.map1 addSubview:map3];
    
    
/*    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.zoomGestures = NO;
    mapView_.settings.scrollGestures = NO;
    mapView_.settings.rotateGestures = NO;
    mapView_.settings.tiltGestures = NO;
    self.view = mapView_; */
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

- (IBAction)showLoc:(id)sender {
 
    NSString *addressString = @"台北市瑞光路399號";
    CLLocation *location;
    NSString *url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", addressString];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *wurl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL: wurl];
    
    // Fail to get data from server
    if (nil == data) {
        
        NSLog(@"Error: Fail to get data");
    }
    else{
        // Parse the json data
        NSError *error;
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        
        // Check status of result
        NSString *resultStatus = [json valueForKey:@"status"];
        // If responce is valid
        if ( (nil == error) && [resultStatus isEqualToString:@"OK"] ) {
            NSDictionary *locationDict=[json objectForKey:@"results"] ;
            NSArray *temp_array=[locationDict valueForKey:@"geometry"];
            NSArray *temp_array2=[temp_array valueForKey:@"location"];
            NSEnumerator *enumerator = [temp_array2 objectEnumerator];
            id object;
            while ((object = [enumerator nextObject])) {
                double latitude=[[object valueForKey:@"lat"] doubleValue];
                double longitude=[[object valueForKey:@"lng"] doubleValue];
                location=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
                
                NSLog(@"CLLocation lat  is  %f  -------------& long   %f",location.coordinate.latitude, location.coordinate.longitude);
                
            }
        }
    }
    
    GMSCameraPosition* camera = [GMSCameraPosition
                                 cameraWithLatitude: location.coordinate.latitude
                                 longitude: location.coordinate.longitude
                                 zoom: 6];
    mapView_.camera = camera;
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
