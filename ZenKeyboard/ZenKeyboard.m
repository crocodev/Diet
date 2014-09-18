//
//  ZenKeyboard.m
//  ZenKeyboard
//
//  Created by Kevin Nick on 2012-11-9.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "ZenKeyboard.h"

@interface ZenKeyboard()

@property (nonatomic,assign) id<UITextInput> textInputDelegate;

@end;

@implementation ZenKeyboard

- (id)initWithFrame:(CGRect)frame
{
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
    
    if ([title isEqualToString:@"<"])
        [button addTarget:self action:@selector(pressBackspaceKey) forControlEvents:UIControlEventTouchUpInside];
    else
        [button addTarget:self action:@selector(pressNumericKey:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)pressNumericKey:(UIButton *)button {
    NSString *keyText = button.titleLabel.text;
    int key = -1;
    
    if ([@"," isEqualToString:keyText]) {
        key = 10;
    } else {
        key = [keyText intValue];
    }
    
    NSRange dot = [_label.text rangeOfString:@","];
    NSUInteger length = 0;
    if (dot.location == NSNotFound)
        length = _label.text.length;
    else
        length = _label.text.length-1;

    if (length < 4){
        switch (key) {
            case 10:
                if (length == 0)
                    _label.text = @"0,";
                else
                    _label.text = [NSString stringWithFormat:@"%@,", _label.text];
                
                break;
            case 0:
                if (_label.text.length ==0){
                    _label.text = _label.text = [NSString stringWithFormat:@"%d", key];
                }
                else if(dot.location != NSNotFound || ![_label.text hasPrefix:@"0"]) {
                    _label.text = _label.text = [NSString stringWithFormat:@"%@%d",_label.text, key];
                }
                break;
            default:
                if (length == 0 || (length == 1 && [_label.text isEqualToString:@"0"]))
                    _label.text = _label.text = [NSString stringWithFormat:@"%d", key];
                else
                    _label.text = [NSString stringWithFormat:@"%@%d", _label.text, key];
                break;
        }
    }
}

- (void)pressBackspaceKey {
    if ([_label.text length] > 0)
        _label.text = [_label.text substringToIndex:[_label.text length] - 1];
        if ([_label.text hasSuffix:@","])
            _label.text = [_label.text substringToIndex:[_label.text length] - 1];
}


@end
