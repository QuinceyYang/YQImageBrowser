//
//  ViewController.m
//  YQImageBrowser
//
//  Created by 杨清 on 2018/11/30.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import "ViewController.h"
#import "YQImageBrowser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [button setTitle:@"show" forState:UIControlStateNormal];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 110, 110);
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.layer.cornerRadius = button.frame.size.height/2;
    button.layer.masksToBounds = YES;
}

- (void)show {
#if 1
    //由于使用的网络高清图片，所以第一次加载时比较慢
    NSArray *array = @[@"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/01.jpg",
                       @"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/02.jpg",
                       @"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/03.jpg",
                       @"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/04.jpg",
                       @"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/05.jpg",
                       @"https://raw.githubusercontent.com/QuinceyYang/YQImageBrowser/master/YQImageBrowser/Resource/06.jpg"
                       ];
#else
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i=0; i<6; i++) {
        [array addObject:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"0%ld",i+1] withExtension:@"jpg"].absoluteString];
    }
#endif
    
    YQImageBrowser * browser = [[YQImageBrowser alloc] initWithImageArray:array currentIndex:3];
    [browser show];
}


@end
