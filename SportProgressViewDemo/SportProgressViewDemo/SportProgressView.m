//
//  IWANSportProgressView.m
//  iWan2
//
//  Created by RobinShare on 5/7/16.
//  Copyright © 2016年 RobinShare. All rights reserved.
//

#import "SportProgressView.h"

@interface SportProgressView()
@property (nonatomic, strong) UILabel *stepUnitLabel;
@property (nonatomic, strong) UIImageView *sportbg;

@property (nonatomic, strong) SportProgress *sportProgressView;
@end

@implementation SportProgressView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutView];
        [self viewStyle];
    }
    return self;
}

- (void)layoutView{
    WS(weakSelf)
    self.sportbg=[[UIImageView alloc]init];
    [self addSubview:self.sportbg];
    [self.sportbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    self.sportProgressView = [[SportProgress alloc]init];
    [self addSubview:self.sportProgressView];
    [self.sportProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    self.stepLabel = [[UILabel alloc]init];
    [self addSubview:self.stepLabel];
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.28);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.6);
    }];
    
    self.stepUnitLabel = [[UILabel alloc]init];
    [self addSubview:self.stepUnitLabel];
    [self.stepUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.stepLabel.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.25);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.4);
    }];
    
   
}

- (void)viewStyle{
    self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    self.sportbg.image=[UIImage imageNamed:@"bg_sport_step"];
    
    self.stepLabel.textColor = [UIColor orangeColor];
    self.stepLabel.font = [UIFont systemFontOfSize:32.0];
    self.stepLabel.text  = @"0";
    self.stepLabel.textAlignment = NSTextAlignmentCenter;
    
    self.stepUnitLabel.textColor = [UIColor lightGrayColor];
    self.stepUnitLabel.font = [UIFont systemFontOfSize:14.0];
    self.stepUnitLabel.text  = @"步";
    self.stepUnitLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.sportProgressView.progress = _progress;
    [self setNeedsDisplay];
    
}


@end



@interface SportProgress()

@end

