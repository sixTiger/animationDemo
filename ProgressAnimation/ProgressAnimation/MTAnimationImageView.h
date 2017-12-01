//
//  MTAnimationImageView.h
//  ProgressAnimation
//
//  Created by xiaobing on 2017/11/6.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTAnimationImageView;

@protocol MTAnimationImageViewDeleate <NSObject>
@optional

- (void)animationImageViewAnimationDidStop:(MTAnimationImageView *)animationImageView;
@end

@interface MTAnimationImageView : UIImageView
/**
 第0级别的动画时间 默认是0.6
 */
@property(nonatomic, assign)NSTimeInterval animationlevel0Dution;

/**
 第1级别的动画时间 默认是0.4
 */
@property(nonatomic, assign)NSTimeInterval animationlevel1Dution;

/**
 所有动画加起来的时间
 */
@property(nonatomic, assign)NSTimeInterval animationDution;

/**
 第0级别的动画比例 默认是0.33
 */
@property(nonatomic, assign)CGFloat         animationlevel0Present;

/**
 第1级别的动画比例 默认是0.33
 */
@property(nonatomic, assign)CGFloat         animationlevel1Present;

- (void)startProgressAnimating:(NSTimeInterval)anitionDution;

- (void)stopProgressAnimating:(BOOL)animation;
@end
