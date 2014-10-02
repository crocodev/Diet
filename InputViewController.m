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

@synthesize keyboard,alphaStep,foodTableView,searchBar,foods,label,button, foodsForSearch, onSearchScreen, selectedRowsIndexPathes, onWeightScreen, foodView, weightView, weightToAdd, tapGR, diet, managedObjectContext;


#pragma mark - Inicialize


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Инициализация переменных
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription * dietDescription = [NSEntityDescription entityForName:@"Diet" inManagedObjectContext: managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:dietDescription];
    diet = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self foods];
    onSearchScreen = NO;
    onWeightScreen = NO;
    alphaStep = (1-ALPHA_MIN) / (foodView.frame.size.width+D_BETWEEN_IMAGES);

    // Добавляю индикатор подэкрана
    
    foodView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    foodView.userInteractionEnabled =YES;
    [self.view addSubview: foodView];
    
    weightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Test"]];
    weightView.userInteractionEnabled =YES;
    [self.view addSubview: weightView];
    weightView.alpha =ALPHA_MIN;
    
    foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
    weightView.center = CGPointMake(foodView.center.x+foodView.frame.size.width+D_BETWEEN_IMAGES, 100);
    
    // Добавляю лэйбл
    
    label = [[UILabel alloc] initWithFrame: CGRectMake(100, 100, 200, 60)];
    label.backgroundColor = [UIColor grayColor];
    label.text = @"";
    label.alpha = 0;
    [self.view addSubview:label];
    
    // Добавляю графики
    
    PNCircleChart * consumptionChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/4, SCREEN_WIDTH/4) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:60] andClockwise:YES andShadow:YES];
    consumptionChart.backgroundColor = [UIColor clearColor];
    [consumptionChart setStrokeColor:PNGreen];
    [consumptionChart strokeChart];
    
    PNCircleChart * progressChart = [[PNCircleChart alloc] initWithFrame:CGRectOffset(consumptionChart.frame, 115, 0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:60] andClockwise:YES andShadow:YES];
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
    
    // Добавляю кнопку
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action: @selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor grayColor]];
    button.frame = CGRectMake(0.0, 450.0, SCREEN_WIDTH, 40.0);
    [self.view addSubview:button];
    
    // Добавляю распознаватель жестов для перехода между подэкранами
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePanGesture:)];
    tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGR.delegate = self;
    [self.view addGestureRecognizer:panGR];
    [self.view addGestureRecognizer:tapGR];
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
    if (sender == keyboard){
        label.text = [NSString stringWithFormat:@"%@ кг", string];
        weightToAdd = [NSNumber numberWithFloat:[string floatValue]];
    } else{
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
    if (![label.text isEqualToString:@""] && label) {
        
        // Добавление данных в базу
        
        if ([label.text containsString:@"очков"]){
            for (NSIndexPath * indexPath in foodTableView.indexPathsForSelectedRows){
                NSEntityDescription * pointsHistoryDescription = [NSEntityDescription entityForName:@"PointsHistory" inManagedObjectContext: managedObjectContext];
                PointsHistory * pointsHistory = [[PointsHistory alloc] initWithEntity: pointsHistoryDescription insertIntoManagedObjectContext: managedObjectContext];
                
                pointsHistory.date = [NSDate date];
                pointsHistory.foodName =[[[[foods objectAtIndex:indexPath.section] objectForKey:@"foods"] objectAtIndex:indexPath.row] objectForKey:@"foodName"];
                pointsHistory.points = [[[[foods objectAtIndex:indexPath.section] objectForKey:@"foods"] objectAtIndex:indexPath.row] objectForKey:@"points"];
                pointsHistory.toDiet = [diet objectAtIndex:0];
                
                [foodTableView deselectRowAtIndexPath:indexPath animated:NO];
                NSLog(@"%@", [pointsHistory description]);
            }
            label.text = @"";
            label.alpha = 0;
        } else {
            NSEntityDescription * weightHistoryDescription = [NSEntityDescription entityForName:@"WeightHistory" inManagedObjectContext: managedObjectContext];
            WeightHistory * weightHistory = [[WeightHistory alloc] initWithEntity: weightHistoryDescription insertIntoManagedObjectContext: managedObjectContext];
            
            weightHistory.date = [NSDate date];
            weightHistory.weight = weightToAdd;
            weightHistory.toDiet = [diet objectAtIndex:0];
            
            [self hideKeyboard];
            NSLog(@"%@", [weightHistory description]);
        }
        [managedObjectContext save:nil];
        
        
        NSLog(@"%@", [diet description]);
        
        // Вывод прогресса диеты и обновление его графика
        
        // Вывод осатка дневных очков и обновление его графика
        
        // Проверка условий перехода на новый этап
        
        
    }
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

-(void) selectLeftScreen{
    [UIView animateWithDuration:0.2 animations:^{
        foodView.center = CGPointMake(SCREEN_WIDTH/2, 100);
        weightView.center = CGPointMake(foodView.center.x+foodView.frame.size.width+D_BETWEEN_IMAGES, 100);
        foodView.alpha = 1.0;
        weightView.alpha = ALPHA_MIN;
    }];
    [self hideKeyboard];
}

-(void) selectRightScreen{
    [UIView animateWithDuration:0.2 animations:^{
        weightView.center = CGPointMake(SCREEN_WIDTH/2, 100);
        foodView.center =CGPointMake(weightView.center.x-foodView.frame.size.width-D_BETWEEN_IMAGES, 100);
        foodView.alpha = ALPHA_MIN;
        weightView.alpha = 1.0;
    }];
    [self showKeybord];
}


#pragma mark - Gesture Recognizers

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ((touch.view == foodView || touch.view == weightView) && gestureRecognizer == tapGR)
        return YES;
    else{
        return NO;
        
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    float velocity = [gestureRecognizer velocityInView:self.view].x;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (velocity <= 0){
            if (foodView.alpha > ALPHA_MIN)
                foodView.alpha -= alphaStep;
            if (weightView.alpha < 1.0)
                weightView.alpha += alphaStep;
            if ( foodView.alpha > ALPHA_MIN){
                foodView.frame = CGRectOffset(foodView.frame, -1, 0);
                weightView.frame = CGRectOffset(weightView.frame, -1, 0);
            }
        } else {
            if (foodView.alpha < 1.0)
                foodView.alpha += alphaStep;
            if (weightView.alpha > ALPHA_MIN)
                weightView.alpha -= alphaStep;
            if ( foodView.alpha < 1.0){
                foodView.frame = CGRectOffset(foodView.frame, 1, 0);
                weightView.frame = CGRectOffset(weightView.frame, 1, 0);
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (foodView.alpha >= (1-ALPHA_MIN)/2 + ALPHA_MIN){
            //Выбрано подменю блюд
            [self selectLeftScreen];
        } else {
            //Выбрано подменю веса
            [self selectRightScreen];
        }
    }
}

-(void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer{
    if (CGRectContainsPoint(foodView.frame, [gestureRecognizer locationInView:self.view]) || CGRectContainsPoint(weightView.frame, [gestureRecognizer locationInView:self.view])) {
        if(onWeightScreen)
            [self selectLeftScreen];
        else
            [self selectRightScreen];
    }
}

@end
