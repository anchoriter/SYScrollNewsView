//
//  CustomView+ConfigureView.m
//  SYScrollNewsView
//
//  Created by Anchoriter on 2017/3/31.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import "CustomView+ConfigureView.h"

@implementation CustomView (ConfigureView)

- (void)configureView:(CustomModel *)customModel{
    
    self.nameLabel.text = customModel.name;
    
    if (customModel.sex.integerValue == 1) {
        self.sexLabel.text = @"男";
    }else if (customModel.sex.integerValue == 2){
        self.sexLabel.text = @"女";
    }else{
        self.sexLabel.text = @"性别不明";
    }
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",customModel.age];
    
}
@end
