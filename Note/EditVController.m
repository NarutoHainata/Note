//
//  EditVController.m
//  Note
//
//  Created by zhang on 1/15/16.
//  Copyright (c) 2016 naruto. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "EditVController.h"
#import "NoteHeaderFile.h"

@interface EditVController ()

{
    UITextView *editView;
    UITextField *titleFiled;
    CustomAlertView *customAlertView;
    NSString *savePath2;
}

@end

@implementation EditVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithHeadView];
   
    
    editView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    [self.view addSubview:editView];
    
    //[editView becomeFirstResponder];
    
     [self alertFileNameView];
    
    
}
-(void)alertFileNameView{
    customAlertView = [[CustomAlertView alloc]initWithFrame:self.view.frame];
    
    UILabel *labTip = [[UILabel alloc]init];
    labTip.frame = CGRectMake(0, 0, 300, 30);
    labTip.textAlignment = NSTextAlignmentCenter;
    labTip.text = @"请输入文本名";
    
    titleFiled = [[UITextField alloc]init];
    titleFiled.frame = CGRectMake(20, 35, 260, 30);
    titleFiled.layer.borderWidth = 1;
    titleFiled.layer.borderColor = [[UIColor greenColor]CGColor];
    titleFiled.placeholder = @"在此输入...";
    
    UIImageView *leftBtnBg = [[UIImageView alloc]init];
    leftBtnBg.frame = CGRectMake(60, 70, 40, 40);
    leftBtnBg.image = [UIImage imageNamed:@"confirm_bg.png"];
    UIButton *leftBtnConfirm = [[UIButton alloc]init];
    leftBtnConfirm.frame = CGRectMake(30, 70, 100, 40);
    leftBtnConfirm.tag = 0;
    [leftBtnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightBtnBg = [[UIImageView alloc]init];
    rightBtnBg.frame = CGRectMake(200, 70, 40, 40);
    rightBtnBg.image = [UIImage imageNamed:@"cancle_bg.png"];
    UIButton *rightBtnCancle = [[UIButton alloc]init];
    rightBtnCancle.frame = CGRectMake(170, 70, 100, 40);
    rightBtnCancle.tag = 1;
    [rightBtnCancle addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *saveSubviewArr = [[NSArray alloc]init];
    saveSubviewArr = [NSArray arrayWithObjects:labTip,titleFiled,leftBtnBg, leftBtnConfirm,rightBtnBg,rightBtnCancle, nil];
    for (UIView *view in saveSubviewArr) {
        [[customAlertView.subviews objectAtIndex:0] addSubview:view];
    }

    [customAlertView show];
    
}
-(void)initWithHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    headView.backgroundColor = [UIColor grayColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 30, 60, 20)];
    title.text = @"编辑";
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    leftBtn.backgroundColor = [UIColor grayColor];
    [leftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    leftBtnBg.image = [UIImage imageNamed:@"back.png"];
    
    
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60,20,60,40)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(saveTxt) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightBtnBg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 20, 30, 40)];
    rightBtnBg.image = [UIImage imageNamed:@"submit.png"];
    

    NSArray *forSaveSubview = [NSArray arrayWithObjects:headView,title,leftBtn,leftBtnBg,rightBtn,rightBtnBg, nil];
    for (UIView *view in forSaveSubview) {
        [self.view addSubview:view];
    }
}
-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    CustomAlertView *alertTip = [[CustomAlertView alloc]initWithFrame:self.view.frame];
//    
//    UILabel *labTip = [[UILabel alloc]init];
//    labTip.frame = CGRectMake(0, 0, 300, 30);
//    labTip.text = @"您还没有保存?\n确定要退出吗";
//    labTip.textAlignment = NSTextAlignmentCenter;
//    [[alertTip.subviews objectAtIndex:0] addSubview:labTip];
//
//    
//    UIButton *leftTipBtn = [[UIButton alloc]init];
//    leftTipBtn.frame = CGRectMake(0, 50, 100, 50);
//    leftTipBtn.layer.borderWidth = 2;
//    leftTipBtn.tag = 3;
//    [leftTipBtn addTarget:self action:@selector(btnTipClick:) forControlEvents:UIControlEventTouchUpInside];
//    [[alertTip.subviews objectAtIndex:0] addSubview:leftTipBtn];
//
//    UIButton *rightTipBtn = [[UIButton alloc]init];
//    rightTipBtn.frame = CGRectMake(200, 50, 100, 50);
//    rightTipBtn.layer.borderWidth = 2;
//    rightTipBtn.tag = 4;
//    [rightTipBtn addTarget:self action:@selector(btnTipClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [[alertTip.subviews objectAtIndex:0] addSubview:rightTipBtn];
//
//    
//    
//    [alertTip show];
    
    
    
    
}
//-(void)btnTipClick:(UIButton *)sender{
//     if (sender.tag == 3){
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"3");
//        
//    }
//    else if (sender.tag == 4){
//        NSLog(@"4");
//    }
//}
-(void)btnClick:(UIButton *)sender{
    if (sender.tag == 0) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *data = [editView.text dataUsingEncoding:NSUTF8StringEncoding];
        
         savePath2 = [self.savePath stringByAppendingPathComponent:[titleFiled.text stringByAppendingString:@".txt"]];
        BOOL res = [fileManager createFileAtPath:savePath2 contents:data attributes:nil];
        if (res) {
            [editView becomeFirstResponder];
            [customAlertView dismiss];
            
                    //NSLog(@"success");
        }else {
                    //NSLog(@"fail");
                }

    }
    else if (sender.tag == 1){
        [customAlertView dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
    
    
}
-(void)saveTxt{
    
//    [editView resignFirstResponder];
    NSString *string = editView.text;
    
    //NSLog(@"%@",savePath2);
    [string writeToFile:savePath2 atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//}
//-(void)CustomAlert:(CustomAlert *)alertView checkedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSData *data = [editView.text dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSString *savePath2 = [self.savePath stringByAppendingPathComponent:[titleText.text stringByAppendingString:@".txt"]];
//        BOOL res = [fileManager createFileAtPath:savePath2 contents:data attributes:nil];
//        if (res) {
//            [editView becomeFirstResponder];
//            //NSLog(@"success");
//        }else {
//            //NSLog(@"fail");
//        }
//        
//    }else if(buttonIndex == 1){
//        [titleText removeFromSuperview];
//    }
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
