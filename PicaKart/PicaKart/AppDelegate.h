//
//  AppDelegate.h
//  PicaKart
//
//  Created by Avinash Sevlani on 08/11/14.
//  Copyright (c) 2014 amstark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain)NSString* memberId;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)goToDashboard;


@end

