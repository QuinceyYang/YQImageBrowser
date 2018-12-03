//
//  YQImageBrowser.m
//  YQImageBrowser
//
//  Created by 杨清 on 2018/3/20.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import "YQImageBrowser.h"
#import "YQImageView.h"
#import "UIImageView+WebCache.h"

//图片距离左右 间距
#define SpaceWidth    10


@interface YQImageBrowser () <YQImageViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * numberLabel;
@end

@implementation YQImageBrowser

- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index{
    if (self == [super init]) {
        self.imageArray = imageArray;
        self.index = index;
        [self setUpViews];
    }
    return self;
}

#pragma mark - getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        //这里
        _scrollView.contentSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width + 2*SpaceWidth) * self.imageArray.count, UIScreen.mainScreen.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(UIScreen.mainScreen.bounds.size.width * self.index, 0);
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        [self numberLabel];
    }
    return _scrollView;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, UIScreen.mainScreen.bounds.size.width, 40)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor greenColor];
        _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.index +1,self.imageArray.count];
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}

#pragma mark -
/*****
- (void)setUpView{
    int index = 0;
    for (UIImage * image in self.imageArray) {
        YQImageView * imageView = [[YQImageView alloc]init];
        imageView.delegate = self;
        imageView.image = image;
        imageView.tag = index;
        [self.scrollView addSubview:imageView];
        index ++;
    }
}
******/
- (void)setUpViews{
    int index = 0;
    for (NSString * urlStr in self.imageArray) {
        YQImageView * imageView = [[YQImageView alloc]init];
        imageView.delegate = self;
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
        imageView.tag = index;
        [self.scrollView addSubview:imageView];
        index ++;
    }
}

#pragma mark -
- (void)layoutSubviews {
    [super layoutSubviews];
    //主要为了设置每个图片的间距，并且使 图片铺满整个屏幕，实际上就是scrollview每一页的宽度是 屏幕宽度+2*Space  居中。图片左边从每一页的 Space开始，达到间距且居中效果。
    _scrollView.bounds = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width + 2 * SpaceWidth,UIScreen.mainScreen.bounds.size.height);
    _scrollView.center = self.center;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SpaceWidth + (UIScreen.mainScreen.bounds.size.width+20) * idx, 0,UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height);
    }];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/UIScreen.mainScreen.bounds.size.width;
    self.index = index;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"YQImageView"]) {
            YQImageView * imageView = (YQImageView *) obj;
            [imageView resetView];
        }
                }];
    self.numberLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.index+1,self.imageArray.count];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    [window addSubview:self];
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)dismiss{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:8 animations:^{
        self.transform = CGAffineTransformMakeScale(0.000001, 0.000001);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
   
}
#pragma mark ---YQImageViewDelegate
- (void)yqImageViewSingleClick:(YQImageView *)imageView{
    [self dismiss];
}
@end
