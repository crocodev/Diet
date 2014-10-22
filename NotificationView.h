//
//  NotificationView.h
//  Diet
//
//  Created by mriddi on 22.10.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARD_NUMERIC_KEY_WIDTH 108
#define KEYBOARD_NUMERIC_KEY_HEIGHT 53

@protocol NotificationViewDelegate <NSObject>
-(void) pressedButtoneWithTitle: (NSString *) title inNotificationView: (UIView *) view;
@end

@interface NotificationView : UIView

@property (nonatomic, assign) id <NotificationViewDelegate> delegate;


@end
