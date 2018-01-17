//
//  RecipeBookTableViewCell.h
//  RecipeBook
//

#import <UIKit/UIKit.h>

@interface RecipeBookTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *textView;
@property(nonatomic,readonly)IBOutlet UIImageView*imageView;

@end
