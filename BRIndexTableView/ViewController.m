//
//  ViewController.m
//  BRIndexTableView
//
//  Created by 袁涛 on 2018/7/10.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import "ViewController.h"
#import "BRIndexTableView.h"

@interface ViewController()<UITableViewDataSource,UITableViewDelegate,BRIndexTableViewDataSource>
{
    BRIndexTableView *tableView;//带有索引条的tableview
    UIButton *button;
    NSMutableArray *dataSource;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableView = [[BRIndexTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView.indexViewWitdh = 30;
    tableView.indexClickFont = [UIFont systemFontOfSize:12];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 设置table的索引数据源
    tableView.indexDataSource = self;
    
    [self.view addSubview:tableView];
    
    //创建一个按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"reloadTable" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 数据源
    dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSource addObject:@(i+1)];
    }
}


#pragma mark IndexedTableViewDataSource

- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView{
    
    //奇数次调用返回6个字母，偶数次调用返回11个
    static BOOL change = NO;
    
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }
    else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
    
}

- (UIColor *)indexTitlesSelectedColorForIndexTableView:(UITableView *)tableView currentIndex:(NSInteger)currentIndex{
    return [UIColor blueColor];
}

- (UIColor *)indexTitlesColorForIndexTableView:(UITableView *)tableView currentIndex:(NSInteger)currentIndex{
     return [UIColor lightGrayColor];
}


- (BOOL)indexTitlesClickSelectedForIndexTableView:(UITableView *)tableView currentIndex:(NSInteger)currentIndex{
    if (currentIndex == 0) {
        return NO;
    }
    return YES;
}

- (void)indexTitlesForIndexTableViewClickedIndex:(NSInteger)index {
    
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果重用池当中没有可重用的cell，那么创建一个cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 文案设置
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    
    //返回一个cell
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)doAction:(id)sender{
//    NSLog(@"reloadData");
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
