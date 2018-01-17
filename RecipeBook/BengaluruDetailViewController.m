//
//  RecipeDetailViewController.m
//  RecipeBook
//

#import "BengaluruDetailViewController.h"
#import "LinkViewController.h"

#define WIDTH_OF_SCROLL_PAGE [UIScreen mainScreen].bounds.size.width
#define HEIGHT_OF_SCROLL_PAGE [UIScreen mainScreen].bounds.size.height*0.35
#define WIDTH_OF_IMAGE [UIScreen mainScreen].bounds.size.width
#define HEIGHT_OF_IMAGE [UIScreen mainScreen].bounds.size.height*0.35
#define LEFT_EDGE_OFSET 0

@interface BengaluruDetailViewController ()

@end

@implementation BengaluruDetailViewController

@synthesize recipeLabel;
@synthesize recipeName;
@synthesize scrollView,slideImages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Do view manipulation here.
//    if (size.width>320) {
//        self.ingredientTextView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*0.75, [UIScreen mainScreen].bounds.size.height*0.5, self.ingredientTextView.frame.size.width, self.ingredientTextView.frame.size.height);
//    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
- (void)viewDidLoad
{
   
    [super viewDidLoad];

    self.title = [CommonClass sharedInstance].title;
	// Set the Label text with the selected recipe
    self.ingredientTextView.backgroundColor=[UIColor clearColor];
    [self.ingredientTextView setFont:[UIFont fontWithName:@"American Typewriter" size:15]];
    self.ingredientTextView.editable = NO;
    self.ingredientTextView.text =    [CommonClass sharedInstance].description;
    NSLog(@"%@",[NSString stringWithFormat:@"%@1.jpg",[CommonClass sharedInstance].title]);
   
    if ([CommonClass sharedInstance].totalNumber!=1) {
        self.detailPhoto.image=nil;
        [self loadScrollView ];

    }
    else{
         self.detailPhoto.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",[CommonClass sharedInstance].title]];
//        self.detailPhoto.contentMode = UIViewContentModeScaleAspectFit;
        self.detailPhoto.clipsToBounds=YES;
//        self.detailPhoto.layer.backgroundColor=[[UIColor clearColor] CGColor];
        self.detailPhoto.layer.cornerRadius=20;
        self.detailPhoto.layer.borderWidth=2.0;
       self.detailPhoto.layer.masksToBounds = YES;
        self.detailPhoto.layer.borderColor=[[UIColor blackColor] CGColor];

    }
    
   
//    UIToolbar *toolbar = [[UIToolbar alloc] init];
//    toolbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width, 44);
//    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"SHARE" style:UIBarButtonItemStyleDone target:self action:@selector(detailShare:)];
//      UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//     UIBarButtonItem *map = [[UIBarButtonItem alloc] initWithTitle:@"MAP" style:UIBarButtonItemStyleDone target:self action:@selector(mapShare:)];
//  UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *button2=[[UIBarButtonItem alloc]initWithTitle:@"LINK" style:UIBarButtonItemStyleDone target:self action:@selector(detailLink:)];
//    [toolbar setItems:[[NSArray alloc] initWithObjects:button1,spacer1,map,spacer2,button2,nil]];
//    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
//    [self.view addSubview:toolbar];
//    [self.view bringSubviewToFront:toolbar];
    
    
}
-(IBAction)mapShare:(id)sender{
    UIStoryboard*storyboardName=[UIStoryboard storyboardWithName:MAIN_STORYBOARD_ID bundle:nil];
    LinkViewController *link = [storyboardName instantiateViewControllerWithIdentifier:MAP_STORYBOARD_ID];
    [self.navigationController pushViewController:link animated:YES];
}
-(void)detailLink:(id)sender{
    UIStoryboard*storyboardName=[UIStoryboard storyboardWithName:MAIN_STORYBOARD_ID bundle:nil];
    LinkViewController *link = [storyboardName instantiateViewControllerWithIdentifier:CAPTURE_PICTURE_STORYBOARD_ID];
    [self.navigationController pushViewController:link animated:YES];

}
-(void)loadScrollView{
    CGRect scrollFrame;
    scrollFrame.origin.x = 0;
    scrollFrame.origin.y = HEIGHT_OF_SCROLL_PAGE*0.4;
    scrollFrame.size.width = WIDTH_OF_SCROLL_PAGE;
    scrollFrame.size.height = HEIGHT_OF_SCROLL_PAGE;
	
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
	scrollView.tag=-100;
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,[CommonClass sharedInstance].totalNumber]];
    for (int i=1; i<=[CommonClass sharedInstance].totalNumber; i++) {
        [slideImages addObject:[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,i]];
    }
    [slideImages addObject:[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,1]];

    //add the last image first
    UIImageView *imageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
	imageView.tag=0;
	
    [scrollView addSubview:imageView];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
   imageView.clipsToBounds=YES;
