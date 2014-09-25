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

@synthesize keyboard,alphaStep,foodTableView,searchBar,foods,label,button, foodsForSearch, onSearchScreen, selectedRowsIndexPathes, onWeightScreen;


#pragma mark - Inicialize


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Инициализация переменных
    
    [self foods];
    onSearchScreen = NO;
    onWeightScreen = NO;
    
    // Добавляю индикатор подэкрана
    
    _foodView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _foodView];
    
    _weightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    [self.view addSubview: _weightView];
    _weightView.alpha =ALPHA_MIN;
    
    _foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
    _weightView.center = CGPointMake(_foodView.center.x+_foodView.frame.size.width+D_BETWEEN_IMAGES, 100);
    
    // Добавляю лэйбл
    
    label = [[UILabel alloc] initWithFrame: CGRectMake(100, 100, 200, 60)];
    label.backgroundColor = [UIColor grayColor];
    label.text = @"";
    label.alpha = 0;
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
    
    
    // Добавляю таблицу

    foodTableView = [[FoodTableView alloc] initWithFrame: CGRectMake(0, foodTableView_Y, SCREEN_WIDTH,SCREEN_HEIGHT-foodTableView_Y)];
    [foodTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    foodTableView.delegate = self;
    foodTableView.dataSource = self;
    foodTableView.backgroundColor = [UIColor yellowColor];
    foodTableView.allowsMultipleSelection = YES;
    [self.view addSubview:foodTableView];
    
    // Добавляю поиск
    
    searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.delegate = self;
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
    
    alphaStep = (1-ALPHA_MIN) / (_foodView.frame.size.width+D_BETWEEN_IMAGES);
    
    // Добавляю кнопку
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action: @selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor grayColor]];
    button.frame = CGRectMake(0.0, 450.0, SCREEN_WIDTH, 40.0);
    [self.view addSubview:button];
}


#pragma mark - UITableViewDelegate and UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (onSearchScreen)
        return 1;
    else
        return [foods count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (onSearchScreen)
        return [foodsForSearch count];
    else
        return [(NSArray*)[[foods objectAtIndex:section] objectForKey:@"foods"] count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (onSearchScreen)
        return nil;
    else
        return [[foods objectAtIndex:section] objectForKey:@"foodCategory"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    if (onSearchScreen)
        cell.textLabel.text = [[foodsForSearch objectAtIndex:indexPath.row] objectForKey:@"foodName"];
    else
        cell.textLabel.text = [[[[foods objectAtIndex:indexPath.section] objectForKey:@"foods"] objectAtIndex:indexPath.row] objectForKey:@"foodName"];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (onSearchScreen){
        [selectedRowsIndexPathes addObject:[[foodsForSearch objectAtIndex:indexPath.row] valueForKey:@"indexPath"]];
        [self hideSearchScreen];
    }
    else{
        [self changeLabelTextTo:nil bySender:nil];
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self changeLabelTextTo:nil bySender:nil];
}


#pragma mark - SearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        [self foods];
    }else{
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"foodName CONTAINS[cd] %@", searchText];
        foodsForSearch = [foodsForSearch filteredArrayUsingPredicate:searchPredicate];
    }
    [foodTableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar {
    [self showSearchScreen];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self hideSearchScreen];
}


#pragma mark - ZenKeyboardDelegate


-(void) changeLabelTextTo:(NSString *) string bySender: (id) sender{
    label.alpha = 1;
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
    foods = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Food" ofType:@"plist"]];
    
    int section = 0;
    int row = 0;
    
    NSMutableArray * buffer = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in foods){
        for(NSDictionary * dicc in [dic objectForKey:@"foods"]){
            
            NSMutableDictionary * md = [NSMutableDictionary dictionaryWithDictionary:dicc];
            [md setValue:[NSIndexPath indexPathForItem:row inSection:section] forKey:@"indexPath"];
            
            
            [buffer addObject:[md copy]];
            row++;
        }
        row = 0;
        section++;
    }
    
    foodsForSearch = [NSArray arrayWithArray:buffer];
    return foods;
}

- (void) buttonPushed: (UIButton *) sender{

    
    // Внесение данных
    
    // Проверки
    
}

- (void) showSearchScreen{
    searchBar.showsCancelButton = YES;
    selectedRowsIndexPathes = [[NSMutableArray alloc] initWithArray:[foodTableView indexPathsForSelectedRows]];
    [UIView animateWithDuration:0.2 animations:^{foodTableView.frame = self.view.frame;}];
    onSearchScreen = YES;
    [foodTableView reloadData];

}

- (void) hideSearchScreen{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{foodTableView.frame = CGRectMake(0, foodTableView_Y, SCREEN_WIDTH, SCREEN_HEIGHT-foodTableView_Y);}];
    onSearchScreen = NO;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:
     ^(){
         for (NSIndexPath * indexPath in selectedRowsIndexPathes){
             [foodTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
             [self changeLabelTextTo:nil bySender:nil];
         }
     }];
    [foodTableView reloadData];
    [CATransaction commit];
}

- (void) showKeybord{
    keyboard.frame = CGRectMake(0, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
    [button setTitle:@"Sub" forState:UIControlStateNormal];
    if(!onWeightScreen){
        label.text = @"";
        label.alpha = 0;
    }
    [foodTableView reloadData];
    onWeightScreen = YES;
}

- (void) hideKeyboard{
    keyboard.frame = CGRectMake(SCREEN_WIDTH, keyboard.frame.origin.y, keyboard.frame.size.width, keyboard.frame.size.height);
    if (onWeightScreen) {
        label.text = @"";
        label.alpha = 0;
    }
    [button setTitle:@"Add" forState:UIControlStateNormal];
    onWeightScreen = NO;
}



#pragma mark - Gesture recognizer


-(void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    float velocity = [gestureRecognizer velocityInView:self.view].x;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (velocity <= 0){
            if (_foodView.alpha > ALPHA_MIN)
                _foodView.alpha -= alphaStep;
            if (_weightView.alpha < 1.0)
                _weightView.alpha += alphaStep;
            if ( _foodView.alpha > ALPHA_MIN){
                _foodView.frame = CGRectOffset(_foodView.frame, -1, 0);
                _weightView.frame = CGRectOffset(_weightView.frame, -1, 0);
            }
        } else {
            if (_foodView.alpha < 1.0)
                _foodView.alpha += alphaStep;
            if (_weightView.alpha > ALPHA_MIN)
                _weightView.alpha -= alphaStep;
            if ( _foodView.alpha < 1.0){
                _foodView.frame = CGRectOffset(_foodView.frame, 1, 0);
                _weightView.frame = CGRectOffset(_weightView.frame, 1, 0);
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_foodView.alpha >= (1-ALPHA_MIN)/2 + ALPHA_MIN){
            //Выбрано подменю блюд
            
            [UIView animateWithDuration:0.2 animations:^{
                _foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _weightView.center = CGPointMake(_foodView.center.x+_foodView.frame.size.width+D_BETWEEN_IMAGES, 100);
                _foodView.alpha = 1.0;
                _weightView.alpha = ALPHA_MIN;
            }];
            [self hideKeyboard];
        } else {
            //Выбрано подменю веса
            
            [UIView animateWithDuration:0.2 animations:^{
                _weightView.center = CGPointMake(SCREEN_WIDTH/2, 100);
                _foodView.center =CGPointMake(_weightView.center.x-_foodView.frame.size.width-D_BETWEEN_IMAGES, 100);
                _foodView.alpha = ALPHA_MIN;
                _weightView.alpha = 1.0;
            }];
            [self showKeybord];
        }
    }
}

@end
