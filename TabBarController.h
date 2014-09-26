//
//  TabBarController.h
//  Diet
//
//  Created by mriddi on 26.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@interface TabBarController : UITabBarController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
