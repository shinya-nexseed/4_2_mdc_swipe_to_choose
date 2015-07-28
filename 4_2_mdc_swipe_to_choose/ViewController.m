//
//  ViewController.m
//  4_2_mdc_swipe_to_choose
//
//  Created by Shinya Hirai on 2015/07/28.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"Hot";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Not";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
                                                                     options:options];
    view.imageView.image = [UIImage imageNamed:@"shinya.jpg"];
    [self.view addSubview:view];

}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return YES;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
