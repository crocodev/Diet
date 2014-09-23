//
//  InputViewController.m
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "InputViewController.h"
#import "PNCircleChart.h"


@implementation InputViewController

@synthesize keyboard,alphaStep,foodTableView,searchBar,foods,label,button;

#pragma mark - Inicialize

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Загрузка блюд
    
    [self foods];
    
    // Добавляю индикатор подэкрана
    
    _foodView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _foodView];
    
    _weightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _weightView];
    _weightView.alpha =alphaMin;
    
    _foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
    _weightView.center = CGPointMake(_foodView.center.x+_foodView.frame.size.width+dBetweenImages, 100);
    
    // Добавляю лэйбл ввода данных
    
    label = [[UILabel alloc] initWithFrame: CGRectMake(100, 100, 200, 60)];
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

    foodTableView = [[FoodTableView alloc] initWithFrame: CGRectMake(0, 200, SCREEN_WIDTH,[UIScreen mainScreen].bounds.size.height-200)];
    [foodTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTableView.delegate = self;
    foodTableView.dataSource = self;
    foodTableView.backgroundColor = [UIColor yellowColor];
    foodTableView.allowsMultipleSelection = YES;
    [self.view addSubview:foodTableView];
    
    // Добавляю поиск
    
    searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    foodTableView.tableHeaderView = searchBar;
    foodTableView.contentOffset = CGPointMake(0, CGRectGetHeight(searchBar.frame));
    
    // Добавляю клавиатуру
    
    CGRect frame = CGRectOffset(foodTableView.frame, SCREEN_WIDTH, 0);
    keyboard = [[ZenKeyboard alloc] initWithFrame: frame];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
    
    
    // Добавляю распознаватель жестов для перехода между подэкранами
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGR];
    
    alphaStep = (1-alphaMin) / (_foodView.frame.size.width+dBetweenImages);
    
    // Добавляю кнопку "Добавить"
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action: @selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}


#pragma mark - UITableViewDelegate and UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [foods count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray*)[[foods objectAtIndex:section] objectForKey:@"foods"] count] ;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[foods objectAtIndex:section] objectForKey:@"foodCategory"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.textLabel.text = [[[[foods objectAtIndex:indexPath.section] objectForKey:@"foods"] objectAtIndex:indexPath.row] objectForKey:@"foodName"];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self chanheLabelTextTo:nil bySender:nil];
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self chanheLabelTextTo:nil bySender:nil];
}

#pragma mark - Gesture recognizer

-(void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
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


#pragma mark - SearchBarDelegate


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"foodName contains[c] %@", searchText];
    foods = [foods filteredArrayUsingPredicate:resultPredicate];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText scope:nil];
    [foodTableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar {
    [UIView animateWithDuration:0.2 animations:^{foodTableView.frame = self.view.frame;}];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.2 animations:^{foodTableView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 132);}];
    [self.searchBar resignFirstResponder];
}

#pragma mark - ZenKeyboardDelegate

-(void) chanheLabelTextTo:(NSString *) string bySender: (id) sender{
    if (sender == keyboard)
        label.text = [NSString stringWithFormat:@"%@ кг", string];
    else{
        int i = 0;
        for (NSIndexPath * indexPath in foodTableView.indexPathsForSelectedRows){
            i+= [(NSNumber*)[[[[foods objectAtIndex:indexPath.section] objectForKey:@"foods"] objectAtIndex:indexPath.row] objectForKey:@"points"] integerValue];
        }
        label.text = [NSString stringWithFormat:@"%i очков", i];
    }
}

#pragma mark - Other methods

-(NSArray *) foods{
    if (!foods) {
        foods = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Food" ofType:@"plist"]];
    }
    return foods;
}

- (void) buttonPushed: (UIButton *) sender{

    // Внесение данных
    
    // Проверки
    
}

-(void) hideKeyboard: (BOOL) hide{
    if (hide){
        keyboard.frame = CGRectMake(SCREEN_WIDTH, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
        [button setTitle:@"Add" forState:UIControlStateNormal];
    } else {
        keyboard.frame = CGRectMake(0, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
        [button setTitle:@"Sub" forState:UIControlStateNormal];
    }
}
@end
