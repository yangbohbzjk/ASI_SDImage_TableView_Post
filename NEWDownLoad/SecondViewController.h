//
//  SecondViewController.h
//  NEWDownLoad
//
//  Created by David on 13-3-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
@class ViewController;
@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, retain) UITableView *mTableView;
@property (nonatomic, retain) NSMutableDictionary *dataDict;
@property (nonatomic, assign) NSUInteger row;

@property (nonatomic, retain) NSMutableArray *ID;
@property (nonatomic, retain) NSMutableArray *NAME;
@property (nonatomic, retain) NSMutableArray *CODE;


@end
