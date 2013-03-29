//
//  ThreeViewController.m
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ThreeViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "ContentCell.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController
@synthesize mTableView = _mTableView;
@synthesize dataDict = _dataDict;

@synthesize row = _row;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.name = [NSMutableArray arrayWithCapacity:0];
        self.contentdesc = [NSMutableArray arrayWithCapacity:0];
        self.content = [NSMutableArray arrayWithCapacity:0];
        self.picnum = [NSMutableArray arrayWithCapacity:0];
        self.dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource =self;
    [self.view addSubview:self.mTableView];
    
    self.dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSUserDefaults *three = [NSUserDefaults standardUserDefaults];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http://search.suning.com/emall/mobile/mobileSearch.jsonp"]];
    request.delegate = self;
    //这里写参数列表，一共有三个参数
    //有两个参数用到的第一个页面的字典，所以需要import第一个页面，调用其字典
    //这里你想想
    [request setPostValue:@"6" forKey:@"set"];
    [request setPostValue:@"10052" forKey:@"storeId"];
    [request setPostValue:[NSString stringWithFormat:@"%@",[[three objectForKey:@"code"] objectAtIndex:self.row]] forKey:@"ci"];
    [request setPostValue:@"1" forKey:@"cp"];
    [request setPostValue:@"20" forKey:@"ps"];
    //单页20条，第一页
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    //这里的request就是获得的数据
    //这个数据需要用json或者xml解析一下才能用
    NSString *str = request.responseString;
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [jsonData objectFromJSONData];
    for (NSDictionary *dic in [dict objectForKey:@"goods"])
    {
        [self.name addObject:[dic objectForKey:@"brandName"]];
        [self.content addObject:[dic objectForKey:@"auxdescription"]];
        [self.contentdesc addObject:[dic objectForKey:@"catentdesc"]];
        [self.picnum addObject:[dic objectForKey:@"partnumber"]];
    }
    
    [self.dataDict setObject:self.name forKey:@"name"];
    [self.dataDict setObject:self.content forKey:@"content"];
    [self.dataDict setObject:self.contentdesc forKey:@"contentdesc"];
    [self.dataDict setObject:self.picnum forKey:@"picnum"];
    
    [self.mTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Content" owner:self options:nil]lastObject];
    }
    
   // [cell.textLabel setText:[NSString stringWithFormat:@"%@",[[self.dataDict objectForKey:@"contentdesc"] objectAtIndex:[indexPath row]]]];
    [cell.title setBackgroundColor:[UIColor clearColor]];
    cell.title.text = [NSString stringWithFormat:@"%@",[[self.dataDict objectForKey:@"contentdesc"] objectAtIndex:[indexPath row]]];
    [cell setFont:[UIFont systemFontOfSize:13]];
    
    //图片
//    int number = [[[self.dataDict objectForKey:@"picnum"] objectAtIndex:[indexPath row]] integerValue];
//    NSString *url=[NSString stringWithFormat:@"http://image3.suning.cn/content/catentries/%014d/%018d/%018d_ls.jpg",number/10000,number,number];
//    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
 //   [cell.image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",url]]];
//    [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

@end
