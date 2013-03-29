//
//  SecondViewController.m
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "SecondViewController.h"
#import "JSONKit.h"
#import "RootViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize mTableView = _mTableView;
@synthesize dataDict = _dataDict;
@synthesize ID = _ID;
@synthesize NAME = _NAME;
@synthesize CODE = _CODE;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ID = [NSMutableArray arrayWithCapacity:0];
        self.NAME = [NSMutableArray arrayWithCapacity: 0];
        self.CODE = [NSMutableArray arrayWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    
    self.dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //创建发送链接
    ASIFormDataRequest *requtst = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.suning.com/webapp/wcs/stores/servlet/SNmobileThirdMenuView"]];
    requtst.delegate = self;
    //参数共三个
    [requtst setPostValue:@"10052" forKey:@"storeId"];
    [requtst setPostValue:[[user objectForKey:@"id"] objectAtIndex:self.row] forKey:@"catalogId"];
    [requtst setPostValue:[[user objectForKey:@"code"] objectAtIndex:self.row] forKey:@"categoryCode"];
    //start发送开始,函数跳转到didfinish上去
    [requtst startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.text = [[self.dataDict objectForKey:@"name"] objectAtIndex:[indexPath row]];
    NSUserDefaults *three = [NSUserDefaults standardUserDefaults];
    [three setObject:self.ID forKey:@"id"];
    [three setObject:self.NAME forKey:@"name"];
    [three setObject:self.CODE forKey:@"code"];
    
    return cell;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    //这里的request就是获得的数据
    //这个数据需要用json或者xml解析一下才能用
    NSString *str = request.responseString;
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [jsonData objectFromJSONData];
    /*这是取回来的数据
     {
     "errorCode":"",
     "categoryList":[
     {
     "categoryName": "电脑整机",
     "categoryCode": "258003",
     "catalogId":"10051",
     "ci":"",
     "cf":""
     }
     ]
     }
     我们需要的是这个字典里面键为:categoryList里面的内容,所以....
     */
    for (NSDictionary *dic in [dict objectForKey:@"categoryList"])
    {
        /*
         传入参数:
         storeId=10052
         catalogId=第一个接口获得
         categoryCode=第一个接口获得
         */
        [self.ID addObject:[dic objectForKey:@"catalogId"]];
        [self.NAME addObject:[dic objectForKey:@"categoryName"]];
        [self.CODE addObject:[dic objectForKey:@"categoryCode"]];
    }
    
    [self.dataDict setObject:self.ID forKey:@"id"];
    [self.dataDict setObject:self.NAME forKey:@"name"];
    [self.dataDict setObject:self.CODE forKey:@"code"];
    
    [self.mTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataDict objectForKey:@"name"]count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeViewController *threeView = [[ThreeViewController alloc]init];
    threeView.title = [[self.dataDict objectForKey:@"Name" ] objectAtIndex:[indexPath row]];
    threeView.row = indexPath.row;
    
    //电脑整机
    
    [self.navigationController pushViewController:threeView animated:YES];
    
}

@end
