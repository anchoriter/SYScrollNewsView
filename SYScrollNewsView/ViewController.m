/*
 使用SYScrollNewsView滚动信息视图有关事项：
 1.需要创建自定义视图，负责处理UI布局方面。
 2.需要创建自定义视图的一个category，负责处理自定义视图的数据相关逻辑。
 3.需要创建数据模型。
 4.使用时只需要创建SYScrollNewsView，并实现代理方法传入一个数组数据即可。
 5.注意：添加计时器，并在合适的时候移除它。
 
 */

#import "ViewController.h"
#import "Masonry.h"
#import "MJExtension.h"

#import "SYScrollNewsView.h"
#import "CustomView.h"
#import "CustomView+ConfigureView.h"
#import "CustomModel.h"


@interface ViewController ()<SYScrollNewsViewDelegate>

@property (nonatomic, strong) SYScrollNewsView *scrollNewsView;
/** 数据 */
@property (nonatomic,strong) NSArray *newsDataArray;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 添加定时器
    [self.scrollNewsView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除定时器
    [self.scrollNewsView removeTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self loadData];
    [self setScrollNewsView];
}
/**
 *  模拟获取数据
 */
- (void)loadData{
    
    // 假设网络数据
    NSDictionary *dict1 = @{@"name":@"张三",@"sex":@"1",@"age":@"33"};
    
    NSDictionary *dict2 = @{@"name":@"尼古拉斯·李四",@"sex":@"2",@"age":@"45"};
    
    NSDictionary *dict3 = @{@"name":@"隔壁老王的侄子的同学的朋友",@"sex":@"0",@"age":@"66"};
    
    NSArray *arr =[NSArray arrayWithObjects:dict1, dict2, dict3, nil];
    
    self.newsDataArray = [CustomModel mj_objectArrayWithKeyValuesArray:arr];
}

/**
 *  设置滚动视图
 */
-(void)setScrollNewsView{
    ScrollNewsViewConfigureBlock configureViewBlock = ^(CustomView *customView, CustomModel *model){
        [customView configureView:model];
    };
    
    self.scrollNewsView = [[SYScrollNewsView alloc] initWithViewClassName:[CustomView class] configureViewBlock:configureViewBlock];
    self.scrollNewsView.newsViewDelegate = self;
    [self.view addSubview:self.scrollNewsView];
    
    [self.scrollNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-20);
    }];
}
#pragma mark - 设置滚动视图的代理方法
- (void)refreshData {
    [self.scrollNewsView setContentArr:self.newsDataArray];
}




-(void)dealloc{
    
    [self.scrollNewsView removeTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
