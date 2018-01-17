//
//  ViewController.h
//  ICSExporter
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"

@class MXLCalendar;

@interface iCaleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, VRGCalendarViewDelegate> {
    
    IBOutlet UITableView *eventsTableView;
    MXLCalendar *currentCalendar;
    
    NSDate *selectedDate;
    NSMutableDictionary *savedDates;
    
    NSMutableArray *currentEvents;
}

@end
