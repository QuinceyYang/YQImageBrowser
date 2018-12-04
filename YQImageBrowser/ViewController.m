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
