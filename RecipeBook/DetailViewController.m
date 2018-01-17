//
//  DetailViewController.m
//  Bengaluru1
//
//  Created by Gouthami Byraiah on 4/3/15.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize contactdb;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
        NSLog(@"%@",context);
    }
    return context;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
     if (self.contactdb) {
        [self.fullname setText:[self.contactdb valueForKey:@"fullname"]];
        [self.email setText:[self.contactdb valueForKey:@"email"]];
        [self.phone setText:[self.contactdb valueForKey:@"phone"]];
    }
 //   self.contactarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
  //  [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   /* if (self.contactdb) {
        [self.fullname setText:[self.contactdb valueForKey:@"fullname"]];
        [self.email setText:[self.contactdb valueForKey:@"email"]];
        [self.phone setText:[self.contactdb valueForKey:@"phone"]];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender {
    
        NSManagedObjectContext *context = [self managedObjectContext];
   
    if (self.contactdb) {
        // Update existing device
        [self.contactdb setValue:self.fullname.text forKey:@"fullname"];
        [self.contactdb setValue:self.email.text forKey:@"email"];
        [self.contactdb setValue:self.phone.text forKey:@"phone"];
     
    } else {
        // Create a new device
 
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"
                                                               inManagedObjectContext:context];
      
        [newDevice setValue:self.fullname.text forKey:@"fullname"];
        [newDevice setValue:self.email.text forKey:@"email"];
        [newDevice setValue:self.phone.text forKey:@"phone"];
          NSLog(@"Inside Save %@ ",newDevice);
   }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
