//
//  SettingsViewController.m
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize logTableView, diet, managedObjectContext, sectionsTitles, dataDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Добавляю таблицу лога
    
    logTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    [logTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    logTableView.delegate = self;
    logTableView.dataSource = self;
    logTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logTableView];
    
    // Инициализация переменных
    
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription * dietDescription = [NSEntityDescription entityForName:@"Diet" inManagedObjectContext: managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:dietDescription];
    diet = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    [self loadData];
}


-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"1");
    [logTableView reloadData];
}

-(void) loadData{
    dataDictionary = [[NSMutableDictionary alloc] init];
    
    // Объединение наборов
    
    NSMutableSet * set = [NSMutableSet setWithSet:diet.toPointsHistory];
    [set addObjectsFromArray:[diet.toWeightHistory allObjects]];
    NSMutableArray * logData  = [NSMutableArray arrayWithArray: [set allObjects]];
    [logData sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    
    // Массив дат
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"dd.MM.yyyy"];
    sectionsTitles = [[NSMutableArray alloc]init];
    for(id object in logData){
        [sectionsTitles addObject: [formater stringFromDate:[object date]]];
    }
    [sectionsTitles setArray:[[NSSet setWithArray:sectionsTitles] allObjects]];
    
    // Заполнение словаря
    
    for (NSString * string in sectionsTitles){
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for(id object in logData){
            if ([string isEqualToString:[formater stringFromDate:[object date]]])
                [array addObject:object];
        }
        [dataDictionary setValue:array forKey:string];
    }
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataDictionary count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[dataDictionary valueForKey:[sectionsTitles objectAtIndex:section]] count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [sectionsTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    
    id object = [[dataDictionary valueForKey:[sectionsTitles objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[PointsHistory class]]){
        cell.textLabel.text = [(PointsHistory *)object foodName];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"weight %f", [[(WeightHistory *)object weight] floatValue]/10];
    }
    return cell;
}

@end
