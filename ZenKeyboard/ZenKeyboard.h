//
//  ZenKeyboard.h
//  ZenKeyboard
//
//  Created by Kevin Nick on 2012-11-9.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARD_NUMERIC_KEY_WIDTH 108
#define KEYBOARD_NUMERIC_KEY_HEIGHT 53
#define MAX_LENGTH_PRE_COMMA 3
#define MAX_LENGTH_POST_COMMA 1

@protocol ZenKeyboardDelegate <NSObject>
- (void) chanheLabelTextTo:(NSString *) string bySender: (id) sender;
@end

@interface ZenKeyboard : UIView

@property (nonatomic, assign) id <ZenKeyboardDelegate> delegate;
@property (nonatomic, strong) NSString *text;

@end
