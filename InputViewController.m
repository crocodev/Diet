//
//  InputViewController.m
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "InputViewController.h"
#import "PNCircleChart.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Добавляю индикатор подэкрана
    _weightI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Weight"]];
    [self.view addSubview: _weightI];
    
    _foodI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Spoon and Fork"]];
    [self.view addSubview: _foodI];
    
    _weightI.frame = CGRectOffset(_weightI.frame, _foodI.frame.size.width + _foodI.frame.origin.x, 0);
    
    // Добавляю лэйбл ввода данных
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(100, 100, 200, 60)];
    label.backgroundColor = [UIColor grayColor];
    label.text = @"";
    [self.view addSubview:label];
    
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
    
    ZenKeyboard * keyboard = [[ZenKeyboard alloc] initWithFrame: self.view.frame];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
    keyboard.label = label;
    
    
    // Добавляю таблицу блюд
    
    FoodTableView * foodTV = [[FoodTableView alloc] initWithFrame: CGRectOffset(self.view.frame, 0, 200)];
    [foodTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTV.delegate = self;
    foodTV.dataSource = self;
    
    [self.view addSubview:foodTV];
    
    
    // Добавляю распознаватель жестов для перехода между подэкранами
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGR];
    
    
}

#pragma mark - ZenKeyboardDelegate

- (void) backspaceKeyDidPressed {
    
}

-(void) numericKeyDidPressed:(int)key{
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma  - Gesture recognizer

-(void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    float translation = [gestureRecognizer translationInView:self.view].x;
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // инициализация переменных
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (translation <= 0 ){
            _foodI.alpha = 1/fabsf(translation);
        } else {
            _weightI.alpha = 1/fabsf(translation);
        }
        
        _foodI.frame = CGRectOffset(_foodI.frame, translation/20, 0);
        _weightI.frame = CGRectOffset(_weightI.frame, translation/20, 0);
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // проверка на необходимость перехода на другой подэкран
    }

    NSLog(@"%f", _foodI.alpha);
}

@end
