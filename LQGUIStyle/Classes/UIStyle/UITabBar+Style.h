//
//  UITabBar+Style.h
//  LQGUIStyle
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UITabBar样式
 
 - UITabBarStyleWhite: 白色
 */
typedef NS_ENUM(NSInteger, UITabBarStyle) {
    UITabBarStyleWhite = 1,
};

/// UITabBar主题
@interface UITabBar (Style)

/// 是否隐藏阴影
@property (nonatomic, assign) BOOL hiddenShadow;

/// 样式
@property (nonatomic, assign) UITabBarStyle style;

@end
