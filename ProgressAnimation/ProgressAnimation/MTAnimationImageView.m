//
//  MTAnimationImageView.m
//  ProgressAnimation
//
//  Created by xiaobing on 2017/11/6.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import "MTAnimationImageView.h"
#import "XXBView.h"

@interface MTAnimationImageView()

@property(nonatomic, strong)CADisplayLink   *animationDisplayLink;
@property(nonatomic, assign)CGFloat         currentPresent;
@property(nonatomic, weak)XXBView           *presentView;

@property(nonatomic, assign)NSTimeInterval  animationlevelMindleDution;
@property(nonatomic, assign)CGFloat         animationlevelMindlePresent;
@property(nonatomic, assign)BOOL            shouldStopAnimation;
@property(nonatomic, assign)CGFloat         stopAnimationAddPresent;
@end

@implementation MTAnimationImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDafaultData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDafaultData];
    }
    return self;
}

- (void)setDafaultData {
    self.animationlevel0Dution = 0.6;
    self.animationlevel1Dution = 0.4;
    self.animationlevel0Present = 0.33;
    self.animationlevel1Present = 0.33;
    self.animationlevelMindlePresent = 1 - self.animationlevel0Present - self.animationlevel1Present;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.presentView.frame = self.bounds;
}

- (void)startProgressAnimating:(NSTimeInterval)anitionDution {
    if (self.animationDisplayLink == nil) {
        self.shouldStopAnimation = NO;
        self.animationDution = anitionDution;
        self.currentPresent = 0.0;
        self.animationlevelMindleDution = anitionDution - self.animationlevel0Dution - self.animationlevel1Dution;
        _animationDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(presentAutoAdd)];
        [_animationDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)stopProgressAnimating:(BOOL)animation {
    self.shouldStopAnimation = YES;
    if (animation) {
        self.stopAnimationAddPresent = (1.0 - self.currentPresent) / (self.animationlevel1Dution * 60);
    } else {
        self.stopAnimationAddPresent = 10 - self.currentPresent;
    }
}

- (void)presentAutoAdd {
    if ( self.shouldStopAnimation ) {
        self.currentPresent += self.stopAnimationAddPresent;
    } else {
        if (self.currentPresent < self.animationlevel0Present ) {
            
            self.currentPresent += self.animationlevel0Present / (self.animationlevel0Dution * 60.0);
        } else if ( self.currentPresent < self.animationlevel0Present + self.animationlevelMindlePresent ) {
            
            self.currentPresent +=  self.animationlevelMindlePresent / (self.animationlevelMindleDution * 60.0);
        } else {
            self.currentPresent += self.animationlevel1Present / (self.animationlevel1Dution * 60.0);
        }
    }
    self.presentView.percent = self.currentPresent;
    if (self.currentPresent >= 1.0) {
        [self.animationDisplayLink invalidate];
        self.animationDisplayLink = nil;
    }
}

- (XXBView *)presentView {
    if (_presentView == nil) {
        XXBView *presentView = [[XXBView alloc] initWithFrame:self.bounds];
        [self addSubview:presentView];
        presentView.percent = CGFLOAT_MIN;
        _presentView = presentView;
    }
    return _presentView;
}
@end
