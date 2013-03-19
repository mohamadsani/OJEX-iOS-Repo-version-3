//
//  MapPickController.m
//  OJEX
//
//  Created by Mohamad Sani on 3/19/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "MapPickController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapPickController ()

@end

@implementation MapPickController {
    GMSMapView *mapView_;
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
	float lat = -6;
    float lon = 106;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(lat, lon);
    options.title = @"Anda";
    [mapView_ addMarkerWithOptions:options];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
