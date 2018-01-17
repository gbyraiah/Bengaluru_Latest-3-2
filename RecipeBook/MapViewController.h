//
//  MapViewController.h
//  Bengaluru
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface MapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation>{
    CLLocationManager *locationManager;
    MyAnnotation *userAnnotation;
    IBOutlet MKMapView *mapView;
    
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSArray *ListArray;
    NSMutableArray*nextPartArray;
}
@property (strong, nonatomic)IBOutlet MKMapView *mapView;
@property(nonatomic,retain)NSMutableArray*nextPartArray;
@end

