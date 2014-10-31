//
//  SettingsViewController.m
//  Diet
//
//  Created by mriddi on 18.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize logTableView, diet, managedObjectContext, logData, logSections;

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
    
    
    NSMutableSet * set = [NSMutableSet setWithSet:diet.toPointsHistory];
    [set addObjectsFromArray:[diet.toWeightHistory allObjects]];
    logData  = [NSMutableArray arrayWithArray: [set allObjects]];
    
    NSSortDescriptor * sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [logData sortUsingDescriptors:@[sortByDate]];
    
    
}


#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"dd.MM.yyyy"];
    logSections = [[NSMutableArray alloc]init];
    
    for(id object in logData){
        [logSections addObject: [formater stringFromDate:[object date]]];
    }
    [logSections setArray:[[NSSet setWithArray:logSections] allObjects]];
//    logSections = [NSMutableArray arrayWithArray:[[logSections reverseObjectEnumerator] allObjects]];
    return [logSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"dd.MM.yyyy"];
    NSUInteger count = 0;
    
    for(id object in logData){
        if([[formater stringFromDate:[object date]] isEqualToString:[logSections objectAtIndex:section]])
            count++;
    }
    
    
    return count;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [logSections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"!!!";
    
    return cell;
}

@end
