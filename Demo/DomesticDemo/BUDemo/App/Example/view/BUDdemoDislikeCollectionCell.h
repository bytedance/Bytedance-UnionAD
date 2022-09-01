//
//  BUDdemoDislikeCollectionCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/12/18.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
static const int margin = 15;
@class BUDislikeWords;
@interface BUDdemoDislikeCollectionCell : UICollectionViewCell
- (void)refleshUIWithModel:(BUDislikeWords *)dislikeWord;
@end

