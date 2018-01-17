//
//  MyContactsAppDelegate.h
//  MyContacts
//
//  Created by Charles Konkol on 11/10/13.
//  Copyright (c) 2013 Chuck Konkol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyContactsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
