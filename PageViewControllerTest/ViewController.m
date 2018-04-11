//
//  ViewController.m
//  PageViewControllerTest
//
//  Created by Peyton on 2018/4/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "ViewController.h"
#import "LucyViewController.h"
#import "BBScrollView.h"

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
//
@property (nonatomic, strong)UIPageViewController *pageVC;
//这个用来存放所有要加载的子控制器
@property (nonatomic, copy)NSArray *dataSource;
//当前是第几页
@property (nonatomic, assign)NSInteger currentIndex;
//view
@property (nonatomic, strong)UIScrollView *topView;
//顶部滚动视图
@property (nonatomic , strong) BBScrollView *bbScrollView;
@end

@implementation ViewController
static NSInteger temp_index;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LucyViewController *lucyVC = [self VCAtIndex:0];
    NSArray *vcs = [NSArray arrayWithObjects:lucyVC, nil];
    [self.pageVC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    [self bbScrollView];
}

#pragma mark UIPageViewControllerProtocol
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfVC:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }else {
        index --;
        return [self VCAtIndex:index];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfVC:viewController];
    if (index == self.dataSource.count - 1 || index == NSNotFound) {
        return nil;
    }else {
        index ++;
        return [self VCAtIndex:index];
    }
}
/*
 如何获取下一个控制器的索引, 在上面两个数据源方法里无法获取准确的索引, 而应该在下面这个方法里获取:
 pendingViewControllers里包含的就是 即将 显示的那个控制器, 是一个数组, 如果是单页显示的话, 其中只有一个元素
 */
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *firstVc = pendingViewControllers.firstObject;
    NSInteger index = [self.dataSource indexOfObject:firstVc];
    temp_index = index;
}
/*
 这里是确定跳转到下一个vc了
 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        //已经跳转完成
        self.currentIndex = temp_index;
    }
}
#pragma mark toolMethods
- (NSInteger)indexOfVC:(UIViewController *)vc {
    return [self.dataSource indexOfObject:vc];
}
- (UIViewController *)VCAtIndex:(NSInteger)index {
    return self.dataSource[index];
}
#pragma mark lazy
- (BBScrollView *)bbScrollView {
    if (!_bbScrollView) {
        _bbScrollView = [[BBScrollView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50) items:@[@"First",@"Second",@"Third",@"longItem",@"First",@"Second",@"Third",@"longItem",@"Second",@"Third",@"longItem",@"First",@"Second",@"Third",@"longItem"]];
        _bbScrollView.backgroundColor = [UIColor colorWithRed:150 / 255.0 green:16 / 255.0 blue:71 / 255.0 alpha:1];
        [self.view addSubview:_bbScrollView];
    }
    return _bbScrollView;
}
- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageVC.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        
        [self addChildViewController:_pageVC];
        [self.view addSubview:_pageVC.view];
    }
    return _pageVC;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:[LucyViewController new],[LucyViewController new],[LucyViewController new], nil];
    }
    return _dataSource;
}
- (IBAction)clickFirstButton:(UIButton *)sender {
    
    self.currentIndex = 0;
    [self.pageVC setViewControllers:@[self.dataSource[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}
- (IBAction)clickSecondButton:(UIButton *)sender {
    if (self.currentIndex > 1) {
        [self.pageVC setViewControllers:@[self.dataSource[1]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else {
        [self.pageVC setViewControllers:@[self.dataSource[1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    self.currentIndex = 1;
}
- (IBAction)clickThirdButton:(UIButton *)sender {
    [self.pageVC setViewControllers:@[self.dataSource[2]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.currentIndex = 2;
//    [self presentViewController:[OneViewController new] animated:YES completion:nil];
}

@end
