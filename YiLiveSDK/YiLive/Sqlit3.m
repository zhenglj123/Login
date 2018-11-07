//
//  Sqlit3.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/21.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "Sqlit3.h"
#import <CoreData/CoreData.h>

@interface Sqlit3 ()
{
  NSManagedObjectContext * _context;
  NSMutableArray * _dataSource;
}

@end

@implementation Sqlit3

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
  self.tableView.estimatedRowHeight = 100;
  
  [self createSqlite];
  
  //查询所有数据的请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  NSArray *resArray = [_context executeFetchRequest:request error:nil];
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
}

//创建数据库
- (void)createSqlite{
  
  //1、创建模型对象
  //获取模型路径
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserData" withExtension:@"momd"];
  //根据模型文件创建模型对象
  NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  
  
  //2、创建持久化存储助理：数据库
  //利用模型对象创建助理对象
  NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
  
  //数据库的名称和路径
  NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
  NSLog(@"数据库 path = %@", sqlPath);
  NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
  
  NSError *error = nil;
  //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
  [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
  
  if (error) {
    NSLog(@"添加数据库失败:%@",error);
  } else {
    NSLog(@"添加数据库成功");
  }
  
  //3、创建上下文 保存信息 操作数据库
  
  NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  
  //关联持久化助理
  context.persistentStoreCoordinator = store;
  
  _context = context;
  
  
}

#pragma mark -- Event Handle

- (IBAction)insertClicked:(id)sender {
  [self insertData];
}
- (IBAction)delegateClicked:(id)sender {
  [self deleteData];
}
- (IBAction)updateClicked:(id)sender {
  [self updateData];
}
- (IBAction)readClicked:(id)sender {
  [self readData];
}

- (IBAction)sortClicked:(id)sender {
  [self sort];
}


#pragma mark -- 数据处理

//插入数据
- (void)insertData{
  
  
  // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类UserData
  
  UserData * student = [NSEntityDescription
                       insertNewObjectForEntityForName:@"UserData"
                       inManagedObjectContext:_context];
  
  //  2.根据表Student中的键值，给NSManagedObject对象赋值
  student.nickName = [NSString stringWithFormat:@"Mr-%d",arc4random()%100];
  student.borth = arc4random()%20;
  student.sex = arc4random()%2 == 0 ?  @"美女" : @"帅哥" ;
//  student.height = arc4random()%180;
  student.phoneValue = arc4random()%100;
  
  //查询所有数据的请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  NSArray *resArray = [_context executeFetchRequest:request error:nil];
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
  
  //   3.保存插入的数据
  NSError *error = nil;
  if ([_context save:&error]) {
    [self alertViewWithMessage:@"数据插入到数据库成功"];
  }else{
    [self alertViewWithMessage:[NSString stringWithFormat:@"数据插入到数据库失败, %@",error]];
  }
  
}

//删除
- (void)deleteData{
  
  //创建删除请求
  NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  
  //删除条件
  NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %d", 10];
  deleRequest.predicate = pre;
  
  //返回需要删除的对象数组
  NSArray *deleArray = [_context executeFetchRequest:deleRequest error:nil];
  
  //从数据库中删除
  for (UserData *stu in deleArray) {
    [_context deleteObject:stu];
  }
  
  //没有任何条件就是读取所有的数据
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  NSArray *resArray = [_context executeFetchRequest:request error:nil];
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
  
  NSError *error = nil;
  //保存--记住保存
  if ([_context save:&error]) {
    [self alertViewWithMessage:@"删除 age < 10 的数据"];
  }else{
    NSLog(@"删除数据失败, %@", error);
  }
  
}

//更新，修改
- (void)updateData{
  
  //创建查询请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  
  NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"男"];
  request.predicate = pre;
  
  //发送请求
  NSArray *resArray = [_context executeFetchRequest:request error:nil];
  
  //修改
  for (UserData *stu in resArray) {
    stu.nickName = @"郑吕杰";
  }
  
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
  
  //保存
  NSError *error = nil;
  if ([_context save:&error]) {
    [self alertViewWithMessage:@"更新所有郑吕杰的名字为“郑吕杰数据库”"];
  }else{
    NSLog(@"更新数据失败, %@", error);
  }
  
  
}

//读取查询
- (void)readData{
  
  //创建查询请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  
  //查询条件
  NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"女"];
  request.predicate = pre;
  
  
  // 从第几页开始显示
  // 通过这个属性实现分页
  //request.fetchOffset = 0;
  
  // 每页显示多少条数据
  //request.fetchLimit = 6;
  
  
  //发送查询请求,并返回结果
  NSArray *resArray = [_context executeFetchRequest:request error:nil];
  
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
  
  [self alertViewWithMessage:@"查询所有的数据"];
  
  
}


//排序
- (void)sort{
  
  //创建排序请求
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
  
  //实例化排序对象
  NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
  NSSortDescriptor *phoneSort = [NSSortDescriptor sortDescriptorWithKey:@"phone"ascending:YES];
  request.sortDescriptors = @[ageSort,phoneSort];
  
  //发送请求
  NSError *error = nil;
  NSArray *resArray = [_context executeFetchRequest:request error:&error];
  
  _dataSource = [NSMutableArray arrayWithArray:resArray];
  [self.tableView reloadData];
  
  if (error == nil) {
    [self alertViewWithMessage:@"按照age和phone排序"];
  }else{
    NSLog(@"排序失败, %@", error);
  }
  
  
}


- (void)alertViewWithMessage:(NSString *)message{
  
  UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  [self presentViewController:alert animated:YES completion:^{
    
    [NSThread sleepForTimeInterval:0.5];
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
    
  }];
  
  
}

#pragma mark -- UITableDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell * celll = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
  
  UserData * student = _dataSource[indexPath.row];
  ;
  celll.imageView.image = [UIImage imageNamed:([student.sex isEqualToString:@"美女"] == YES ? @"mei.jpeg" : @"luo.jpg")];
  celll.textLabel.text = [NSString stringWithFormat:@" age = %d \n phone = %d \n name = %@ \n sex = %@",student.borth, student.phoneValue, student.nickName, student.sex];
  celll.textLabel.numberOfLines = 0;
  
  return celll;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
