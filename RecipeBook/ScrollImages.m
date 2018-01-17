//
//  ScrollImages.m
//  Bengaluru
//

#import "ScrollImages.h"
#import "imageClass.h"
#import <Social/Social.h>


#define WIDTH_OF_SCROLL_PAGE [UIScreen mainScreen].bounds.size.width
#define HEIGHT_OF_SCROLL_PAGE [UIScreen mainScreen].bounds.size.height
#define WIDTH_OF_IMAGE [UIScreen mainScreen].bounds.size.width
#define HEIGHT_OF_IMAGE [UIScreen mainScreen].bounds.size.height
#define LEFT_EDGE_OFSET 0
@interface ScrollImages ()

@end

@implementation ScrollImages
@synthesize scrollView,slideImages;
@synthesize fullScreenImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.userInteractionEnabled=YES;
    [self loadScrollView ];

    // Do any additional setup after loading the view.
}
-(void)loadScrollView{
    CGRect scrollFrame;
    scrollFrame.origin.x = 0;
    scrollFrame.origin.y = [UIScreen mainScreen].bounds.size.height*0.2;
    scrollFrame.size.width = WIDTH_OF_SCROLL_PAGE;
    scrollFrame.size.height = HEIGHT_OF_SCROLL_PAGE;
	
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
	scrollView.tag=-100;
    slideImages = [[NSMutableArray alloc] init];
    
    
    
    for (int i=1; i<=[CommonClass sharedInstance].totalNumber; i++) {
        [slideImages addObject:[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,i]];
        
    }
    float X=0;
    float Y=0;
    for (int i = 0;i<[slideImages count];i++) {
        //loop this bit
        imageClass *imageView = [[imageClass alloc] init];//WithImage:
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[slideImages objectAtIndex:i]]];
    
		imageView.tag=i;
        if (X==[UIScreen mainScreen].bounds.size.width*0.5) {
              imageView.frame = CGRectMake(X , Y, [UIScreen mainScreen].bounds.size.width*0.5,[UIScreen mainScreen].bounds.size.width*0.5);
            X=0;
            Y=Y+ [UIScreen mainScreen].bounds.size.width*0.5;
        }
        else{
             imageView.frame = CGRectMake(X , Y, [UIScreen mainScreen].bounds.size.width*0.5,[UIScreen mainScreen].bounds.size.width*0.5);
            X=X+[UIScreen mainScreen].bounds.size.width*0.5;

        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [tap setDelegate:self];
        [tap setNumberOfTapsRequired:1];
        imageView.userInteractionEnabled = YES;
        tap.cancelsTouchesInView = NO;
        [imageView addGestureRecognizer:tap];
      
		[scrollView addSubview:imageView];
        imageView.clipsToBounds=YES;
        imageView.layer.cornerRadius=20;
        imageView.layer.borderWidth=2.0;
        imageView.layer.masksToBounds = YES;
        //imageView.layer.borderColor=[[UIColor blackColor] CGColor];
        //
		
    }
 
	[scrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE,Y+[UIScreen mainScreen].bounds.size.height*0.2)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
    [scrollView scrollRectToVisible:CGRectMake(0,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    currentPage = 1;
    
}
- (void)tapOnce:(id)tapOnce {
    [UIView transitionWithView:self.view
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ {
                        [self.fullScreenImage removeFromSuperview];
                    }
                    completion:nil];
}
- (void)imageTapped:(UITapGestureRecognizer *)sender
{
    UIImageView *imgView=(imageClass*)[sender view];
    self.fullScreenImage = [[UIImageView alloc] initWithFrame:self.view.window.frame];
    self.fullScreenImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[slideImages objectAtIndex:imgView.tag]]];
    UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapOnce:)];
    tapOnce.numberOfTapsRequired = 1;
    [self.fullScreenImage addGestureRecognizer:tapOnce];
    [self.fullScreenImage setUserInteractionEnabled:YES];
    [self.view addSubview:self.fullScreenImage];
    // how to get reference on selected item in scrollview???
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate{
    if (!UIInterfaceOrientationPortrait) {
        NSLog(@"fdyvvvd");
    }
    return YES;
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

- (IBAction)ImageShare:(id)sender {
   /* if([SLComposeServiceViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        NSLog(@"We can post a message to Facebook!");
        SLComposeServiceViewController *vc = [SLComposeServiceViewController composeViewControllerForServicetype:SLServiceTypeFacebook];
        [vc setInitialText: @"Hello My facebook friends, I am a robert"];
        [self presentedViewController:vc animated: YES completion:nil];
    }
    else {
        NSLog(@" We cant post to Facebook");
    }
*/
    
    //This is how you create a UIACtionSheet.
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"Whats on your mind??" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Tweet it!", @"Facebook it!", nil];
    
    //You must show the action sheet for the user to see it.
    [share showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Each button title we gave to our action sheet is given a tag starting with 0.
    if (buttonIndex == 0) {
        
        //Check Twitter accessibility and at least one account is setup.
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            SLComposeViewController *tweetSheet =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            //This is setting the initial text for our share card.
            
            [tweetSheet setInitialText:@"My IOS APP is working !!! :-) "];
            [tweetSheet addImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",[CommonClass sharedInstance].title]]];

            
            //Brings up the little share card with the test we have pre defind.
            [self presentViewController:tweetSheet animated:YES completion:nil];
            
        } else {
            //This alreat tells the user that they can't use built in socal interegration and why they can't.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure you have at least one Twitter account setup and your device is using iOS6." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
    }else if (buttonIndex == 1) {
        
        //Check Facebook accessibility and at least one account is setup.
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            
            SLComposeViewController *facebookSheet =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            //This is setting the initial text for our share card.
           [facebookSheet setInitialText:@"My IOS APP is working !!! :-) :D "];
            [facebookSheet addImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",[CommonClass sharedInstance].title]]];
            
            //Brings up the little share card with the test we have pre defind.
            [self presentViewController:facebookSheet animated:YES completion:nil];
            
        } else {
            //This alreat tells the user that they can't use built in socal interegration and why they can't.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't post a Facebook post right now, make sure you have at least one Facebook account setup and your device is using iOS6." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
    }
}
@end