//    imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imageView.layer.cornerRadius=20;
    imageView.layer.borderWidth=2.0;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor=[[UIColor blackColor] CGColor];
	
    for (int i = 0;i<[slideImages count];i++) {
        //loop this bit
        UIImageView *imageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((WIDTH_OF_IMAGE * i) + LEFT_EDGE_OFSET , 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
		imageView.tag=i;
		
		[scrollView addSubview:imageView];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
//        imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
        imageView.layer.cornerRadius=20;
        imageView.layer.borderWidth=2.0;
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderColor=[[UIColor blackColor] CGColor];
        //
		
    }
	
    //add the first image at the end
    imageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
	imageView.frame = CGRectMake((WIDTH_OF_IMAGE * ([slideImages count] )) + LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
	imageView.tag=[slideImages count];
	
	//imageView.frame = CGRectMake((WIDTH_OF_IMAGE * ([slideImages count] + 1)) + LEFT_EDGE_OFSET, 0, WIDTH_OF_IMAGE, HEIGHT_OF_IMAGE);
    [scrollView addSubview:imageView];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds=YES;
//    imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imageView.layer.cornerRadius=20;
    imageView.layer.borderWidth=2.0;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor=[[UIColor blackColor] CGColor];
	
	[scrollView setContentSize:CGSizeMake(WIDTH_OF_SCROLL_PAGE * ([slideImages count] +2), HEIGHT_OF_IMAGE)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
	
    [scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
    currentPage = 1;
	[self cleanUp];

}
-(void)enableScroll {
	
	[scrollView setUserInteractionEnabled:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)_scrollView {
	[_scrollView setUserInteractionEnabled:NO];
	[self performSelector:@selector(enableScroll) withObject:nil afterDelay:1.0];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
	currentPage = floor((_scrollView.contentOffset.x - _scrollView.frame.size.width / ([slideImages count]+2)) / self.scrollView.frame.size.width) + 1;
	if (currentPage == 0) {
		//go last but 1 page
		currentPage=[CommonClass sharedInstance].totalNumber;
		
		[scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE * [CommonClass sharedInstance].totalNumber,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
	}
	else if(currentPage == [CommonClass sharedInstance].totalNumber+1) {
		currentPage = 1;
		[scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
	}
	else if (currentPage==([slideImages count]+1)) {
		[scrollView scrollRectToVisible:CGRectMake(WIDTH_OF_IMAGE,0,WIDTH_OF_IMAGE,HEIGHT_OF_IMAGE) animated:NO];
	}
	[self cleanUp];
	
	
}

-(void)cleanUp
{
	for (int i=0; i<[slideImages count]; i++)
	{
		UIImageView *img = (UIImageView *)[scrollView viewWithTag:i];
		
		if(i==currentPage || i==currentPage-1 || i==currentPage+1)
		{
			
			if(img.image==nil)
			{
				img.image=[UIImage imageNamed:[slideImages objectAtIndex:i]];
			}
		}
		else {
			img.image=nil;
		}
		
	}
}

-(IBAction)detailShare:(id)sender    {
        NSString *text = [CommonClass sharedInstance].title;
    
    
    NSLog(@"%@",[CommonClass sharedInstance].link);

//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[CommonClass sharedInstance].link]];
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,1]);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.jpg",[CommonClass sharedInstance].title,1]];
        
        UIActivityViewController *controller =
        [[UIActivityViewController alloc]
         initWithActivityItems:@[text, image]
         applicationActivities:nil];
        
        controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                             UIActivityTypeMessage,
                                             UIActivityTypeMail,
                                             UIActivityTypePrint,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo,
                                             UIActivityTypePostToTencentWeibo,
                                             UIActivityTypeAirDrop];
        
        [self presentViewController:controller animated:YES completion:nil];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    if (interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        //Code
//    }
//    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight||interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        //Code
//    }
//}
-(BOOL)shouldAutorotate{
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
