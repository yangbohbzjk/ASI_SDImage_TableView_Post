//
//  RootViewController.h
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "SecondViewController.h"
@interface RootViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *IDArray;
@property (nonatomic, retain) NSMutableArray *CodeArray;
@property (nonatomic, retain) NSMutableArray *NameArray;

@property (nonatomic, retain) NSMutableDictionary *dataDict;


//mTableView
@property (nonatomic, retain) UITableView *mTableView;

@end
