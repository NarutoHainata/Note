//
//  ReadVController.m
//  Note
//
//  Created by zhang on 1/21/16.
//  Copyright (c) 2016 naruto. All rights reserved.
//

#import "ReadVController.h"

@interface ReadVController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *readWebView;
@end

@implementation ReadVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithHeadView];
    [self initWithWebView];
    [self loadWebView];
    
    
    
}
-(void)initWithHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    headView.backgroundColor = [UIColor grayColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 30, 60, 20)];
    title.text = @"浏览";
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    leftBtn.backgroundColor = [UIColor grayColor];
    [leftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    leftBtnBg.image = [UIImage imageNamed:@"back.png"];
    
    
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60,20,60,40)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 20, 30, 40)];
    rightBtnBg.image = [UIImage imageNamed:@"more_bg.png"];
    
    
    NSArray *forSaveSubview = [NSArray arrayWithObjects:headView,title,leftBtn,leftBtnBg,rightBtn,rightBtnBg, nil];
    for (UIView *view in forSaveSubview) {
        [self.view addSubview:view];
    }

    
}
-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)moreBtn{
    // 分享 截图  修改
    UIButton *btnViewBg = [[UIButton alloc]init];
    btnViewBg.frame = self.view.frame;
    btnViewBg.backgroundColor = [UIColor grayColor];
    btnViewBg.alpha = 0.5;
    [btnViewBg addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnViewBg];
    
    UIView *btnView = [[UIView alloc]init];
    btnView.frame = CGRectMake(self.view.frame.size.width-105, 65, 100, 200);
    btnView.backgroundColor = [UIColor whiteColor];
    btnView.layer.borderColor = [[UIColor greenColor]CGColor];
    btnView.layer.borderWidth = 1;
    btnView.layer.cornerRadius = 10;
    
    //自定义功能
    
    
    
    
    
    [self.view addSubview:btnView];
}
-(void)initWithWebView{
    
    self.readWebView = [[UIWebView alloc]init];
    self.readWebView.delegate = self;
    self.readWebView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
    self.readWebView.backgroundColor = [UIColor clearColor];
    //self.readWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.readWebView];
}
-(void)loadWebView{
    NSString *str = [self.fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.readWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
