//
//  LinkViewViewController.m
//  Bengaluru
//

#import "LinkViewController.h"
#import "Reachability.h"

@interface LinkViewController ()

@end

@implementation LinkViewController
@synthesize webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
//    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Can't connect. Please check your internet Connection"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];    } else {
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
        NSLog(@"There IS internet connection");
    }
    NSURL *url = [NSURL URLWithString:[CommonClass sharedInstance].link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    webView.backgroundColor=[UIColor clearColor];
    webView.scalesPageToFit = YES;
    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}
-(void) showActivityIndicator
{
    //Add a UIView in your .h and give it the same property as you have given to your webView.
    //Also ensure that you synthesize these properties on top of your implementation file
    
    loadingView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    loadingView.alpha = 0.5;
    
    //Create and add a spinner to loadingView in the center and animate it. Then add this loadingView to self.View using
    [self.view addSubview:loadingView];
}
-(void) removeLoadingView
{
    
    [loadingView removeFromSuperview];
}
// Delegate methods

-(void)webViewDidStartLoad:(UIWebView *)webView {
   
    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [HUD hide:YES];
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [HUD hide:YES];
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
