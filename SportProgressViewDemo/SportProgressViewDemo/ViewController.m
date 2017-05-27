//
//  ViewController.m
//  SportProgressViewDemo
//
//  Created by XieYZ on 27/5/17.
//  Copyright © 2017年 XieYuanzhong. All rights reserved.
//

#import "ViewController.h"
#import "CustomerView.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()
@property (strong,nonatomic)CustomerView *customerView;

@property (strong,nonatomic)UISlider *slider;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.customerView = [[CustomerView alloc]init];
    self.customerView.backgroundColor = [UIColor clearColor];
    WS(weakSelf)
    [self.view addSubview:self.customerView];
    [self.customerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.height.equalTo(weakSelf.view.mas_height).multipliedBy(0.45);//比例很重要
    }];
    
    self.customerView.sportprogress.progress = 0.25;
    self.customerView.sportprogress.stepLabel.text = @"500";
    
    self.slider = [[UISlider alloc]init];
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 1.0;
    self.slider.value = 0.25;
    self.slider.continuous = YES;
    [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(30);
        make.right.equalTo(weakSelf.view.mas_right).offset(-30);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-40);
        make.height.equalTo(@4);
    }];
}

- (void) sliderChange:(id) sender {
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider * slider = sender;
        CGFloat value = slider.value;
        NSLog(@"%f", value);
        self.customerView.sportprogress.progress = value;
        self.customerView.sportprogress.stepLabel.text = [NSString stringWithFormat:@"%ld",(long)[@(2000*value) integerValue]];
        [self.customerView updateConstraintsIfNeeded];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
