//
//  StickyViewController.h
//  StickyDemo
//
//  Created by dhf on 14-7-11.
//  Copyright (c) 2014年 dhf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *disp;
@property (weak, nonatomic) IBOutlet UITextView *input;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@end
