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


@synthesize currentWeight, aimWeight;

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
    
    // Получаю контекст
    
    NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Удеаление существующих сущностей
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Diet" inManagedObjectContext: managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    NSArray * result = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if ([result count] != 0){
        for ( Diet * toDelete in result){
            [managedObjectContext deleteObject: toDelete];
        }
    }
        
    // Добавление новой сущности
        
    Diet * diet = [[Diet alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    diet.startWeight = [NSNumber numberWithFloat: [currentWeight.text floatValue]*10];
    diet.currentWeight = [NSNumber numberWithFloat: [currentWeight.text floatValue]*10];
    diet.aimWeight = [NSNumber numberWithFloat: [aimWeight.text floatValue]*10];
    diet.dayPoints = [NSNumber numberWithInt: 20];
    diet.restDayPoints = [NSNumber numberWithInt: 20];
    diet.startDate = [NSDate date];
    [managedObjectContext save:nil];

    NSLog(@"%@", [diet description]);
    
    [self performSegueWithIdentifier:@"seg" sender:self];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}

@end
