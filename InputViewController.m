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

@synthesize keyboard;
@synthesize alphaStep;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Добавляю индикатор подэкрана
    _foodIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _foodIV];
    
    _weightIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _weightIV];
    _weightIV.alpha =alphaMin;
    
    _foodIV.center = CGPointMake(SCREEN_WIDTH/2, 100);
    _weightIV.center = CGPointMake(_foodIV.center.x+_foodIV.frame.size.width+dBetweenImages, 100);
    
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
    
    
    // Добавляю таблицу блюд
    
    FoodTableView * foodTV = [[FoodTableView alloc] initWithFrame: CGRectOffset(self.view.frame, 0, 200)];
    [foodTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTV.delegate = self;
    foodTV.dataSource = self;
    
    [self.view addSubview:foodTV];
    
    
    // Добавляю клавиатуру
    
    CGRect frame = CGRectOffset(foodTV.frame, SCREEN_WIDTH, 0);
    keyboard = [[ZenKeyboard alloc] initWithFrame: frame];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
    keyboard.label = label;
    
    
    // Добавляю распознаватель жестов для перехода между подэкранами
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGR];
    
    alphaStep = (1-alphaMin) / (_foodIV.frame.size.width+dBetweenImages);
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
//    float translation = [gestureRecognizer translationInView:self.view].x;
    float velocity = [gestureRecognizer velocityInView:self.view].x;

    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {

    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (velocity <= 0){
            if (_foodIV.alpha > alphaMin)
                _foodIV.alpha -= alphaStep;
            if (_weightIV.alpha < 1.0)
                _weightIV.alpha += alphaStep;
            if ( _foodIV.alpha > alphaMin){
                _foodIV.frame = CGRectOffset(_foodIV.frame, -1, 0);
                _weightIV.frame = CGRectOffset(_weightIV.frame, -1, 0);
            }
        } else {
            if (_foodIV.alpha < 1.0)
                _foodIV.alpha += alphaStep;
            if (_weightIV.alpha > alphaMin)
                _weightIV.alpha -= alphaStep;
            if ( _foodIV.alpha < 1.0){
                _foodIV.frame = CGRectOffset(_foodIV.frame, 1, 0);
                _weightIV.frame = CGRectOffset(_weightIV.frame, 1, 0);
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_foodIV.alpha >= (1-alphaMin)/2 + alphaMin){
            //Выбрано подменю блюд
            
            [UIView animateWithDuration:0.2 animations:^{
                _foodIV.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _weightIV.center = CGPointMake(_foodIV.center.x+_foodIV.frame.size.width+dBetweenImages, 100);
                _foodIV.alpha = 1.0;
                _weightIV.alpha = alphaMin;
            }];
            [self hideKeyboard:YES];
        } else {
            //Выбрано подменю веса
            
            [UIView animateWithDuration:0.2 animations:^{
                _weightIV.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _foodIV.center =CGPointMake(_weightIV.center.x-_foodIV.frame.size.width-dBetweenImages, 100);
                _foodIV.alpha = alphaMin;
                _weightIV.alpha = 1.0;
            }];
            [self hideKeyboard:NO];
        }
    }
}

-(void) hideKeyboard: (BOOL) hide{
    if (hide){
        keyboard.frame = CGRectMake(SCREEN_WIDTH, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
    } else {
        keyboard.frame = CGRectMake(0, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
    }
}
@end
