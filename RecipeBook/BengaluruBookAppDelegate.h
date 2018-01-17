//
//  RecipeBookAppDelegate.h
//  RecipeBook
//
#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <CoreData/CoreData.h>


@interface BengaluruBookAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
