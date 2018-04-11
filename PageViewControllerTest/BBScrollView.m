//
//  BBScrollView.m
//  PageViewControllerTest
//
//  Created by 乐培培 on 2018/4/10.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "BBScrollView.h"
#define MAS_SHORTHAND
#import "Masonry.h"
@interface BBScrollView()
//bottomLine
@property (nonatomic, strong)UIView *bottomLine;
//buttons
@property (nonatomic, copy)NSMutableArray *buttonNames;
@end

@implementation BBScrollView
//首个item距离左侧的距离
#define firstLeftMargin 30.0
static float buttonX = firstLeftMargin;
//如果你想设置每个item之间的距离，你可以设置这个变量
static float itemMargin = 20;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bottomLine];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

#pragma mark ToolMethods
- (BBScrollView *)initWithFrame:(CGRect)frame items:(NSArray *)items {
    BBScrollView *bb = [self initWithFrame:frame];
    
    [self.buttonNames addObjectsFromArray:items];
    for (int i = 0; i < self.buttonNames.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:self.buttonNames[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonX);
            make.centerY.equalTo(self);
        }];
        buttonX += [self getLengthOfEachItem:i] + itemMargin;
        [btn setTag:i];
        [btn addTarget:self action:@selector(selectIndexWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    //根据按钮数量来设置scrollView的contentSize
    [self setContentSize:CGSizeMake(buttonX + firstLeftMargin - itemMargin, 0)];
    NSLog(@"------%lf",self.contentSize.width);
    [self getLengthOfEachItem:0];

    return bb;
}

- (void)selectIndexWithButton:(UIButton *)button {
    //如果点击的是中心点右侧的item
//    NSLog(@"........x:%lf",button.frame.origin.x);
    NSLog(@"------Contentwidth:%lf",self.contentSize.width);
    NSLog(@"=======offset:%lf",self.contentOffset.x);
    NSLog(@"..........result:%lf\n\n",self.contentSize.width - self.contentOffset.x - itemMargin);
    if (self.contentSize.width > [UIScreen mainScreen].bounds.size.width && button.frame.origin.x > ([UIScreen mainScreen].bounds.size.width / 2.0)) {
        [self setContentOffset:CGPointMake(button.frame.origin.x - [UIScreen mainScreen].bounds.size.width / 2, 0) animated:YES];
    }else if(button.frame.origin.x < ([UIScreen mainScreen].bounds.size.width / 2.0) ) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if(self.contentSize.width - self.contentOffset.x - itemMargin <= [UIScreen mainScreen].bounds.size.width){
        NSLog(@"last serval items");
        [self setContentOffset:CGPointMake(self.contentSize.width - self.contentOffset.x, 0) animated:YES];
    }
    [UIView animateWithDuration:0.2 animations:^{
    [self.bottomLine setFrame:CGRectMake(button.frame.origin.x ,self.bottomLine.frame.origin.y, button.frame.size.width, 2)];
    }];
}

#pragma mark lazy
- (NSMutableArray *)buttonNames {
    if (!_buttonNames) {
        _buttonNames = [NSMutableArray array];
    }
    return _buttonNames;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        NSLog(@"excute only one time?");
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(buttonX, self.frame.size.height - 2, 32, 2)];
        [self addSubview:_bottomLine];
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLine;
}

#pragma mark Abandon
//根据字符中汉字和字母的数量来设计横线的长度, 前提是字体不变
- (float)getLengthOfEachItem:(NSInteger)item {
    int chineseCount = 0;
    int englishCount =0;
    NSString*str = self.buttonNames[item];
    for (int i =0; i< [str length]; i++){
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            chineseCount ++;
        }
        else
        {
            englishCount ++;
        }
    }
    return 15.6 * chineseCount + 8 *englishCount;
}
@end
