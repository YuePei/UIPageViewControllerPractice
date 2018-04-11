//
//  OneViewController.m
//  PageViewControllerTest
//
//  Created by Peyton on 2018/4/10.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "OneViewController.h"
#define MAS_SHORTHAND
#import "Masonry.h"


@interface OneViewController ()
//scrollView
@property (nonatomic, strong)UIScrollView *scrollView;
//bottomLine
@property (nonatomic, strong)UIView *bottomLine;

//buttons
@property (nonatomic, copy)NSMutableArray *buttonNames;
//vcs
@property (nonatomic, copy)NSMutableArray *vcs;
@end

@implementation OneViewController
static float buttonX = 40;
- (void)viewDidLoad {
    [super viewDidLoad];
    float r = arc4random() % 255;
    float g = arc4random() % 255;
    float b = arc4random() % 255;
    UIColor *randomColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    self.view.backgroundColor = randomColor;
    
    [self scrollView];
    [self bottomLine];
    
    NSArray *arr = @[@"首页",@"社会123456",@"文化",@"财经",@"法律",@"文化",@"财经",@"法律"];
    [self.buttonNames addObjectsFromArray:arr];
    for (int i = 0; i < self.buttonNames.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:self.buttonNames[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonX);
            make.centerY.equalTo(self.scrollView);
        }];
        buttonX += [self getLengthOfEachItem:i] + 20;
        [btn setTag:i];
        [btn addTarget:self action:@selector(selectIndexWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    //根据按钮数量来设置scrollView的contentSize
    [self.scrollView setContentSize:CGSizeMake(buttonX, 0)];
    [self getLengthOfEachItem:0];
    
    
}

- (void)selectIndexWithButton:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        [self.bottomLine setFrame:CGRectMake(button.frame.origin.x ,self.bottomLine.frame.origin.y, [self getLengthOfEachItem:button.tag], 2)];
    }];
}
#pragma mark ToolMethods
//根据字符中汉字和字母的数量来设计横线的长度, 前提是字体不变
- (float)getLengthOfEachItem:(NSInteger)item {
    int count = 0;
    int count1 =0;
    NSString*str = self.buttonNames[item];
    for (int i =0; i< [str length]; i++){
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            count ++;
        }
        else
        {
            count1 ++;
        }
    }
    return 16 * count + 8 *count1;
    
}
#pragma mark lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
        [self.view addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor brownColor];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        
    }
    
    return _scrollView;
}
- (NSMutableArray *)buttonNames {
    if (!_buttonNames) {
        _buttonNames = [NSMutableArray array];
    }
    return _buttonNames;
}
- (NSMutableArray *)vcs {
    if (!_vcs) {
        _vcs = [NSMutableArray array];
    }
    return _vcs;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        NSLog(@"excute only one time?");
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(buttonX, self.scrollView.frame.size.height - 2, 32, 2)];
        [self.scrollView addSubview:_bottomLine];
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}

@end
