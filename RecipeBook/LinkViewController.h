//
//  LinkViewViewController.h
//  Bengaluru
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LinkViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>{
    UIView*loadingView;
    MBProgressHUD *HUD;

}
@property (nonatomic, strong) IBOutlet UIWebView *webView;


@end
