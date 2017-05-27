//
//  CustomerView.m
//  SportProgressViewDemo
//
//  Created by XieYZ on 27/5/17.
//  Copyright © 2017年 XieYuanzhong. All rights reserved.
//

#import "CustomerView.h"



@implementation CustomerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WS(weakSelf)
        self.sportprogress=[[SportProgressView alloc]init];
        [self addSubview:self.sportprogress];
        [self.sportprogress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(20);
            make.right.equalTo(weakSelf.mas_right).offset(-20);
            make.top.equalTo(weakSelf.mas_top).offset(50);
            make.height.equalTo(weakSelf.mas_height).multipliedBy(0.5);
        }];
    }
    return self;
}


@end
