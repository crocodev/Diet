//
//  InputViewController.h
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodTableView.h"
#import "ZenKeyboard.h"

@interface InputViewController : UIViewController <ZenKeyboardDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *foodI;
@property (strong, nonatomic) UIImageView *weightI;

@end
