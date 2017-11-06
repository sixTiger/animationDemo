//
//  ViewController.m
//  ProgressAnimation
//
//  Created by xiaobing on 16/1/5.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBView.h"
#import "MTAnimationImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XXBView *animationView;
@property (weak, nonatomic) IBOutlet MTAnimationImageView *animationImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.animationImageView.image = [UIImage imageNamed:@"image00"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.animationView.percent = arc4random_uniform(100)/100.0;
    [self.animationImageView startProgressAnimating:5.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationImageView stopProgressAnimating:true];
    });
}


@end
