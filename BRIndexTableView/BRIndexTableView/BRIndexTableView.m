//
//  BRIndexTableView.m
//  BRIndexTableView
//
//  Created by 袁涛 on 2018/7/10.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import "BRIndexTableView.h"
#import "BRReuseViewPool.h"

#define BR_SEND_TAG 1000

@interface BRIndexTableView (){
    UIView 					*containerView;
    BRReuseViewPool 		*reuseViewPool;
}

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation BRIndexTableView

- (void)setIndexDataSource:(id<BRIndexTableViewDataSource>)indexDataSource {
    if (_indexDataSource != indexDataSource) {
        _indexDataSource = indexDataSource;
    }
}

- (void)reloadData {
    [super reloadData];
    
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reuseViewPool == nil) {
        reuseViewPool = [[BRReuseViewPool alloc] init];
    }
    
    [reuseViewPool reset];
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    NSArray <NSString *> *arrayTitles = nil;
    if (self.indexDataSource && [self.indexDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexDataSource indexTitlesForIndexTableView:self];
    }
    
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }

    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    _selectedButton.selected = NO;
    for (int i = 0; i < count; i++) {
        UIButton *button = [reuseViewPool dequeueReuseableView];
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            [reuseViewPool addUsingView:button];
        }
        
        if ([_selectedButton.titleLabel.text isEqualToString:arrayTitles[i]]) {
            button.selected = YES;
            _selectedButton = button;
        }
        button.tag = BR_SEND_TAG + i;
        [button removeTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:arrayTitles[i] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
        [containerView addSubview:button];
        if (_indexDataSource) {
            
            if ([_indexDataSource respondsToSelector:@selector(indexTitlesColorForIndexTableView:)]) {
                [button setTitleColor:[_indexDataSource indexTitlesColorForIndexTableView:self] forState:UIControlStateNormal];
            }else {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
            if ([_indexDataSource respondsToSelector:@selector(indexTitlesSelectedColorForIndexTableView:)]) {
                [button setTitleColor:[_indexDataSource indexTitlesSelectedColorForIndexTableView:self] forState:UIControlStateSelected];
            }else {
                [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
            }
            
            
        }
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
    
}


#pragma mark - on click
- (void)buttonClicked:(UIButton *)sender {
    if (_indexDataSource) {
        if([_indexDataSource respondsToSelector:@selector(indexTitlesForIndexTableViewClickedIndex:)]) {
            NSInteger index = sender.tag - BR_SEND_TAG;
            [_indexDataSource indexTitlesForIndexTableViewClickedIndex:index];
        }
      
        if ([_indexDataSource respondsToSelector:@selector(indexTitlesClickSelectedForIndexTableView:)]) {
            [self selectedClicked:sender];
        }
    }

}

- (void)selectedClicked:(UIButton *)sender {
    if ([_indexDataSource indexTitlesClickSelectedForIndexTableView:self]) {
        _selectedButton.selected = NO;
        sender.selected = !sender.isSelected;
        _selectedButton = sender;
    }
}



@end
