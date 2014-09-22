//
//  WeightHistory.h
//  Diet
//
//  Created by mriddi on 22.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WeightHistory : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSManagedObject *toDiet;

@end
