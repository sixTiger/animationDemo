//
//  ViewController.m
//  ProgressAnimation
//
//  Created by xiaobing on 16/1/5.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XXBView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.animationView.percent = arc4random_uniform(100)/100.0;
//    self.animationView.backLineColor = [UIColor lightGrayColor];
//    self.animationView.lineColor = [UIColor redColor];

}

@end
