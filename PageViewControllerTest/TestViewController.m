//
//  TestViewController.m
//  PageViewControllerTest
//
//  Created by Peyton on 2018/4/10.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "TestViewController.h"
#import "LucyViewController.h"


@interface TestViewController ()<PleaseDelegate>
//
@property (nonatomic, strong)LucyViewController *lucy;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lucy.delegate = self;
}

- (NSArray *)pleaseConfigTheTitles {
    return nil;
}
- (NSArray *)pleaseConfigTheChildViewControllers {
    return nil;
}

@end
