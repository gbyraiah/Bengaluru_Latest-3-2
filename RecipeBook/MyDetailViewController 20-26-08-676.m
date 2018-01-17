//
//  MyDetailViewController.m
//  Bengaluru
//
//  Created by Gouthami Byraiah on 3/31/15.
//
//

#import "MyDetailViewController 20-26-08-676.h"

@interface MyDetailViewController ()

@end

@implementation MyDetailViewController
@synthesize contactdb;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.contactdb) {
        [self.fullname setText:[self.contactdb valueForKey:@"fullname"]];
        [self.email setText:[self.contactdb valueForKey:@"email"]];
        [self.phone setText:[self.contactdb valueForKey:@"phone"]];
    }
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender {
       NSLog(@"Inside save");
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.contactdb) {
        // Update existing device
        [self.contactdb setValue:self.fullname.text forKey:@"fullname"];
        [self.contactdb setValue:self.email.text forKey:@"email"];
        [self.contactdb setValue:self.phone.text forKey:@"phone"];
        
    } else {
        NSLog(@"Inside save");
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"MyContact" inManagedObjectContext:context];
        [newDevice setValue:self.fullname.text forKey:@"fullname"];
        [newDevice setValue:self.email.text forKey:@"email"];
        [newDevice setValue:self.phone.text forKey:@"phone"];
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
