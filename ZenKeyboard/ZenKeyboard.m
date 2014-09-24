//
//  ZenKeyboard.m
//  ZenKeyboard
//
//  Created by Kevin Nick on 2012-11-9.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "ZenKeyboard.h"


@implementation ZenKeyboard

@synthesize text;

- (id)initWithFrame:(CGRect)frame
{
    text=@"";
    self = [super initWithFrame:frame]; 
    if (self) {
        [self addSubview:[self addNumericKeyWithTitle:@"1" frame:CGRectMake(0, 1, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"2" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, 1, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"3" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, 1, KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        
        [self addSubview:[self addNumericKeyWithTitle:@"4" frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"5" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"6" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];

        [self addSubview:[self addNumericKeyWithTitle:@"7" frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"8" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH , KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"9" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];

        [self addSubview:[self addNumericKeyWithTitle:@"," frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"0" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
        [self addSubview:[self addNumericKeyWithTitle:@"<" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    }
    
    return self;
}

- (UIButton *)addNumericKeyWithTitle:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:28.0]];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    UIImage *buttonPressedImage = [UIImage imageNamed:@"KeyboardNumericEntryKeyPressedTextured"];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(pressNumericKey:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)pressNumericKey:(UIButton *)button {
    NSString *keyText = button.titleLabel.text;
    NSUInteger lengthPreComma = 0;
    NSUInteger lengthPostComma = 0;
    int key = -1;
    
    if ([@"," isEqualToString:keyText]) {
        key = 10;
    } else if ([@"<" isEqualToString:keyText]){
        key = 11;
    } else {
        key = [keyText intValue];
    }
    
    NSRange comma = [text rangeOfString:@","];
    
    if (key == 11 || key == 10)
        ;
    else if (comma.location == NSNotFound)
        lengthPreComma = text.length;
    else{
        lengthPostComma = text.length - comma.location-1;
        lengthPreComma = text.length - lengthPostComma;
    }

    if ((lengthPreComma < MAX_LENGTH_PRE_COMMA && comma.location == NSNotFound) || (lengthPostComma < MAX_LENGTH_POST_COMMA && comma.location != NSNotFound)){
        switch (key) {
            case 11:
                if ([text length] > 0)
                    text = [text substringToIndex:[text length] - 1];
                if ([text hasSuffix:@","])
                    text = [text substringToIndex:[text length] - 1];
                break;
            case 10:
                if (text.length == 0)
                    text = @"0,";
                else
                    text = [NSString stringWithFormat:@"%@,", text];
                
                break;
            case 0:
                if (text.length == 0){
                    text = [NSString stringWithFormat:@"%d", key];
                }
                else if(comma.location != NSNotFound || ![text hasPrefix:@"0"]) {
                    text = [NSString stringWithFormat:@"%@%d",text, key];
                }
                break;
            default:
                if (text.length == 0 || [text isEqualToString:@"0"])
                    text = [NSString stringWithFormat:@"%d", key];
                else
                    text = [NSString stringWithFormat:@"%@%d", text, key];
                break;
        }
    }
    [_delegate changeLabelTextTo: text bySender:self];
}


@end
