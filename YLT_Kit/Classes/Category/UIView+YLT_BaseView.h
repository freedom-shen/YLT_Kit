//
//  UIView+YLT_BaseView.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/16.
//

#import <UIKit/UIKit.h>

@interface UIView (YLT_BaseView)

/**
 x
 */
@property (nonatomic, assign) CGFloat ylt_x;

/**
 y
 */
@property (nonatomic, assign) CGFloat ylt_y;

/**
 width
 */
@property (nonatomic, assign) CGFloat ylt_width;

/**
 height
 */
@property (nonatomic, assign) CGFloat ylt_height;

/**
 中心点 x
 */
@property (nonatomic, assign) CGFloat ylt_centerX;

/**
 中心点 y
 */
@property (nonatomic, assign) CGFloat ylt_centerY;

/**
 坐标 x, y点
 */
@property (nonatomic, assign) CGPoint ylt_origin;

/**
 宽高 width, height
 */
@property (nonatomic, assign) CGSize ylt_size;

/**
 视图的 顶点 min_y
 */
@property (nonatomic, assign) CGFloat ylt_top;

/**
 视图的 底点 max_y
 */
@property (nonatomic, assign) CGFloat ylt_bottom;

/**
 视图的 左边 min_x
 */
@property (nonatomic, assign) CGFloat ylt_left;

/**
 视图的 右边 max_x
 */
@property (nonatomic, assign) CGFloat ylt_right;

/**
 移除所有的子视图
 */
- (void)removeAllSubViews;

/**
 移除指定的所有子视图
 
 @param className 子视图类名字符串
 */
- (void)removeAllSubviewsClass:(NSString *)className;

@end
