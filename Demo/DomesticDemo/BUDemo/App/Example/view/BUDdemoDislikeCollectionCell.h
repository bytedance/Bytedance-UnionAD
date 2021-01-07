//
//  BUDdemoDislikeCollectionCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/12/18.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <BUAdSDK/BUAdSDK.h>
static const int margin = 15;

@interface BUDdemoDislikeCollectionCell : UICollectionViewCell
- (void)refleshUIWithModel:(BUDislikeWords *)dislikeWord;
@end

