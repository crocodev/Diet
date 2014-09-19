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

@interface InputViewController : UIViewController <ZenKeyboardDelegate, UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) CGFloat alphaStep;
@property (strong, nonatomic) UIImageView *foodIV;
@property (strong, nonatomic) UIImageView *weightIV;
@property (strong, nonatomic) ZenKeyboard * keyboard;


@end
