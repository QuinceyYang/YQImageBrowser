//
//  YQImageView.h
//  YQImageBrowser
//
//  Created by 杨清 on 2018/3/20.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YQImageView;
@protocol YQImageViewDelegate <NSObject>

- (void)yqImageViewSingleClick:(YQImageView *)imageView;

@end


@interface YQImageView : UIImageView

@property (nonatomic, weak)id<YQImageViewDelegate>delegate;

- (void)resetView;

@end

