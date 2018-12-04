//
//  AppDelegate.h
//  YQImageBrowser
//
//  Created by 杨清 on 2018/11/30.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define NSLog(format,args...)    NSLog(@"\n[yqing]<%@ %s line%d>" format"\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __PRETTY_FUNCTION__, __LINE__,##args)
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

