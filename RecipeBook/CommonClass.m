//
//  CommonClass.m
//  Bengaluru
//

#import "CommonClass.h"
static CommonClass*sharedInstance=nil;
static dispatch_once_t oncePredicate=nil;
@implementation CommonClass
@synthesize mainListString;
@synthesize title;
@synthesize description;
@synthesize link;
@synthesize totalNumber;

+(CommonClass*)sharedInstance{
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[CommonClass alloc] init];
    });
    return sharedInstance;
    
}
@end
