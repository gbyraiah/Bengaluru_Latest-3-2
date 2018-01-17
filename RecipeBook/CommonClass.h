//
//  CommonClass.h
//  Bengaluru
//

#import <Foundation/Foundation.h>

@interface CommonClass : NSObject{
    
    NSString*mainListString;
    NSString*title;
    NSString*description;
    NSString*link;
    int totalNumber;
    
}
@property(nonatomic,retain)NSString*mainListString;
@property(nonatomic,retain)NSString*title;
@property(nonatomic,retain)NSString*description;
@property(nonatomic,retain)NSString*link;
@property(nonatomic,assign)int totalNumber;
+(CommonClass*)sharedInstance;
@end
