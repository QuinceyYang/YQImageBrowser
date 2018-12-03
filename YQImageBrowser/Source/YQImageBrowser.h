//
//  YQImageBrowser.h
//  YQImageBrowser
//
//  Created by 杨清 on 2018/3/20.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQImageBrowser : UIView
/**
 * @brief 初始化方法  图片以数组的形式传入, 需要显示的当前图片的索引
 *
 * @param  imageArray 需要显示的图片以数组的形式传入.
 * @param  index 需要显示的当前图片的索引
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index;
- (void)show;
@end
