//
//  SportProgressView.h
//  SportProgressView
//
//  Created by RobinShare on 5/7/16.
//  Copyright © 2016年 RobinShare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH      ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT     ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE      (SCREEN_WIDTH>SCREEN_HEIGHT?SCREEN_WIDTH:SCREEN_HEIGHT)/568.0

@interface SportProgressView : UIView
//椭圆进度条供外部传值
@property (nonatomic, assign) CGFloat progress;
//步数
@property (nonatomic, strong) UILabel *stepLabel;
@end



@interface SportProgress : UIView
//椭圆进度条
@property (nonatomic, assign) CGFloat progress;
@end
