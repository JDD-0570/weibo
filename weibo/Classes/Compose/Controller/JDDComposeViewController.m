//
//  JDDComposeViewController.m
//  weibo
//
//  Created by JDD on 16/1/12.
//  Copyright © 2016年 姜丹丹. All rights reserved.
//

#import "JDDComposeViewController.h"
#import "JDDTextView.h"
#import "JDDComposeToolbar.h"
#import "JDDComposePhotosView.h"

@interface JDDComposeViewController ()<JDDComposeToolbarDelegate, UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak)JDDTextView *textView;
@property (nonatomic, weak)JDDComposeToolbar *toolbar;
@property (nonatomic, weak)JDDComposePhotosView *photosView;
@end

@implementation JDDComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条内容
    [self setupNavBar];
    
    //添加输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolBar];
    
    //添加显示图片的相册控件
    [self setupPhotosView];
}

//添加显示图片的相册控件
- (void)setupPhotosView
{
    JDDComposePhotosView *photosView = [[JDDComposePhotosView alloc]init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
//添加工具条
- (void)setupToolBar
{
    //1.创建
    JDDComposeToolbar *toolbar = [[JDDComposeToolbar alloc]init];
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    toolbar.height = 44;
    self.toolbar = toolbar;
    
    //显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}
//添加输入控件
- (void)setupTextView
{
    //1.创建输入控件
    JDDTextView *textView = [[JDDTextView alloc]init];
    textView.alwaysBounceVertical = YES;//垂直方向上永远有弹簧效果
    textView.frame = self.view.bounds;
    textView.delegate = self;
//    textView.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:textView];
    self.textView = textView;
    
    //2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事。。。";
    
    //设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    //4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/**
    view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //成为第一响应者（教出键盘）
    [self.textView becomeFirstResponder];
}
//设置导航条内容
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
/*
    取消
 */
- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
    发送
 */
- (void)send
{
    //1.发表微博
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    }else{
        [self sendStatusWithoutImage];
    }
    //2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
    发表有图片到微博
 */
- (void)sendStatusWithImage
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //发送post请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
#warning 目前新浪开放的发微博接口最多只能上传一张图片
        UIImage *image = [self.photosView.images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        //拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}
/**
    发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
//    //1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JDDAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //3.发送POST请求
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDic) {
//        [MBProgressHUD showSuccess:@"发表成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发表失败"];
//    }];
    [JDDHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id reponseObject) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}
#pragma mark - 键盘处理
/**
    键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    //1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}
/**
    键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}
#pragma mark - UITextViewDelegate
/**
    当用户开始拖拽scrollview时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
    NSLog(@"textview.text.length = %ld",textView.text.length);
}
/**
    监听toolbar内部按钮的点击事件
 */
- (void)composeTool:(JDDComposeToolbar *)toolbar didClickedButton:(JDDComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case JDDComposeToolbarButtonTypeCamera: //照相机
            [self openCamera];
            break;
        case JDDComposeToolbarButtonTypePicture://相册
            [self openPicture];
            break;
            
        default:
            break;
    }
}
/**
    打开相机
 */
- (void)openCamera
{
    NSLog(@"打开相机");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])return;
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}
/**
    打开相册
 */
- (void)openPicture
{
    NSLog(@"打开相册");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])return;
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //1.选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //2.添加图片到相册中
    [self.photosView addImage:image];
}
@end
