//
//  SYScrollNewsView.h
//  SYScrollNewsView
//
//  Created by Anchoriter on 2017/3/31.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 给自定义UI视图赋值的Block */
typedef void (^ScrollNewsViewConfigureBlock)(id newsView, id item);

@protocol SYScrollNewsViewDelegate <NSObject>

@optional
/**
 *  刷新数据
 */
- (void)refreshData;

@end

@interface SYScrollNewsView : UIScrollView

/** 代理 */
@property (nonatomic,weak) id <SYScrollNewsViewDelegate> newsViewDelegate;

- (id)initWithViewClassName:(Class)className
         configureViewBlock:(ScrollNewsViewConfigureBlock)aConfigureViewBlock;

/**
 *  要展示的数据源数组
 *
 *  @param contentArr 数据源数组
 */
-(void)setContentArr:(NSArray *)contentArr;
/**
 *  添加定时器
 */
- (void)addTimer;
/**
 *  移除定时器
 */
- (void)removeTimer;
@end
