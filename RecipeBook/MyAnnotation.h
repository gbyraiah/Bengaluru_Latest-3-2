//
//  MyAnnotation.h
//  Bengaluru
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;
@end

