//
//  MainVController.m
//  Note
//
//  Created by zhang on 1/15/16.
//  Copyright (c) 2016 naruto. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "MainVController.h"
#import "NoteHeaderFile.h"

@interface MainVController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSFileManager *fileManager;
    NSString *saveDirectory;
    NSMutableArray *saveTxtModel;
    UIButton *btnAsBg;
    
    UIView *showMenuView;
    UITextField *titleField;
    
    NSMutableArray *saveFilePathArr;
    
    UITableView *tableViewShow;
}
@end

@implementation MainVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithHeadView];
    
    [self initWithTableView];
    
    [self initSavePath];
    
    [self traverseDirectory];
        
    
    
}
//便利目录
-(void)traverseDirectory{
    saveFilePathArr = [[NSMutableArray alloc]init];
    //脚本对象数组
    saveTxtModel=[[NSMutableArray alloc]init];
    
    //遍历目录
    NSDirectoryEnumerator * fileDE = [fileManager enumeratorAtPath:saveDirectory];
    
    NSString *path = nil;
    //获得每一个目录
    while ((path = [fileDE nextObject]) != nil) {
        
        //输出的是每个目录文件名
        //获取文件夹创建时间
        
        TxtModel *model = [[TxtModel alloc] init];
        model.fileName = path;
        
        
        NSString *filePath = [saveDirectory stringByAppendingPathComponent:path];
        
        [saveFilePathArr addObject:filePath];
        
        NSError *error = nil;
        NSDictionary *fileDictionary = [fileManager attributesOfItemAtPath:filePath error:&error];
        if (fileDictionary) {
            // make use of attributes
            //self.creationDate = [fileDictionary objectForKey:NSFileCreationDate];
            // NSString *strChange = [NSString stringWithFormat:@"%@",_creationDate];
            //
            //            NSString *strReturn = [strChange substringWithRange:NSMakeRange(5, 11)];
            
            
            // model.fileSize = [fileDictionary objectForKey:NSFileSize];
            // model.fileTime = strChange;
            //model.fileName = _creationDate;
            
            
            
        } else {
            // handle error found in 'error'
            NSLog(@"%@",error);
        }
        
        // model.content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [saveTxtModel addObject:model];
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",saveTxtModel.count);
    return saveTxtModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    TxtModel *model = nil;
    model = [saveTxtModel objectAtIndex:indexPath.row];
    cell.textLabel.text = model.fileName;
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *filePathUrl = [saveFilePathArr objectAtIndex:indexPath.row];
    //NSLog(@"%@",filePathUrl);
    ReadVController *rvc = [[ReadVController alloc]init];
    rvc.fileUrl = filePathUrl;
    
    [self presentViewController:rvc animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *removeFilePath = [saveFilePathArr objectAtIndex:indexPath.row];
    [fileManager removeItemAtPath:removeFilePath error:nil];
    
    [saveFilePathArr removeObjectAtIndex:indexPath.row];
    [saveTxtModel removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView reloadData];
    
}

-(void)initSavePath{
    //获取documents下数据持久保存的目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //创建保存路径
    fileManager = [NSFileManager defaultManager];
    saveDirectory = [documentDirectory stringByAppendingPathComponent:@"Note"];
    BOOL isDir=NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:saveDirectory isDirectory:&isDir];
    if (!(isDirExist && isDir)) {//如果路径不存在则创建
        // 创建目录
        [fileManager createDirectoryAtPath:saveDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
}
#pragma mark --创建tableview来显示txt文件
-(void)initWithTableView{
    
    CGRect tableViewFrame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60);
     tableViewShow = [[UITableView alloc]initWithFrame:tableViewFrame];
    tableViewShow.delegate = self;
    tableViewShow.dataSource = self;
    [self.view addSubview:tableViewShow];
}
#pragma mark --自定义头部导航状态
-(void)initWithHeadView{
    //数组用来存储头部视图的subview
    NSArray *saveSubviewArr = [[NSArray alloc]init];
    //创建导航view
    CGRect headViewFrame = CGRectMake(0, 20, SCREEN_WIDTH, 40);
    UIView *headView = [[UIView alloc]initWithFrame:headViewFrame];
    headView.backgroundColor = [UIColor grayColor];
    //创建label用来显示软件名
    CGRect titleLabFrame = CGRectMake(SCREEN_WIDTH/2-30, 30, 60, 20);
    UILabel *titleLab = [[UILabel alloc]initWithFrame:titleLabFrame];
    titleLab.text = @"NOTE";
    //创建按钮 用来显示功能
    CGRect leftBtnFrame = CGRectMake(10, 25, 40, 30);
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:leftBtnFrame];
    leftBtn.backgroundColor = [UIColor clearColor];
    UIImageView *leftBtnBg = [[UIImageView alloc]initWithFrame:leftBtnFrame];
    leftBtnBg.image = [UIImage imageNamed:@"menu.png"];
    [leftBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    //waiting
//    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60,20,60,40)];
//    rightBtn.backgroundColor = [UIColor grayColor];
    saveSubviewArr = [NSArray arrayWithObjects:headView,titleLab,leftBtn,leftBtnBg, nil];
    for (UIView *view in saveSubviewArr) {
        [self.view addSubview:view];
    }
}
-(void)showMenu{
    
    btnAsBg = [[UIButton alloc]init];
    btnAsBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    btnAsBg.backgroundColor = [UIColor grayColor];
    btnAsBg.alpha = 0.5;
    [btnAsBg addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    
    showMenuView = [[UIView alloc]init];
    showMenuView.frame = CGRectMake(0, 60, self.view.frame.size.width/2, self.view.frame.size.height-60);
    showMenuView.backgroundColor = [UIColor whiteColor];
    
    UIButton *createFileBtn = [[UIButton alloc]init];
    createFileBtn.frame = CGRectMake(0, 10, self.view.frame.size.width/2, 40);
    [createFileBtn addTarget:self action:@selector(createNoteFile) forControlEvents:UIControlEventTouchUpInside];
    [createFileBtn setTitle:@"新建文本" forState:UIControlStateNormal];
    createFileBtn.backgroundColor = [UIColor grayColor];
    [showMenuView addSubview:createFileBtn];
    
    [self.view addSubview:btnAsBg];
    [self.view addSubview:showMenuView];
    
}
-(void)backTo{
    btnAsBg.hidden = YES;
    showMenuView.hidden = YES;
}
-(void)createNoteFile{
  
    btnAsBg.hidden = YES;
    showMenuView.hidden = YES;
    

    
    
    EditVController *editView = [[EditVController alloc]init];
    editView.savePath = saveDirectory;
   
    [self presentViewController:editView animated:YES completion:nil];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self initWithTableView];
    [self initSavePath];
    [self traverseDirectory];

}
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
