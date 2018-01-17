//
//  MapViewController.m
//  Bengaluru
//


#import "MapViewController.h"


@implementation MapViewController
@synthesize nextPartArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"coordinates" ofType:@"plist"];
    NSDictionary*dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    // Initialize table data
    ListArray=[dictionary valueForKey:@"coordinates"];
//    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
//    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    [self.view addSubview:self.mapView];
//    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager startUpdatingLocation];
//    self.mapView.delegate = self;
    
    // Sample example just to show annotation
    // in your program you will likely need to use custom annotation objects
    
    BOOL satisfied=NO;
    for (NSString*stringName in ListArray) {
        NSArray*arrDummy=[stringName componentsSeparatedByString:@"_"];
        NSString*actualString=[arrDummy objectAtIndex:0];
        if ([actualString isEqualToString:[CommonClass sharedInstance].title]) {
            if ([arrDummy count]>1) {
                self.nextPartArray=(NSMutableArray*)[[arrDummy objectAtIndex:1] componentsSeparatedByString:@","];
//                region.center.latitude = [[nextPartArray objectAtIndex:0] floatValue];
//                region.center.longitude = [[nextPartArray objectAtIndex:1] floatValue];
                CLLocation* myLocation = [[CLLocation alloc] initWithLatitude:[[nextPartArray objectAtIndex:0] floatValue] longitude:[[nextPartArray objectAtIndex:1] floatValue]];
                [self.mapView addAnnotation:myLocation];
                
                CLLocationCoordinate2D location;
                location.latitude =  [[nextPartArray objectAtIndex:0] floatValue];
                location.longitude = [[nextPartArray objectAtIndex:1] floatValue];
                
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (location, 2000, 2000);
                [self.mapView setRegion:region animated:YES];
                satisfied=YES;
                break;
            }
            
        }
        
    }
    if (!satisfied) {
            self.mapView.delegate = self;

//        region.center.latitude = userLocation.coordinate.latitude;
//        region.center.longitude = userLocation.coordinate.longitude;
    }

  
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

}
- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    BOOL satisfied=NO;
    for (NSString*stringName in ListArray) {
        NSArray*arrDummy=[stringName componentsSeparatedByString:@"_"];
        NSString*actualString=[arrDummy objectAtIndex:0];
        if ([actualString isEqualToString:[CommonClass sharedInstance].title]) {
            if ([arrDummy count]>1) {
                region.center.latitude = [[self.nextPartArray objectAtIndex:0] floatValue];
                region.center.longitude = [[self.nextPartArray objectAtIndex:1] floatValue];
                satisfied=YES;
                break;
            }
            
        }
        
    }
    if (!satisfied) {
        region.center.latitude = userLocation.coordinate.latitude;
        region.center.longitude = userLocation.coordinate.longitude;
        point.coordinate = userLocation.coordinate;
        point.title = @"Where am I?";
        point.subtitle = @"I'm here!!!";

    }
  
   
    
    [self.mapView addAnnotation:point];
}
#pragma mark - DELEGATE
//for iOS 5
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    //    [manager stopUpdatingLocation];
    if (newLocation) {
        if (!userAnnotation) {
            userAnnotation = [[MyAnnotation alloc]
                              initWithCoordinate:newLocation.coordinate
                              title:@"I'm here"
                              subtitle:nil];
            [self.mapView addAnnotation:userAnnotation];
        } else {
            [self.mapView removeAnnotation:userAnnotation];
            [userAnnotation setCoordinate:newLocation.coordinate];
            [self.mapView addAnnotation:userAnnotation];
        }
    }
}
//for iOS 6
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *loc = locations.lastObject;
    [self locationManager:manager didUpdateToLocation:loc fromLocation:nil];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    //open GPS services please
}
- (void)dealloc {
    [locationManager stopUpdatingLocation];
}
@end