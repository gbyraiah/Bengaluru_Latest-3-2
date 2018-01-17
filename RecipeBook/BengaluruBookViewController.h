//
//  RecipeBookViewController.h
//  RecipeBook
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "BengaluruSubViewController.h"
#import "RecipeBookTableViewCell.h"

@interface BengaluruBookViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end
