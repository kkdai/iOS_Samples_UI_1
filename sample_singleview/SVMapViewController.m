//
//  SVMapViewController.m
//  sample_singleview
//
//  Created by Evan Lin on 2014/7/7.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "SVMapViewController.h"

@interface SVMapViewController ()

@end

#define METERS_PER_MILE 1609.344
@implementation SVMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)showCurrentLoc:(id)sender {
    MKCoordinateRegion currentRegion;
    currentRegion.center = self.mapView.userLocation.location.coordinate;
    currentRegion.span.latitudeDelta =  0.01;
    currentRegion.span.longitudeDelta = 0.01;
    [self.mapView setRegion:currentRegion];
}

- (IBAction)showOtherLoc:(id)sender {
    NSString *location = @"台北市大安區仁愛路三段53號";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = self.mapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 8.0;
                         region.span.latitudeDelta /= 8.0;
                         
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                     }
                 }
     ];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;

    //show current loc
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    MKCoordinateRegion currentRegion;
    currentRegion.center = self.mapView.userLocation.location.coordinate;
    currentRegion.span.latitudeDelta =  0.01;
    currentRegion.span.longitudeDelta = 0.01;

}
-(void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 1000, 1000);
    [mv setRegion:region animated:YES];
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
#pragma mark MapKit delegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
	MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
	newAnnotation.pinColor = MKPinAnnotationColorPurple;
	newAnnotation.animatesDrop = YES;
	//canShowCallout: to display the callout view by touch the pin
	newAnnotation.canShowCallout=YES;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
	newAnnotation.rightCalloutAccessoryView=button;
    
	return newAnnotation;
}

- (void)checkButtonTapped:(id)sender event:(id)event{
    
    
}
@end
