//
//  Entity.h
//  Diet
//
//  Created by mriddi on 22.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * attribute;

- (void) d;

@end
