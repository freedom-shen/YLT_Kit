//
//  UITableViewCell+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UITableViewCell+YLT_Create.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <objc/message.h>
#import "UIImage+YLT_Extension.h"
#import "UIImageView+YLT_Create.h"
#import "UILabel+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UITableViewCell (YLT_Create)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject ylt_swizzleSelectorInClass:[UITableView class] originalSel:@selector(initWithStyle:reuseIdentifier:) replaceSel:@selector(initWithStyle:YLT_ReuseIdentifier:)];
    });
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style YLT_ReuseIdentifier:(NSString *)reuseIdentifier {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self respondsToSelector:@selector(YLT_cellStyle)]) {
        style = (UITableViewCellStyle)[self performSelector:@selector(YLT_CellStyle) withObject:nil];
    }
#pragma clang diagnostic pop
    self = [self initWithStyle:style YLT_ReuseIdentifier:reuseIdentifier];
    self.ylt_cellConfigUI();
    return self;
}


- (void)setCellData:(id)cellData {
    objc_setAssociatedObject(self, @selector(cellData), cellData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cellData {
    return objc_getAssociatedObject(self, @selector(cellData));
}


/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))ylt_cellBindData {
    @weakify(self);
    return ^id(NSIndexPath *indexPath, id bindData) {
        @strongify(self);
        self.cellData = bindData;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(YLT_IndexPath:bindData:)]) {
            [self performSelector:@selector(YLT_IndexPath:bindData:) withObject:indexPath withObject:bindData];
        }
#pragma clang diagnostic pop
        return self;
    };
}
/**
 处理UI
 */
- (UITableViewCell *(^)(void))ylt_cellConfigUI {
    @weakify(self);
    return ^id() {
        @strongify(self);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(YLT_configUI)]) {
            [self performSelector:@selector(YLT_configUI) withObject:nil];
        }
#pragma clang diagnostic pop
        return self;
    };
}

/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))ylt_accessoryType {
    @weakify(self);
    return ^id(UITableViewCellAccessoryType accessoryType) {
        @strongify(self);
        self.accessoryType = accessoryType;
        return self;
    };
}
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))ylt_leftImage {
    @weakify(self);
    return ^id(id leftImg) {
        @strongify(self);
        self.imageView.ylt_image(leftImg);
        return self;
    };
}
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))ylt_title {
    @weakify(self);
    return ^id(NSString *title) {
        @strongify(self);
        self.textLabel.ylt_text(title);
        return self;
    };
}
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))ylt_subTitle {
    @weakify(self);
    return ^id(NSString *subTitle) {
        @strongify(self);
        self.detailTextLabel.ylt_text(subTitle);
        return self;
    };
}

@end