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
    button.frame = CGRectMake(100.0, 50.0, 40.0, 40.0);
    [self.view addSubview:button];
    
    // Добавляюю поля ввода данных
    
    currentWeight = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 250.0, 40.0, 40.0)];
    aimWeight = [[UITextField alloc] initWithFrame:CGRectMake(60.0, 250.0, 40.0, 40.0)];
    currentWeight.backgroundColor = [UIColor grayColor];
    aimWeight.backgroundColor = [UIColor grayColor];
    [self.view addSubview:currentWeight];
    [self.view addSubview:aimWeight];
    
}


- (void) buttonPushed: (UIButton *) sender{
    if (![currentWeight.text isEqualToString:@""] && ![aimWeight.text isEqualToString:@""] && [currentWeight.text floatValue] > [aimWeight.text floatValue]){
        
        // Получаю контекст
        
        NSManagedObjectContext * managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        // Удеаление существующих сущностей
        
        NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Diet" inManagedObjectContext: managedObjectContext];
        NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entityDescription];
        NSArray * result = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        if ([result count] != 0){
            for ( Diet * toDelete in result){
                NSLog(@"deleted Diet object");
                [managedObjectContext deleteObject: toDelete];
            }
        }
        
        // Добавление новой сущности
        
        Diet * diet = [[Diet alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
        diet.startWeight = [NSNumber numberWithFloat: [currentWeight.text floatValue]*10];
        diet.currentWeight = diet.startWeight;
        diet.aimWeight = [NSNumber numberWithFloat: [aimWeight.text floatValue]*10];
        diet.startDate = [NSDate date];
        diet.checkDate = diet.startDate;
        [managedObjectContext save:nil];
        
        [self performSegueWithIdentifier:@"seg" sender:self];
    }
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}

@end
