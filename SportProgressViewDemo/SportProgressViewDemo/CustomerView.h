//
//  CustomerView.h
//  SportProgressViewDemo
//
//  Created by XieYZ on 27/5/17.
//  Copyright © 2017年 XieYuanzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportProgressView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CustomerView : UIView
//运动椭圆环
@property (nonatomic, strong) SportProgressView *sportprogress;

@end
