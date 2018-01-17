

#import "BengaluruBookViewController.h"
#import "BengaluruDetailViewController.h"

@interface BengaluruSubViewController ()

@end

@implementation BengaluruBookViewController {
    NSArray *ListArray;
}


@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Bengalaru" ofType:@"plist"];
    NSDictionary*dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	// Initialize table data
    ListArray=[dictionary valueForKey:@"NameList"];

}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];

}

- (void)viewDidUnload
{
    
         [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
   
}

-(BOOL)shouldAutorotate{
  
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ListArray count];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    RecipeBookTableViewCell *cell = (RecipeBookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[RecipeBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    int random=arc4random()%16;
    random=random+1;
    UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1.jpg",[ListArray objectAtIndex:indexPath.row]]];
    CGSize size=CGSizeMake(110, 110);//set the width and height
    UIImage *resizedImage= [self resizeImage:image imageSize:size];
    cell.self.imageView.image=resizedImage;
    cell.self.imageView.clipsToBounds=YES;
    cell.self.imageView.layer.cornerRadius=20;
    cell.self.imageView.layer.borderWidth=2.0;
    cell.self.imageView.layer.masksToBounds = YES;
    cell.self.imageView.layer.borderColor=[[UIColor blackColor] CGColor];
    cell.textView.text = [ListArray objectAtIndex:indexPath.row];
    [cell.textView setFont:[UIFont fontWithName:@"American Typewriter" size:22]];
  
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*3, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor grayColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [CommonClass sharedInstance].mainListString=[ListArray objectAtIndex:indexPath.row];

    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [CommonClass sharedInstance].mainListString=[ListArray objectAtIndex:indexPath.row];
        NSLog(@"%@",[CommonClass sharedInstance].mainListString);
        BengaluruDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipeName = [ListArray objectAtIndex:indexPath.row];

        // Hide bottom tab bar in the detail view
      //  destViewController.hidesBottomBarWhenPushed = YES;
    }
}


@end
