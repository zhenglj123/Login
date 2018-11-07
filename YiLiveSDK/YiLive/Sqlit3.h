//
//  Sqlit3.h
//  YiLive
//
//  Created by Zhenglj on 2018/10/21.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserData+CoreDataClass.h"


@interface Sqlit3 : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
