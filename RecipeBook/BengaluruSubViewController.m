

#import "BengaluruSubViewController.h"
#import "BengaluruDetailViewController.h"

@interface BengaluruSubViewController ()

@end

@implementation BengaluruSubViewController {
    NSArray *ListArray;
}


@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    self.title =[CommonClass sharedInstance].mainListString;

    [super viewDidLoad];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Bengalaru" ofType:@"plist"];
    NSDictionary*dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	// Initialize table data

    ListArray=[dictionary valueForKey:[CommonClass sharedInstance].mainListString];

}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ListArray count]/4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"BookCell";
    
    BengaluruBookTableViewCell *cell = (BengaluruBookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[BengaluruBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
//    NSLog(@"%d",indexPath.row*4);
//    NSLog(@"%@",[ListArray objectAtIndex:indexPath.row*4]);
    UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",[ListArray objectAtIndex:indexPath.row*4]]];
    CGSize size=CGSizeMake(40, 40);//set the width and height
    UIImage *resizedImage= [self resizeImage:image imageSize:size];
    cell.self.imageView.image=resizedImage;
//    cell.self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.self.imageView.clipsToBounds=YES;
//    cell.self.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.self.imageView.layer.cornerRadius=20;
    cell.self.imageView.layer.borderWidth=2.0;
    cell.self.imageView.layer.masksToBounds = YES;
    cell.self.imageView.layer.borderColor=[[UIColor blackColor] CGColor];
    cell.textView.text = [ListArray objectAtIndex:indexPath.row*4];
    cell.textView.textColor=[UIColor blackColor];
    [cell.textView setFont:[UIFont fontWithName:@"American Typewriter" size:20]];
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*3, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor grayColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];

    return cell;
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [CommonClass sharedInstance].title=[ListArray objectAtIndex:indexPath.row*4];
    [CommonClass sharedInstance].description=[ListArray objectAtIndex:(indexPath.row*4)+1];
    [CommonClass sharedInstance].link=[ListArray objectAtIndex:(indexPath.row*4)+2];
    [CommonClass sharedInstance].totalNumber=[[ListArray objectAtIndex:(indexPath.row*4)+3] integerValue];
    NSLog(@"%@",[CommonClass sharedInstance].link);

    if ([segue.identifier isEqualToString:@"showBookDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BengaluruDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipeName = [ListArray objectAtIndex:indexPath.row];

        // Hide bottom tab bar in the detail view
      //  destViewController.hidesBottomBarWhenPushed = YES;
    }
}


@end
