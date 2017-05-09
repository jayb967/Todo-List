//
//  AppDelegate.h
//  Cross-platform-todo-list
//
//  Created by Rio Balderas on 5/9/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

