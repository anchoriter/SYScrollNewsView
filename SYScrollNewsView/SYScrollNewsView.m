//
//  SYScrollNewsView.m
//  SYScrollNewsView
//
//  Created by Anchoriter on 2017/3/31.
//  Copyright © 2017年 Anchoriter. All rights reserved.
//

#import "SYScrollNewsView.h"
#import "Masonry.h"


@interface SYScrollNewsView ()<UIScrollViewDelegate>
/** 滚动定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 刷新数据定时器 */
@property (nonatomic, strong) NSTimer *refreshTimer;
/** 内容数组 */
@property (nonatomic, strong) NSArray *contentArr;
/** 当前位置 */
@property (nonatomic, assign) NSInteger index;
/** 自定义视图类名 */
@property (nonatomic, strong) NSString *className;
/** 自定义视图赋值的Block */
@property (nonatomic, copy) ScrollNewsViewConfigureBlock configureViewBlock;
@end
@implementation SYScrollNewsView

/**
 *  重写初始化方法
 *
 *  @return 当前视图
 */
-(instancetype)init{
    
    return nil;
}
- (id)initWithViewClassName:(Class)className
         configureViewBlock:(ScrollNewsViewConfigureBlock)aConfigureViewBlock{
    self = [super init];
    if (self) {
        
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.index = 0;
        self.delegate = self;
        self.className = NSStringFromClass(className);
        self.configureViewBlock = [aConfigureViewBlock copy];
        
        // 刷新产品定时器
        [self addRefreshTimer];
    }
    return self;
}
/**
 *  刷新数据
 */
-(void)refreshToData{
    
    // 每10秒执行一次刷新数据
    if ([self.newsViewDelegate respondsToSelector:@selector(refreshData)]) {
        
        [self.newsViewDelegate refreshData];
    }
}

/**
 *  获取热门产品数据
 *
 *  @param contentArr 热门产品数据
 */
-(void)setContentArr:(NSArray *)contentArr{
    
    if (contentArr.count == 0) {
        return;
    }
    
    if (_contentArr.count != contentArr.count){
        _contentArr = contentArr;
        
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
        
        NSMutableArray *showArr = [NSMutableArray arrayWithArray:contentArr];
        // 多添加一个数据，保证滚动连续
        [showArr addObject:contentArr[0]];
        
        CGFloat height = self.frame.size.height;
        Class viewClass = NSClassFromString(self.className);
        
        for (int i = 0; i < showArr.count; i++){
            id model = showArr[i];
            id newsView = [[viewClass alloc] init];
            [self addSubview:newsView];
            // 赋值
            self.configureViewBlock(newsView, model);
            
            [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(i*height);
                make.height.mas_equalTo(height);
            }];
        }
        self.contentSize = CGSizeMake(0, height * showArr.count);
        
    }else{
        _contentArr = contentArr;
        
        NSMutableArray *showArr = [NSMutableArray arrayWithArray:contentArr];
        [showArr addObject:contentArr[0]];
        
        for (int i = 0; i < showArr.count; i++) {
            
            id model = showArr[i];
            id newsView = self.subviews[i];
            // 赋值
            self.configureViewBlock(newsView, model);
        }
    }
}

- (void)nextNewsView {
    self.index ++;
    
    if (self.index > self.contentArr.count) {
        self.index = 0;
    }
    
    [self setContentOffset:CGPointMake(0, self.index * self.frame.size.height) animated:YES];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.index == self.contentArr.count) {
        self.index = 0;
        [self setContentOffset:CGPointZero animated:NO];
    }
}
/**
 *  设置产品滚动定时器
 */
- (void)addScrollViewTimer {
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextNewsView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        NSLog(@"滚动产品定时器");
    }
}
/**
 *  设置刷新产品数据定时器
 */
- (void)addRefreshTimer {
    if (!self.refreshTimer) {
        self.refreshTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(refreshToData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.refreshTimer forMode:NSRunLoopCommonModes];
        NSLog(@"刷新产品定时器");
    }
}
/**
 *  添加定时器
 */
- (void)addTimer{
    [self addScrollViewTimer];
    [self addRefreshTimer];
}
/**
 *  移除定时器
 */
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
    
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}
/**
 *  dealloc
 */
- (void)dealloc {
    
}


@end
