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
    
    UITextField * currentWeight = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 250.0, 40.0, 40.0)];
    UITextField * aimWeight = [[UITextField alloc] initWithFrame:CGRectMake(60.0, 250.0, 40.0, 40.0)];
    currentWeight.backgroundColor = [UIColor blueColor];
    aimWeight.backgroundColor = [UIColor blueColor];
    [self.view addSubview:currentWeight];
    [self.view addSubview:aimWeight];
}


- (void) buttonPushed: (UIButton *) sender{
//    [self performSegueWithIdentifier:@"seg" sender:self];
//    Diet * diet = [Diet createEntity];
//    diet.aimWeight = [NSNumber numberWithFloat:77.7];
    
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    NSArray * res = [Diet findAll];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
