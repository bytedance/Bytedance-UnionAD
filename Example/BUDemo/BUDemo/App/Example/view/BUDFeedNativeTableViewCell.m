//
//  BUDFeedNativeTableViewCell.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/3.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDFeedNativeTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+LocalizedString.h"

@implementation BUDFeedNativeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Custom 视图测试
        CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
        _customview = [[UIView alloc] initWithFrame:CGRectMake(20, 0, swidth - 40, 240)];
        _customview.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_customview];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, swidth - 60, 30)];
        _titleLabel.text = [NSString localizedStringForKey:Testads];
        [_customview addSubview:_titleLabel];
        
        _adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 160, 120)];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.backgroundColor = [UIColor redColor];
        [_customview addSubview:_adImageView];
        
        _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 75, -80, 30)];
        [_phoneButton setTitle:[NSString localizedStringForKey:Call] forState:UIControlStateNormal];
        _phoneButton.userInteractionEnabled = YES;
        _phoneButton.backgroundColor = [UIColor orangeColor];
        [_customview addSubview:_phoneButton];
        
        _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 120, -80, 30)];
        [_downloadButton setTitle:[NSString localizedStringForKey:DownloadLinks] forState:UIControlStateNormal];
        _downloadButton.userInteractionEnabled = YES;
        _downloadButton.backgroundColor = [UIColor orangeColor];
        [_customview addSubview:_downloadButton];
        
        _urlButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 165, -80, 30)];
        [_urlButton setTitle:[NSString localizedStringForKey:URLLinks] forState:UIControlStateNormal];
        _urlButton.userInteractionEnabled = YES;
        _urlButton.backgroundColor = [UIColor orangeColor];
        [_customview addSubview:_urlButton];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y, swidth - 60, 30)];
        _infoLabel.font = [UIFont systemFontOfSize:12];
        _infoLabel.text = [NSString localizedStringForKey:Testads];
        [_customview addSubview:_infoLabel];
    }
    return self;
}


@end
