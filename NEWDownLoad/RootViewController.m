//
//  RootViewController.m
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize IDArray = _IDArray;
@synthesize CodeArray = _CodeArray;
@synthesize NameArray = _NameArray;
@synthesize dataDict = _dataDict;
@synthesize mTableView = _mTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.IDArray = [NSMutableArray arrayWithCapacity:0];
    self.CodeArray = [NSMutableArray arrayWithCapacity:0];
    self.NameArray = [NSMutableArray arrayWithCapacity:0];
    self.dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource =self;
    [self.view addSubview:self.mTableView];
    
    //发送请求的网址
    ASIFormDataRequest * request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.suning.com/webapp/wcs/stores/servlet/SNmobileTopMenu"]];
    request.delegate=self;
    //这里是参数
    NSString * deviceinfo =@"22001-10051";
    NSString * id =[NSString stringWithFormat:@"10052"];
    //    NSString * size =[NSString stringWithFormat:@"358537049509499"];
    //上面的值和下面的键对应
    [request setPostValue:deviceinfo forKey:@"catalogIds"];
    [request setPostValue:id forKey:@"storeId"];
    //    [request setPostValue:size forKey:@"request"];
    //这里一共是三组参数
    
    
    [request startAsynchronous];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)requestFinished:(ASIHTTPRequest *)request{
    //这里的request就是获得的数据
    //这个数据需要用json或者xml解析一下才能用
    NSString *str = request.responseString;
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [jsonData objectFromJSONData];
    //转换后开始遍历json
    //NSLog(@"dict:%@",[dict objectForKey:@"firstCategoryList"]);
    for (NSDictionary *dic in [dict objectForKey:@"firstCategoryList"])
    {
        //  NSLog(@"dic:%@",dic);
        //这里就是dict里面的每一个字典：dic
        //我需要三个数组来保存这些数据，最后把这三个数组再次存入一个字典中，见property声明
        [self.IDArray addObject:[dic objectForKey:@"catalogId"]];
        [self.CodeArray addObject:[dic objectForKey:@"categoryCode"]];
        [self.NameArray  addObject:[dic objectForKey:@"categoryName"]];
    }
    //把三个数组存入字典
    [self.dataDict setObject:self.IDArray forKey:@"ID"];
    [self.dataDict setObject:self.CodeArray  forKey:@"Code"];
    [self.dataDict setObject:self.NameArray forKey:@"Name"];
    //NSLog(@"nameArray:%@",[self.dataDict objectForKey:@"Name"]);
    //保存数据后刷新表格，因为顺序是先构建表格，然后才下载数据，所以如果这里不刷新，表格是没有数据的，相当于再次调用表格
    [self.mTableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:[self.dataDict objectForKey:@"Code"] forKey:@"code"];
    [user setObject:[self.dataDict objectForKey:@"ID"] forKey:@"id"];
    
    
    //从字典里读出键为Name的数组，然后遍历这个数组的index获得值
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[[self.dataDict objectForKey:@"Name"] objectAtIndex:[indexPath row]]]];
    // NSLog(@"name:%@",[[self.dataDict objectForKey:@"Name"] objectAtIndex:[indexPath row]]);
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataDict objectForKey:@"Name"]count];
    // return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *SecondView = [[SecondViewController alloc]init];
    SecondView.title = [[self.dataDict objectForKey:@"Name"] objectAtIndex:[indexPath row]];
    SecondView.row = [indexPath row];
    
    //电脑整机
    [self.navigationController pushViewController:SecondView animated:YES];
    
}


@end
