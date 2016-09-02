//
//  OAuthViewController.m
//  weibo
//
//  Created by JDD on 16/3/1.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

//URL:https://api.weibo.com/oauth2/authorize
//App Key：736139510
//App Secret：9524e332c221d6caf12f89df564dcce5
//client_id 	true 	string 	申请应用时分配的AppKey。
//redirect_uri 	true 	string 	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
//http://www.baidu.com回调页面
/*
 url:https://api.weibo.com/oauth2/access_token
 client_id 	true 	string 	申请应用时分配的AppKey。
 client_secret 	true 	string 	申请应用时分配的AppSecret。
 grant_type 	true 	string 	请求的类型，填写authorization_code
 
 
 grant_type为authorization_code时
 
 必选 	类型及范围 	说明
 code 	true 	string 	调用authorize获得的code值。
 redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
 
 

 */
#import "OAuthViewController.h"
#import "JDDTabBarController.h"
#import "JDDNewfeartureViewController.h"
#import "JDDAccount.h"
#import "JDDAccountTool.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //2.加载登录页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=736139510&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.delegate = self;
    
}
#pragma mark - UIWebViewDelegate
/*
    UIWebView开始加载资源的时候调用（开始发送请求）
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中。。。"];
}
/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/*
    UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 
    @param request 即将发送的请求
    @return YES : 允许加载  NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获得请求地址
    NSString *url = request.URL.absoluteString;
    
    //2.判断url是否为回调地址
    /*
     url = https://www.baidu.com/?code=a91b325134e2a02617fd5c8090d9a9dd
     range.location == 0
     range.length == 0
     */
    NSRange range = [url rangeOfString:@"http://www.baidu.com/?code="];
    if (range.location != NSNotFound) {//是回调地址
        //获取授权成功后的请求标记
        int from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        
        //根据code获得一个accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}
/*
    根据code获得一个accessToken(发送一个post请求)
    @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    NSLog(@"accessToken");
    //获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"736139510";
    params[@"client_secret"] = @"9524e332c221d6caf12f89df564dcce5";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    //3.发送post请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *accountDic) {
        //隐藏HUD
        [MBProgressHUD hideHUD];
        NSLog(@"请求成功--%@",accountDic);
        
        //字典转成模型
        JDDAccount *account = [JDDAccount accountWithDict:accountDic];
        //存储账号信息
        [JDDAccountTool save:account];
        
        //切换控制器(可能去新特性\tabbar)
        [JDDControllerTool chooseRootViewController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏HUD
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败--%@",error);
    }];
}
@end
