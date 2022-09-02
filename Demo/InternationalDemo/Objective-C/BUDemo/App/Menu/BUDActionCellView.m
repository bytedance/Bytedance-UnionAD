//
//  BUDActionCellView.m
//  BUAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDActionCellView.h"
#import "BUDMacros.h"
#define inconWidth 28
@class BUDPlainTitleActionModel;

@implementation BUDPlainTitleActionModel

@end

@implementation BUDActionModel (BUDModelFactory)

+ (instancetype)plainTitleActionModel:(NSString *)title type:(BUDCellType)type action:(ActionCommandBlock)action {
    BUDPlainTitleActionModel *model = [BUDPlainTitleActionModel new];
    model.title = title;
    model.cellType = type;
    model.action = [action copy];
    return model;
}

@end

@interface BUDActionCellView ()
@property (nonatomic, strong) BUDPlainTitleActionModel *model;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *titleLable;
@end

@implementation BUDActionCellView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.img = [UIImageView new];
        self.img.frame = CGRectMake(15, (self.frame.size.height - inconWidth)/2, inconWidth , inconWidth);
        [self.contentView addSubview:self.img];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(inconWidth + self.img.frame.origin.x + 15, self.img.frame.origin.y, 300, inconWidth)];
//        self.titleLable.textColor =BUD_RGB(0x8a, 0x8a, 0x89);
        [self.contentView addSubview:self.titleLable];
    }
    return self;
}

- (void)configWithModel:(BUDPlainTitleActionModel *)model {
    if ([model isKindOfClass:[BUDPlainTitleActionModel class]]) {
        self.model = model;
        self.titleLable.text = self.model.title;
        NSString *imageString = nil;
        switch (model.cellType) {
            case BUDCellType_native:
                imageString = @"demo_native.png";
                break;
            case BUDCellType_normal:
                imageString = @"demo_normal.png";
                break;
            case BUDCellType_video:
                imageString = @"demo_video.png";
                break;
                
            case BUDCellType_CustomEvent:
                imageString = @"demo_CustomEvent.png";
                break;
                
            default:
                imageString = @"demo_setting.png";
                break;
        }
        self.img.image = [UIImage imageNamed:imageString];
    }
}

- (void)execute {
    if (self.model.action) {
        self.model.action();
    }
}

@end
