//
//  InputViewController.m
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "InputViewController.h"
#import "PNCircleChart.h"
#import "ZenKeyboard.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Добавляю таблицу блюд
    CGRect frame = CGRectOffset(self.view.frame, 0, 200);
    
    FoodTableViewController * foodTVC = [[FoodTableViewController alloc] init];
    FoodTableView * foodTV = [[FoodTableView alloc] initWithFrame: frame];
    [foodTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTV.delegate = foodTVC;
    foodTV.dataSource = foodTVC;
    foodTVC.view=foodTV;
    
    [self addChildViewController:foodTVC];
    [self.view addSubview:foodTVC.view];
    
    // Добавляю графики
    
    PNCircleChart * consumptionChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:60] andClockwise:YES andShadow:YES];
    consumptionChart.backgroundColor = [UIColor clearColor];
    [consumptionChart setStrokeColor:PNGreen];
    [consumptionChart strokeChart];
    
    PNCircleChart * progressChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(80, 80.0, SCREEN_WIDTH, 100.0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:60] andClockwise:YES andShadow:YES];
    progressChart.backgroundColor = [UIColor clearColor];
    [progressChart setStrokeColor:PNGreen];
    [progressChart strokeChart];
    
    [self.view addSubview:consumptionChart];
    [self.view addSubview:progressChart];
    
    // Добавляю клавиатуру
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(100, 100, 200, 60)];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    
    ZenKeyboard * keyboard = [[ZenKeyboard alloc] initWithFrame: self.view.frame];
    [self.view addSubview:keyboard];
    
    keyboard.label = label;
    label.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
