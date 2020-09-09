//
//  BUDAdmobDislikeReasonChoiceTableView.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmobDislikeReasonChoiceView.h"

#define rowHeight 50
#define rowWidth 200

@implementation BUDAdmobDislikeReasonChoiceView

- (instancetype)initWithPosition:(CGPoint)position andReasons:(NSArray<GADMuteThisAdReason *> *)reasons {
    if (self = [super init]) {
        self.reasons = reasons;
        self.position = position;
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self calculateFrame];
        [self addSubview:self.tableView];
        [self.tableView reloadData];
    }
    return self;
}

- (void)calculateFrame {
    CGFloat height = rowHeight * self.reasons.count, width = rowWidth;
    CGFloat x = self.position.x - width, y = self.position.y - height;
    self.tableView.frame = CGRectMake(0, 0, width, height);
    self.frame = CGRectMake(x, y, width, height);
}

# pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reasons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    UILabel *label = [[UILabel alloc] init];
    label.text = [self.reasons objectAtIndex:index].reasonDescription;
    label.frame = CGRectMake(20, 15, rowWidth, rowHeight * 0.5);
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.contentView addSubview:label];
    return cell;
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView  heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    // tell the delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(muteNativeAd:withDislikeReason:)]) {
        [self.delegate muteNativeAd:self withDislikeReason:self.reasons[index]];
    }
    // remove self from superview
    [self removeFromSuperview];
}

@end
