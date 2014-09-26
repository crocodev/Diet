//
//  StartViewController.h
//  Diet
//
//  Created by mriddi on 25.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

@interface StartViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) UITextField * currentWeight;
@property (strong, nonatomic) UITextField * aimWeight;

@end
