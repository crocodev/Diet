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
@synthesize foodTableView;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Добавляю индикатор подэкрана
    
    _foodView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _foodView];
    
    _weightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _weightView];
    _weightView.alpha =alphaMin;
    
    _foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
    _weightView.center = CGPointMake(_foodView.center.x+_foodView.frame.size.width+dBetweenImages, 100);
    
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
    
    foodTableView = [[FoodTableView alloc] initWithFrame: CGRectMake(0, 200, SCREEN_WIDTH, 132)];
    [foodTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTableView.delegate = self;
    foodTableView.dataSource = self;
    foodTableView.backgroundColor = [UIColor yellowColor];
    foodTableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.view addSubview:foodTableView];
    
    // Добавляю поиск
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"!!!" forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(0, -44, 44, 44);
    searchButton.backgroundColor = [UIColor redColor];
    [foodTableView addSubview:searchButton];

    
    // Добавляю клавиатуру
    
    CGRect frame = CGRectOffset(foodTableView.frame, SCREEN_WIDTH, 0);
    keyboard = [[ZenKeyboard alloc] initWithFrame: frame];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
    keyboard.label = label;
    
    
    // Добавляю распознаватель жестов для перехода между подэкранами
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGR];
    
    alphaStep = (1-alphaMin) / (_foodView.frame.size.width+dBetweenImages);
}

-(void) viewDidAppear:(BOOL)animated{
    foodTableView.contentSize = CGSizeMake(foodTableView.contentSize.width, 44*3);
    [foodTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void) search{
    [UIView animateWithDuration:0.2 animations:^{foodTableView.frame = self.view.frame;}];
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
    cell.backgroundColor = [UIColor greenColor];
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
            if (_foodView.alpha > alphaMin)
                _foodView.alpha -= alphaStep;
            if (_weightView.alpha < 1.0)
                _weightView.alpha += alphaStep;
            if ( _foodView.alpha > alphaMin){
                _foodView.frame = CGRectOffset(_foodView.frame, -1, 0);
                _weightView.frame = CGRectOffset(_weightView.frame, -1, 0);
            }
        } else {
            if (_foodView.alpha < 1.0)
                _foodView.alpha += alphaStep;
            if (_weightView.alpha > alphaMin)
                _weightView.alpha -= alphaStep;
            if ( _foodView.alpha < 1.0){
                _foodView.frame = CGRectOffset(_foodView.frame, 1, 0);
                _weightView.frame = CGRectOffset(_weightView.frame, 1, 0);
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_foodView.alpha >= (1-alphaMin)/2 + alphaMin){
            //Выбрано подменю блюд
            
            [UIView animateWithDuration:0.2 animations:^{
                _foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _weightView.center = CGPointMake(_foodView.center.x+_foodView.frame.size.width+dBetweenImages, 100);
                _foodView.alpha = 1.0;
                _weightView.alpha = alphaMin;
            }];
            [self hideKeyboard:YES];
        } else {
            //Выбрано подменю веса
            
            [UIView animateWithDuration:0.2 animations:^{
                _weightView.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _foodView.center =CGPointMake(_weightView.center.x-_foodView.frame.size.width-dBetweenImages, 100);
                _foodView.alpha = alphaMin;
                _weightView.alpha = 1.0;
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
