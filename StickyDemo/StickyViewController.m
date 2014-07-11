//
//  StickyViewController.m
//  StickyDemo
//
//  Created by dhf on 14-7-11.
//  Copyright (c) 2014年 dhf. All rights reserved.
//

#import "StickyViewController.h"
#import "UIViewController+HideKeyboard.h"
#import <QuartzCore/QuartzCore.h>

@interface StickyViewController ()
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (assign, nonatomic) id currentResponder;
@end

@implementation StickyViewController

@synthesize disp;
@synthesize input;
@synthesize constraint;
@synthesize tapRecognizer;

#pragma lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tapRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    self.input.delegate = self;
    
    // textView appearance
    self.input.clipsToBounds = YES;
    self.input.layer.cornerRadius = 5.0f;
    self.input.layer.borderWidth = 0.5f;
    self.input.layer.borderColor = [[UIColor greenColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = nil;
    self.currentResponder = textView;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.input == textView) {
        self.disp.text = textView.text;
        [self textViewScrollToButtom];
    }
}

#pragma -
- (void)textViewScrollToButtom
{
    if (self.disp.text.length > 0) {
        NSRange range = NSMakeRange(self.disp.text.length - 1, 1);
        [self.disp scrollRangeToVisible:range];
    }
}

- (void)resignOnTap:(id)sender {
    [self.currentResponder resignFirstResponder];
}

#pragma Keyboard Events
- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    /* 
      Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system.
      The bottom of the textView's frame should align with the top of the keyboard's final position.
     */
    CGRect keyboardRect = [aValue CGRectValue];
    NSUInteger keyboardHeight = keyboardRect.size.height;
    self.constraint.constant = keyboardHeight;
    
    //
    [self textViewScrollToButtom];
    [self.view layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.constraint.constant = 0;
}

@end
