//
//  BRViewPool.m
//  BRIndexTableView
//
//  Created by 袁涛 on 2018/7/10.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import "BRReuseViewPool.h"

@interface BRReuseViewPool ()
@property (nonatomic, strong) NSMutableSet *usingQueue;
@property (nonatomic, strong) NSMutableSet *waitUseQueue;
@end

@implementation BRReuseViewPool

- (instancetype)init {
    self = [super init];
    if (self) {
        _usingQueue = [NSMutableSet setWithCapacity:5];
        _waitUseQueue = [NSMutableSet setWithCapacity:5];
    }
    return self;
}


- (UIView *_Nullable)dequeueReuseableView {
    UIView *view = [_waitUseQueue anyObject];
    if (view == nil) {
        return nil;
    }
    [_waitUseQueue removeObject:view];
    [_usingQueue addObject:view];
    return view;
}

- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUseQueue addObject:view];
    }
}



@end
