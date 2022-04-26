//
//  UINavigationBar+Style.h
//  LQGUIStyle
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UINavigationBar样式
 
 - UINavigationBarStyleWhite: 白底黑字
 - UINavigationBarStyleBlack: 黑底白字
 */
typedef NS_ENUM(NSInteger, UINavigationBarStyle) {
    UINavigationBarStyleWhite = 1,
    UINavigationBarStyleBlack = 2,
};

/// UINavigationBar主题
@interface UINavigationBar (Style)

/// 是否隐藏阴影
@property (nonatomic, assign) BOOL hiddenShadow;

/// 样式
@property (nonatomic, assign) UINavigationBarStyle style;

@end
