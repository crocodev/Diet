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

#define alphaMin 0.4
#define dBetweenImages 10.0

@interface InputViewController : UIViewController <ZenKeyboardDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (assign, nonatomic) CGFloat alphaStep;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIImageView *foodView;
@property (strong, nonatomic) UIImageView *weightView;
@property (strong, nonatomic) ZenKeyboard * keyboard;
@property (strong, nonatomic) FoodTableView * foodTableView;

@end
