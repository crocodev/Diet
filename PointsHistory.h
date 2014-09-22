//
//  PointsHistory.h
//  Diet
//
//  Created by mriddi on 22.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Diet;

@interface PointsHistory : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * foodName;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) Diet *toDiet;

@end
