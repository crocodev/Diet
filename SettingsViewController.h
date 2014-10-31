//
//  SettingsViewController.h
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView * logTableView;      
@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) Diet * diet;
@property (strong, nonatomic) NSMutableArray * logData;
@property (strong, nonatomic) NSMutableArray * logSections;

@end