@implementation SportProgress

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat R = 0.55*SCREEN_HEIGHT/4; //外半径
    CGFloat Rc = 2*M_PI*R;            //半径为R的圆周长
    
    CGFloat Rc_2 = Rc/2;            //半径为R的1/2圆周长
    CGFloat Rc_4 = Rc/4;            //半径为R的1/4圆周长
    CGFloat l = SCREEN_WIDTH - 40 - 2*R;  //单直线长
    CGFloat C = Rc + 2*l;         //外轮廓总周长
    
    CGPoint center_leftPoint = CGPointMake((SCREEN_WIDTH - 40) / 2 - l/2, self.center.y);  //左圆心
    CGPoint center_rightPoint = CGPointMake((SCREEN_WIDTH - 40) / 2 + l/2, self.center.y); //右圆心
    CGFloat radiusWidth = 50;  //环带宽radiusWidth需要调节
   
    if (_progress > 0.0) {
        
       
        if (_progress >= Rc_4/C) {
            CGContextRef context_1 = UIGraphicsGetCurrentContext();
            CGMutablePathRef drawPath_1 = CGPathCreateMutable();
            
            CGContextSetRGBStrokeColor(context_1, 0.0, 0.0, 0.0, 1.0);
            CGContextSetLineWidth(context_1, 0.0);

            //上四分之一圆
            CGFloat sAngle_left =   M_PI;
            CGFloat eAngle_left =   M_PI_2 + M_PI;
            
            CGPathMoveToPoint(drawPath_1, NULL, center_leftPoint.x - R, center_leftPoint.y);
            CGPathAddArc(drawPath_1,
                         NULL,
                         center_leftPoint.x,
                         center_leftPoint.y,
                         R,
                         sAngle_left,
                         eAngle_left,
                         0);
            CGPathAddArc(drawPath_1,
                         NULL,
                         center_leftPoint.x,
                         center_leftPoint.y,
                         R - radiusWidth,
                         eAngle_left,
                         sAngle_left,
                         1);
            CGPathAddLineToPoint(drawPath_1, NULL, center_leftPoint.x - R, center_leftPoint.y);
            
            [self contextActionWithContext:context_1 AndPath:drawPath_1];
            
            
            

                CGContextRef context_2 = UIGraphicsGetCurrentContext();
                CGMutablePathRef drawPath_2 = CGPathCreateMutable();
                
                // 画上矩形边框
                CGContextSetRGBStrokeColor(context_2, 0.0, 0.0, 0.0, 1.0);
                CGContextSetLineWidth(context_2, 0.0);
                if (_progress >=  (Rc_4+l)/C) {
                    CGPathMoveToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x + l, center_leftPoint.y - R);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x + l, center_leftPoint.y - R + radiusWidth);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R + radiusWidth) ;
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R);
                    
                    [self contextActionWithContext:context_2 AndPath:drawPath_2];
                    
                        CGContextRef context_3 = UIGraphicsGetCurrentContext();
                        CGMutablePathRef drawPath_3 = CGPathCreateMutable();
                        if (_progress >= (Rc_4 + l +Rc_2)/C) {
                            CGFloat sAngle_right =   M_PI_2 + M_PI;
                            CGFloat eAngle_right =   M_PI_2;
                            
                            
                            CGPathAddArc(drawPath_3,
                                         NULL,
                                         center_rightPoint.x,
                                         center_rightPoint.y,
                                         R,
                                         sAngle_right,
                                         eAngle_right,
                                         0);
                            CGPathAddArc(drawPath_3,
                                         NULL,
                                         center_rightPoint.x,
                                         center_rightPoint.y,
                                         R - radiusWidth,
                                         eAngle_right,
                                         sAngle_right,
                                         1);
                            
                            [self contextActionWithContext:context_3 AndPath:drawPath_3];
                            
                                CGContextRef context_4 = UIGraphicsGetCurrentContext();
                                CGMutablePathRef drawPath_4 = CGPathCreateMutable();
                                if (_progress >= (Rc_4+l+Rc_2+l)/C) {
                                    CGContextSetRGBStrokeColor(context_4, 0.0, 0.0, 0.0, 1.0);
                                    CGContextSetLineWidth(context_4, 0.0);
                                    
                                    CGPathMoveToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x - l, center_rightPoint.y + R);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x - l, center_rightPoint.y + R - radiusWidth);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R - radiusWidth) ;
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R);
                                    
                                    [self contextActionWithContext:context_4 AndPath:drawPath_4];
                        
                                        CGContextRef context_5 = UIGraphicsGetCurrentContext();
                                        CGMutablePathRef drawPath_5 = CGPathCreateMutable();
                                        
                                        if (_progress >= 1.0) {
                                            CGContextSetRGBStrokeColor(context_5, 0.0, 0.0, 0.0, 1.0);
                                            CGContextSetLineWidth(context_5, 0.0);
                                            
                                            CGFloat sAngle_left_down =   M_PI_2;
                                            CGFloat eAngle_left_down =   M_PI_2 + M_PI_2;
                                            
                                            
                                            CGPathAddArc(drawPath_5,
                                                         NULL,
                                                         center_leftPoint.x,
                                                         center_leftPoint.y,
                                                         R,
                                                         sAngle_left_down,
                                                         eAngle_left_down,
                                                         0);
                                            CGPathAddArc(drawPath_5,
                                                         NULL,
                                                         center_leftPoint.x,
                                                         center_leftPoint.y,
                                                         R - radiusWidth,
                                                         eAngle_left_down,
                                                         sAngle_left_down,
                                                         1);
                                            
                                            [self contextActionWithContext:context_5 AndPath:drawPath_5];
                                            
                                        }else{
                                            CGContextSetRGBStrokeColor(context_5, 0.0, 0.0, 0.0, 1.0);
                                            CGContextSetLineWidth(context_5, 0.0);
                                            
                                            CGFloat sAngle_left_down =   M_PI_2;
                                            CGFloat eAngle_left_down =   (_progress - (Rc_4+l+Rc_2+l)/C)*C/Rc_4*M_PI_2 + M_PI_2;
                                            
                                            
                                            CGPathAddArc(drawPath_5,
                                                         NULL,
                                                         center_leftPoint.x,
                                                         center_leftPoint.y,
                                                         R,
                                                         sAngle_left_down,
                                                         eAngle_left_down,
                                                         0);
                                            CGPathAddArc(drawPath_5,
                                                         NULL,
                                                         center_leftPoint.x,
                                                         center_leftPoint.y,
                                                         R - radiusWidth,
                                                         eAngle_left_down,
                                                         sAngle_left_down,
                                                         1);
                                            
                                            [self contextActionWithContext:context_5 AndPath:drawPath_5];
                                            
                                        }

                                }else{
                                    CGContextSetRGBStrokeColor(context_4, 0.0, 0.0, 0.0, 1.0);
                                    CGContextSetLineWidth(context_4, 0.0);
                                    
                                    CGPathMoveToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x - (_progress - (Rc_4+l+Rc_2)/C)*C/l*l, center_rightPoint.y + R);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x - (_progress - (Rc_4+l+Rc_2)/C)*C/l*l, center_rightPoint.y + R - radiusWidth);
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R - radiusWidth) ;
                                    CGPathAddLineToPoint(drawPath_4, NULL, center_rightPoint.x, center_rightPoint.y + R);
                                    
                                    [self contextActionWithContext:context_4 AndPath:drawPath_4];
                                    
                                }

                            
                        }else{
                            CGFloat rateX = (_progress - (Rc_4+l)/C)*C/Rc_2;
                            CGFloat rateY = 2*(rateX - 0.5);
                            
                            CGFloat sAngle_right =   M_PI_2 + M_PI;
                            CGFloat eAngle_right =   rateY*M_PI_2;
                            
                            
                            CGPathAddArc(drawPath_3,
                                         NULL,
                                         center_rightPoint.x,
                                         center_rightPoint.y,
                                         R,
                                         sAngle_right,
                                         eAngle_right,
                                         0);
                            CGPathAddArc(drawPath_3,
                                         NULL,
                                         center_rightPoint.x,
                                         center_rightPoint.y,
                                         R - radiusWidth,
                                         eAngle_right,
                                         sAngle_right,
                                         1);
                            
                            [self contextActionWithContext:context_3 AndPath:drawPath_3];
                            
                        }

                    
                }else{
                    CGPathMoveToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x + (_progress - Rc_4/C)*C/l*l, center_leftPoint.y - R);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x + (_progress - Rc_4/C)*C/l*l, center_leftPoint.y - R + radiusWidth);
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R + radiusWidth) ;
                    CGPathAddLineToPoint(drawPath_2, NULL, center_leftPoint.x, center_leftPoint.y - R);
                    
                    [self contextActionWithContext:context_2 AndPath:drawPath_2];
                    
                }

        }else{
            CGContextRef context_1 = UIGraphicsGetCurrentContext();
            CGMutablePathRef drawPath_1 = CGPathCreateMutable();
            
            CGContextSetRGBStrokeColor(context_1, 0.0, 0.0, 0.0, 1.0);
            CGContextSetLineWidth(context_1, 0.0);
            
            CGFloat sAngle_left =   M_PI;
            CGFloat eAngle_left =  ((_progress*C)/Rc_4)*M_PI_2 + M_PI;
            
            CGPathMoveToPoint(drawPath_1, NULL, center_leftPoint.x - R, center_leftPoint.y);
            CGPathAddArc(drawPath_1,
                         NULL,
                         center_leftPoint.x,
                         center_leftPoint.y,
                         R,
                         sAngle_left,
                         eAngle_left,
                         0);
            CGPathAddArc(drawPath_1,
                         NULL,
                         center_leftPoint.x,
                         center_leftPoint.y,
                         R - radiusWidth,
                         eAngle_left,
                         sAngle_left,
                         1);
            CGPathAddLineToPoint(drawPath_1, NULL, center_leftPoint.x - R, center_leftPoint.y);
            
            [self contextActionWithContext:context_1 AndPath:drawPath_1];
        }
        
    }
    
}


- (void)setProgress:(CGFloat)progress
{
    if (progress > 1.0) {
        _progress = 1.0;
    }else{
        _progress = progress;
    }
    
    [self setNeedsDisplay];
    
}


- (void)contextActionWithContext: (CGContextRef) context AndPath: (CGMutablePathRef) drawPath{
    CGContextAddPath(context, drawPath);
    CGContextStrokePath(context);
    
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextEOClip(context);
    
    CGPathCloseSubpath(drawPath);
    CGContextAddPath(context, drawPath);
    CGPathRelease(drawPath);
    
    //Draw the image, clipped to the path:
    CGContextSaveGState(context);
    CGContextClip(context);
    
    CGContextDrawImage(context,self.bounds, [[UIImage imageNamed:@"ic_step_count"] CGImage]);
    CGContextRestoreGState(context);
    

}


@end
