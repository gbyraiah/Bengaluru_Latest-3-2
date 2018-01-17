//
//  ScrollImages.h
//  Bengaluru
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ScrollImages : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate >{
NSMutableArray*slideImages;
int currentPage;
IBOutlet UIScrollView* scrollView;
    UIImageView*fullScreenImage;

}
- (IBAction)ImageShare:(id)sender;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain)NSMutableArray*slideImages;
@property (nonatomic, retain) UIImageView*fullScreenImage;
@end
