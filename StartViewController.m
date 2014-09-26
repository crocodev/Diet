//
//  StartViewController.m
//  Diet
//
//  Created by mriddi on 25.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController


@synthesize managedObjectContext, currentWeight, aimWeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Добавляю кнопку
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action: @selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Next" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor grayColor]];
    button.frame = CGRectMake(100.0, 450.0, 40.0, 40.0);
    [self.view addSubview:button];
    
    // Добавляюю поля ввода данных
    
    currentWeight = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 250.0, 40.0, 40.0)];
    aimWeight = [[UITextField alloc] initWithFrame:CGRectMake(60.0, 250.0, 40.0, 40.0)];
    currentWeight.backgroundColor = [UIColor blueColor];
    aimWeight.backgroundColor = [UIColor blueColor];
    [self.view addSubview:currentWeight];
    [self.view addSubview:aimWeight];
    
}


- (void) buttonPushed: (UIButton *) sender{
    
    // Удеаление существующих сущностей
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Diet" inManagedObjectContext: self.managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    NSArray * result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if ([result count] != 0){
        for ( Diet * toDelete in result){
            NSLog(@"current = %f aim = %f %@", [toDelete.currentWeight floatValue], [toDelete.aimWeight floatValue],toDelete.startDate);
            
            PointsHistory * ph = [toDelete.toPointsHistory anyObject];
            NSLog(@"%@", ph.foodName);
            
            [managedObjectContext deleteObject: toDelete];
        }
    }
        
    // Добавление новой сущности
        
    Diet * diet = [[Diet alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    diet.startWeight = [NSNumber numberWithFloat: [currentWeight.text floatValue]];
    diet.currentWeight = [NSNumber numberWithFloat: [currentWeight.text floatValue]];
    diet.aimWeight = [NSNumber numberWithFloat: [aimWeight.text floatValue]];
    diet.dayPoints = [NSNumber numberWithInt: 20];
    diet.restDayPoints = [NSNumber numberWithInt: 20];
    diet.startDate = [NSDate date];
    [managedObjectContext save:nil];

    [self performSegueWithIdentifier:@"seg" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TabBarController * tabBarController = [segue destinationViewController];
    tabBarController.managedObjectContext = self.managedObjectContext;
}

@end
