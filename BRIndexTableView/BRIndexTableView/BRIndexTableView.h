//
//  BRIndexTableView.h
//  BRIndexTableView
//
//  Created by 袁涛 on 2018/7/10.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BRIndexTableViewDataSource <NSObject>
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@optional
- (void)indexTitlesForIndexTableViewClickedIndex:(NSInteger)index;

/**
 文字被选中是否能修改更换颜色 NO(不能被更换文字颜色)
 */
- (BOOL)indexTitlesClickSelectedForIndexTableView:(UITableView *)tableView;

/**
 未选中的颜色
 */
- (UIColor *)indexTitlesColorForIndexTableView:(UITableView *)tableView;

/**
 选中后的颜色
 */
- (UIColor *)indexTitlesSelectedColorForIndexTableView:(UITableView *)tableView;
@end


@interface BRIndexTableView : UITableView <BRIndexTableViewDataSource>
@property (nonatomic, weak) id <BRIndexTableViewDataSource> indexDataSource;
@end
