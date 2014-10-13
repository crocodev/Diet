//
//  Diet.h
//  Diet
//
//  Created by mriddi on 22.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WeightHistory;

@interface Diet : NSManagedObject

@property (nonatomic, retain) NSNumber * stage;
@property (nonatomic, retain) NSNumber * startWeight;
@property (nonatomic, retain) NSNumber * aimWeight;
@property (nonatomic, retain) NSNumber * currentWeight;
@property (nonatomic, retain) NSNumber * dayPoints;
@property (nonatomic, retain) NSNumber * restDayPoints;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSSet *toPointsHistory;
@property (nonatomic, retain) NSSet *toWeightHistory;
@end

@interface Diet (CoreDataGeneratedAccessors)

- (void)addToPointsHistoryObject:(NSManagedObject *)value;
- (void)removeToPointsHistoryObject:(NSManagedObject *)value;
- (void)addToPointsHistory:(NSSet *)values;
- (void)removeToPointsHistory:(NSSet *)values;

- (void)addToWeightHistoryObject:(WeightHistory *)value;
- (void)removeToWeightHistoryObject:(WeightHistory *)value;
- (void)addToWeightHistory:(NSSet *)values;
- (void)removeToWeightHistory:(NSSet *)values;

@end
