//
//  DetailViewController.h
//  Bengaluru1
//
//  Created by Gouthami Byraiah on 4/3/15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BengaluruBookAppDelegate.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *fullname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnBack:(id)sender;
@property (strong) NSManagedObject *contactdb;



@end
