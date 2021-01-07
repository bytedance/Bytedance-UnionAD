//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDBaseExampleViewController.h"

@class BUDActionModel;

@interface BUDListViewController : BUDBaseExampleViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList;

@end