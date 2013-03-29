//
//  ThreeViewController.h
//  NEWDownLoad
//
//  Created by David. on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "SecondViewController.h"

@interface ThreeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic , retain) UITableView *mTableView;
@property (nonatomic, retain ) NSMutableDictionary *dataDict;

@property (nonatomic, assign) NSUInteger row;

@property (nonatomic, retain) NSMutableArray *name;
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSMutableArray *picnum;
@property (nonatomic, retain) NSMutableArray *contentdesc;


@end
