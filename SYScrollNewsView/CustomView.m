//
//  CustomView.m
//  SYScrollNewsView
//
//  Created by Anchoriter on 2017/3/31.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import "CustomView.h"
#import "Masonry.h"

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface CustomView ()


@end

@implementation CustomView

/**
 *  重写初始化方法
 *
 *  @return 当前视图
 */
-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.8);
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        [self setupUI];
        
    }
    return self;
}

/**
 *  搭建界面
 */
-(void)setupUI{
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textColor = RGB(255, 255, 255);
    [self.nameLabel sizeToFit];
    
    self.sexLabel = [[UILabel alloc] init];
    self.sexLabel.font = [UIFont systemFontOfSize:13];
    self.sexLabel.textColor = RGB(255, 80, 80);
    [self.sexLabel sizeToFit];
    
    self.ageLabel = [[UILabel alloc] init];
    self.ageLabel.font = [UIFont systemFontOfSize:13];
    self.ageLabel.textColor = RGB(255, 80, 80);
    [self.ageLabel sizeToFit];
    
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.sexLabel];
    [self addSubview:self.ageLabel];

    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sexLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-10);
    }];
    
    
}


@end
