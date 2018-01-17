//
//  MyAnnotation.m
//  Bengaluru
//

#import "MyAnnotation.h"

@implementation MyAnnotation
- (NSString *)title {return _title;}
- (NSString *)subtitle {return _subtitle;}
- (CLLocationCoordinate2D)coordinate {return _coordinate;}
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {_coordinate = newCoordinate;}
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    if (self = [super init]) {
        _title = title.copy;
        _subtitle = subtitle.copy;
        _coordinate = coordinate;
    }
    return self;
}
@end
