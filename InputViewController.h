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

#define ALPHA_MIN 0.4
#define D_BETWEEN_IMAGES 10.0
#define foodTableView_Y 200.0
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface InputViewController : UIViewController <ZenKeyboardDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (assign, nonatomic) BOOL onSearchScreen;
@property (strong, nonatomic) UIButton * button;
@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSArray * foods;
@property (strong, nonatomic) NSMutableArray * selectedRowsIndexPathes;
@property (strong, nonatomic) NSArray * foodsForSearch;
@property (assign, nonatomic) CGFloat alphaStep;
@property (strong, nonatomic) UISearchBar * searchBar;
@property (strong, nonatomic) UIImageView * foodView;
@property (strong, nonatomic) UIImageView * weightView;
@property (strong, nonatomic) ZenKeyboard * keyboard;
@property (strong, nonatomic) FoodTableView * foodTableView;

@end
