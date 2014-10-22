//
//  NotificationView.m
//  Diet
//
//  Created by mriddi on 22.10.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

#import "NotificationView.h"

@implementation NotificationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self addButton:@"+" frame:CGRectMake(0, 1, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addButton:@"-" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, 1, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    }
    
    return self;
}

- (UIButton *)addButton:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:28.0]];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIImage *buttonPressedImage = [UIImage imageNamed:@"KeyboardNumericEntryKeyPressedTextured"];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)press:(UIButton *)button {
    [self.delegate pressedButtoneWithTitle:button.titleLabel.text inNotificationView:self];
}

@end
