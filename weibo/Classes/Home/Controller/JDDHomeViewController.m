//
//  JDDHomeViewController.m
//  weibo
//
//  Created by JDD on 16/1/5.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDHomeViewController.h"
#import "JDDOneViewController.h"
#import "JDDUser.h"
#import "JDDStatus.h"
#import "JDDLoadMoreFooter.h"
@interface JDDHomeViewController ()
/**
 *  微博数组(存放着所有的微博数据)
 */
@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, weak)JDDLoadMoreFooter *footer;
@property (nonatomic, weak)JDDTitleButton *titleButton;
@end

@implementation JDDHomeViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的内容
    [self setupNavBar];
    
//    //记载最新的微博数据
    [self loadNewStatus];
    //集成刷新控件
    [self setupRefresh];
    
    //获得用户信息
    [self setupUserInfo];
}
/**
    获得用户信息
 */
- (void)setupUserInfo
{
//    //获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    params[@"uid"] = [JDDAccountTool account].uid;
    
//    //3.发送GET请求
//    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *userDict) {
//        //字典转模型
//        JDDUser *user = [JDDUser mj_objectWithKeyValues:userDict];
//        
//        //设置用户的昵称为标题
//        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
//        
//        //存储账号信息
//        JDDAccount *account = [JDDAccountTool account];
//        account.name = user.name;
//        [JDDAccountTool save:account];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
    [JDDHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id repsonseObject) {
        NSLog(@"repsonseObject-------%@",repsonseObject);
        //字典转模型
        JDDUser *user = [JDDUser mj_objectWithKeyValues:repsonseObject];
        NSLog(@"-------%@",user);
        //设置用户的昵称为标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储账号信息
        JDDAccount *account = [JDDAccountTool account];
        account.name = user.name;
        [JDDAccountTool save:account];

        
    } failure:^(NSError *error) {
        NSLog(@"请求失败-------%@",error);
    }];
}
/**
    集成刷新控件
 */
- (void)setupRefresh
{
    //1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    
    //2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    //3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    //加载数据
    [self refreshControlStateChange:refreshControl];
    
    //上拉加载更多数据
    JDDLoadMoreFooter *footer = [JDDLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}
/**
    当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
//    //1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    JDDStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatus.idstr;
    }
    
//    //3.发送GET请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDic) {
//        NSLog(@"%@",resultDic);
//
//        //微博字典 -- 数组
//        NSArray *statusDictArray = resultDic[@"statuses"];
//        
//        //微博字典数组-->微博模型数组
//        NSArray *newStatuses = [JDDStatus mj_objectArrayWithKeyValuesArray:statusDictArray];
//        
//        //将新数据插入到旧数据的最前面
//        NSRange range = NSMakeRange(0, newStatuses.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
//        
//        //重新刷新表格
//        [self.tableView reloadData];
//        
//        //让刷新控件停止刷新（恢复默认的状态）
//        [refreshControl endRefreshing];
//        //提示药包过户最新的微博数量
//        [self showNewStatusesCount:newStatuses.count];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"请求失败--%@",error);
//        [refreshControl endRefreshing];
//    }];

    [JDDHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id repsonseObject) {
        //微博字典 -- 数组
        NSArray *statusDictArray = repsonseObject[@"statuses"];
        NSLog(@"statusDictArray:%@",statusDictArray);

        //微博字典数组-->微博模型数组
        NSArray *newStatuses = [JDDStatus mj_objectArrayWithKeyValuesArray:statusDictArray];

        //将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];

        //重新刷新表格
        [self.tableView reloadData];

        //让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        //提示药包过户最新的微博数量
        [self showNewStatusesCount:newStatuses.count];
    } failure:^(NSError *error) {
        NSLog(@"请求失败--%@",error);
        [refreshControl endRefreshing];
    }];
}
/**
    提示用户最新的微博数量
    @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    //创建一个UILabel
    UILabel *label = [[UILabel alloc]init];
    
    //显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }else{
        label.text = @"没有最新的微博数据";
    }
    
    //设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    //设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    //添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        //往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {//向下移动完毕
        //延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            //恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //删除控件
            [label removeFromSuperview];
        }];
    }];
}
/**
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 开始：由慢到快，结束：由快到慢
 UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 由慢到块
 UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 由快到慢
 UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性，匀速
 */



/*
    加载最新的微博数据
 */
- (void)loadNewStatus
{
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    
    [JDDHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id reponseObject) {
//        //赋值数组数据
//        self.statuses = [NSMutableArray array];
        
        //微博字典 -- 数组
        NSArray *statusDictArray = reponseObject[@"statuses"];
        
        //微博字典数组-->微博模型数组
        self.statuses = [JDDStatus mj_objectArrayWithKeyValuesArray:statusDictArray];
        //刷新数据
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"请求失败--%@",error);
    }];
}
/**
    加载更多的微博数据
 */
- (void)loadMoreStatuses
{
      //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    JDDStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
    }
    
    [JDDHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id reponseObject) {
        //微博字典数组
        NSArray *statusDicArray = reponseObject[@"statuses"];
        //微博字典数组-->微博模型数组
        NSArray *newStatuses = [JDDStatus mj_objectArrayWithKeyValuesArray:statusDicArray];
        //将新数据插入到旧数据的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
        //重新刷新表格
        [self.tableView reloadData];
        
        //让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"请求失败--%@",error);
        
        //让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
}
/*
    设置导航栏的内容
 */
- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    //设置导航栏中间的标题按钮
    JDDTitleButton *titleButton = [[JDDTitleButton alloc]init];
    titleButton.height = 35;
    //设置文字
    NSString *name = [JDDAccountTool account].name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    //设置图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}
/**
*点击标题事件
**/
- (void)titleClick:(UIButton *)titleButton
{
    UIImage *downImage = [UIImage imageWithName:@"navigationbar_arrow_down"];
    if (titleButton.currentImage == downImage) {
        //换成箭头向上
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }else{
        //换成箭头向下
        [titleButton setImage:downImage forState:UIControlStateNormal];
    }
    
}
- (void)friendSearch
{
    NSLog(@"friendSearch----");
    JDDOneViewController *oneVc = [[JDDOneViewController alloc]init];
    oneVc.title = @"oneVc";
    [self.navigationController pushViewController:oneVc animated:YES];
}
- (void)pop
{
    NSLog(@"pop----");
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
#warning 为什么写在这里，为了监听tableview每次显示数据的过程
    self.footer.hidden = self.statuses.count == 0;
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //取出这行对应的微博字典数据
    JDDStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    //取出用户字典数据
    JDDUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 下载头像
    NSString *imageUrlStr = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"新控制器";
    [self.navigationController pushViewController:newVc animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statuses.count <= 0 || self.footer.refreshing) {
        NSLog(@"跳出盘帝国");
        return;
    }
    //1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    //刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    //2.如果能看到整个footer
    if (delta <= (sawFooterH - 0)) {
        NSLog(@"看全了footer");
        //进入上拉刷新状态
        [self.footer beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //加载更多的微博数据库
            [self loadMoreStatuses];
        });
    }
}

@end
