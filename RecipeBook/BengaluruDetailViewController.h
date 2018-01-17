//
//  RecipeDetailViewController.h
//  RecipeBook
//

//

#import <UIKit/UIKit.h>

@interface BengaluruDetailViewController : UIViewController<UIScrollViewDelegate>{
    NSMutableArray*slideImages;
	int currentPage;
    IBOutlet UIScrollView* scrollView;

}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;
@property (nonatomic, strong) NSString *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *detailPhoto;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, retain)NSMutableArray*slideImages;



@end
