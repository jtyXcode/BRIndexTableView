//
//  BRViewPool.h
//  BRIndexTableView
//
//  Created by 袁涛 on 2018/7/10.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BRReuseViewPool : NSObject

- (UIView * _Nullable)dequeueReuseableView;

- (void)addUsingView:(UIView *)view;

- (void)reset;

@end
