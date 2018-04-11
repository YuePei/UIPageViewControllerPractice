//
//  BBScrollView.h
//  PageViewControllerTest
//
//  Created by 乐培培 on 2018/4/10.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBScrollView : UIScrollView


//唯一需要实现的方法
- (BBScrollView *)initWithFrame:(CGRect )frame items:(NSArray *)items;
- (void)selectIndexWithButton:(UIButton *)button;
@end
