//
//  YQImageView.m
//  YQImageBrowser
//
//  Created by 杨清 on 2018/3/20.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import "YQImageView.h"

@interface YQImageView () <UIGestureRecognizerDelegate> {
    CGFloat _lastScale;//记录最后一次的图片放大倍数
}
@property (nonatomic, strong) UIScrollView * scaleScrollView;
// 用于显示 放大缩小的 图片
@property (nonatomic, strong) UIImageView * scaleIV;

@end

@implementation YQImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UIPinchGestureRecognizer * ges = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageViewAction:)];
        ges.delegate = self;
        _lastScale = 1.0;
        [self addGestureRecognizer:ges];
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleClick:)];
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

#pragma mark - getter
- (UIScrollView *)scaleScrollView{
    if (!_scaleScrollView) {
        _scaleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scaleScrollView.bounces = NO;
        _scaleScrollView.backgroundColor = [UIColor blackColor];
        _scaleScrollView.contentSize =  self.bounds.size;
        [self addSubview:_scaleScrollView];
    }
    return _scaleScrollView;
}
- (UIImageView *)scaleIV{
    if (!_scaleIV) {
        _scaleIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scaleIV.image = self.image;
         _scaleIV.contentMode = UIViewContentModeScaleAspectFit;
        [self.scaleScrollView addSubview:_scaleIV];
    }
    return _scaleIV;
}

#pragma mark -
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"");
}

#pragma mark - action
-(void)scaleImageViewAction:(UIPinchGestureRecognizer*)sender {
    
    CGFloat scale = sender.scale;//得到的是当前手势放大倍数
    NSLog(@"-------- scale = %f",scale);
    CGFloat shouldScale = _lastScale + (scale - 1);//当前手势相收缩率等于刚才手势的相对收缩 scale - 1，然后加上最后一次收缩率，为当前要展示的收缩率
    [self setScaleImageWithScale:shouldScale];
    sender.scale = 1.0;//图片大小改变后设置手势scale为1
}
- (void)setScaleImageWithScale:(CGFloat)scale{
    //最大2倍最小.5
    if (scale >=2) {
        scale = 2;
    }else if(scale <=.5){
        scale = .5;
    }
    _lastScale = scale;
    self.scaleIV.transform = CGAffineTransformMakeScale(scale, scale);
    if (scale > 1) {
        CGFloat imageWidth = self.scaleIV.frame.size.width;
        CGFloat imageHeight =  MAX(self.scaleIV.frame.size.height, self.frame.size.height);
        [self bringSubviewToFront:self.scaleScrollView];
        self.scaleIV.center = CGPointMake(imageWidth * 0.5, imageHeight * 0.5);
        self.scaleScrollView.contentSize = CGSizeMake(imageWidth, imageHeight);
        CGPoint offset = self.scaleScrollView.contentOffset;
        offset.x = (imageWidth - self.frame.size.width)/2.0;
        offset.y = (imageHeight - self.frame.size.height)/2.0;
        self.scaleScrollView.contentOffset = offset;
    }else{
        self.scaleIV.center = self.scaleScrollView.center;
        self.scaleScrollView.contentSize = CGSizeZero;
        
    }
}
- (void)singleClick:(UITapGestureRecognizer *)tap{
    if (_delegate &&[_delegate respondsToSelector:@selector(yqImageViewSingleClick:)]) {
        [_delegate yqImageViewSingleClick:self];
    }
}

- (void)doubleClick:(UITapGestureRecognizer *)tap{
    if (_lastScale > 1) {
        _lastScale = 1;
        
    }else{
        _lastScale = 2;
    }
    [UIView animateWithDuration:.5 animations:^{
        [self setScaleImageWithScale:self->_lastScale];
        
    }completion:^(BOOL finished) {
        if (self->_lastScale == 1) {
            [self resetView];
        }
    }];
   
}

/**
 * 当达到原图大小 清除 放大的图片 和scrollview
 */
- (void)resetView {
    if (!_scaleScrollView) {
        return;
    }
    _scaleScrollView.hidden = YES;
    [_scaleScrollView removeFromSuperview];
    _scaleScrollView = nil;
    _scaleIV = nil;
}

@end
