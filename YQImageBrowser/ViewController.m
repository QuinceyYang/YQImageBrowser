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
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"show" forState:UIControlStateNormal];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)show {
#if 0
    NSArray * array=@[@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342850_u1o2w2_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342844_l3p5w9_337_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342847_x6s0s8_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342846_c6l8g1_449_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342849_x3i3y1_337_600.jpg",@"http://img.xilexuan.com/download/app/20160426/t_2200245309_1342845_l8b7n9_449_600.jpg"];
#else
    NSArray *array = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg",@"06.jpg",];
#endif
    
    YQImageBrowser * browser = [[YQImageBrowser alloc] initWithImageArray:array currentIndex:0];
    [browser show];
}


@end
