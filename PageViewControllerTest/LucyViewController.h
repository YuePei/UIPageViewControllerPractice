//
//  LucyViewController.h
//  PageViewControllerTest
//
//  Created by Peyton on 2018/4/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PleaseDelegate <NSObject>
@required
- (NSArray *)pleaseConfigTheTitles;
- (NSArray *)pleaseConfigTheChildViewControllers;

@end

@interface LucyViewController : UIViewController
//delegate
@property (nonatomic, assign)id<PleaseDelegate> delegate;

@end
