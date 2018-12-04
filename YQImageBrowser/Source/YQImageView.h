//
//  YQImageView.h
//  YQImageBrowser
//
//  Created by 杨清 on 2018/3/20.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define NSLog(format,args...)    NSLog(@"\n[yqing]<%@ %s line%d>" format"\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __PRETTY_FUNCTION__, __LINE__,##args)
#endif

@class YQImageView;
@protocol YQImageViewDelegate <NSObject>

- (void)yqImageViewSingleClick:(YQImageView *)imageView;

@end


@interface YQImageView : UIImageView

@property (nonatomic, weak)id<YQImageViewDelegate>delegate;

- (void)resetView;

@end

