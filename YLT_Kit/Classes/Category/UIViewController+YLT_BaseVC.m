//
//  UIViewController+YLT_BaseVC.m
//  Test
//
//  Created by 项普华 on 2018/4/3.
//  Copyright © 2018年 项普华. All rights reserved.
//

#import "UIViewController+YLT_BaseVC.h"
#import <objc/message.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIViewController (YLT_BaseVC)

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewDidLoad) withMethod:@selector(ylt_viewDidLoad)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillAppear:) withMethod:@selector(ylt_viewWillAppear:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillLayoutSubviews) withMethod:@selector(ylt_viewWillLayoutSubviews)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillDisappear:) withMethod:@selector(ylt_viewWillDisappear:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(prepareForSegue:sender:) withMethod:@selector(ylt_prepareForSegue:sender:)];
    });
}

#pragma mark - hook
- (void)ylt_viewDidLoad {
    [self ylt_viewDidLoad];
    if ([self respondsToSelector:@selector(ylt_setup)]) {
        [self performSelector:@selector(ylt_setup)];
    }
    if ([self respondsToSelector:@selector(ylt_addSubViews)]) {
        [self performSelector:@selector(ylt_addSubViews)];
    }
    if ([self respondsToSelector:@selector(ylt_request)]) {
        [self performSelector:@selector(ylt_request)];
    }
}

- (void)ylt_viewWillAppear:(BOOL)animated {
    [self ylt_viewWillAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self respondsToSelector:@selector(ylt_bindData)]) {
            [self performSelector:@selector(ylt_bindData)];
        }
    });
}

- (void)ylt_viewWillLayoutSubviews {
    [self ylt_viewWillLayoutSubviews];
    if ([self respondsToSelector:@selector(ylt_layout)]) {
        [self performSelector:@selector(ylt_layout)];
    }
}

- (void)ylt_viewWillDisappear:(BOOL)animated {
    [self ylt_viewWillDisappear:animated];
    if (self.navigationController && self.navigationController.viewControllers.count != 1 && [self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if ([self respondsToSelector:@selector(ylt_dismiss)]) {
            [self performSelector:@selector(ylt_dismiss)];
        }
        if ([self respondsToSelector:@selector(ylt_back)]) {
            [self performSelector:@selector(ylt_back)];
        }
    } else if (self.presentedViewController == nil) {
        if ([self respondsToSelector:@selector(ylt_dismiss)]) {
            [self performSelector:@selector(ylt_dismiss)];
        }
        if ([self respondsToSelector:@selector(ylt_back)]) {
            [self performSelector:@selector(ylt_back)];
        }
    }
}

- (void)ylt_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self ylt_prepareForSegue:segue sender:sender];
    if (segue && [segue respondsToSelector:@selector(destinationViewController)] && [segue.destinationViewController respondsToSelector:@selector(setylt_params:)]) {
        [segue.destinationViewController performSelector:@selector(setylt_params:) withObject:sender];
    }
}

#pragma mark - Public Method

/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)ylt_createVC {
    UIViewController *vc = [[self alloc] init];
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param {
    UIViewController *vc = [self ylt_createVC];
    if ([vc respondsToSelector:@selector(setylt_params:)]) {
        [vc performSelector:@selector(setylt_params:) withObject:ylt_param];
    }
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param
                                   callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param];
    if ([vc respondsToSelector:@selector(setYlt_callback:)]) {
        [vc performSelector:@selector(setYlt_callback:) withObject:callback];
    }
    return vc;
}

/**
 创建视图并PUSH到对应的视图
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_pushVCWithParam:(id)ylt_param
                                 callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param callback:callback];
    if (self.ylt_currentVC.navigationController == nil) {
        UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.ylt_currentVC presentViewController:rootNavi animated:YES completion:nil];
        return vc;
    }
    [self.ylt_currentVC.navigationController pushViewController:vc animated:YES];
    return vc;
}

/**
 创建控制器并Modal到对应的视图
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_modalVCWithParam:(id)ylt_param
                                  callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param callback:callback];
    [self.ylt_currentVC presentViewController:vc animated:YES completion:nil];
    return vc;
}

#pragma clang diagnostic pop
@end
