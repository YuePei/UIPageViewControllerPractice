
//
//  LucyViewController.m
//  PageViewControllerTest
//
//  Created by Peyton on 2018/4/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "LucyViewController.h"
#define MAS_SHORTHAND
#import "Masonry.h"
#import "BBScrollView.h"

@interface LucyViewController ()


@end

@implementation LucyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    float r = arc4random() % 255;
    float g = arc4random() % 255;
    float b = arc4random() % 255;
    UIColor *randomColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    self.view.backgroundColor = randomColor;
    
}


@end
