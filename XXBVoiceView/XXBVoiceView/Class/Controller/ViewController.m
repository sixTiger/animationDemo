//
//  ViewController.m
//  XXBVoiceView
//
//  Created by xiaobing on 15/11/9.
//  Copyright © 2015年 xiaobing. All rights reserved.
//

#import "ViewController.h"
#import "SNBSpeechView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_creatAnimationView];
}
- (void)p_creatAnimationView
{
    SNBSpeechView *speekView = [[SNBSpeechView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:speekView];
    speekView.center = CGPointMake(0.5 * CGRectGetWidth([UIScreen mainScreen].bounds), 0.5 * CGRectGetHeight([UIScreen mainScreen].bounds) );
    speekView.backgroundColor = [UIColor lightGrayColor];
}

@end
