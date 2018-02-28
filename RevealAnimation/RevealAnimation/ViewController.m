//
//  ViewController.m
//  RevealAnimation
//
//  Created by xiaobing on 2018/2/8.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+RJLoader.h"
#import "RJCircularLoaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)clickButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addImageView {
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.imageView startLoaderWithTintColor:[UIColor orangeColor]];
    __weak typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.netbian.com/file/20110916/d9f9257cd17d738eb6ccb5f62ddde4f9.jpg"] placeholderImage:nil options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        [weakSelf.imageView updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakSelf.imageView reveal];
    }];
}
- (IBAction)clickButton:(id)sender {
    [self.imageView startLoaderWithTintColor:[UIColor orangeColor]];
    [self.imageView updateImageDownloadProgress:0.5];
}
@end
