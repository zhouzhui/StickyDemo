//
//  UIViewController+HideKeyboard.m
//  HideKeyboard
//
//  Created by dhf on 12-3-29.
//  Copyright (c) 2012年 dhf. All rights reserved.
//

#import "UIViewController+HideKeyboard.h"

@implementation UIViewController (HideKeyboard)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
