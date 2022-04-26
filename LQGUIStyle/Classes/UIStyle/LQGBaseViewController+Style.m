//
//  LQGBaseViewController+Style.m
//  LQGUIStyle
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "LQGBaseViewController+Style.h"

#import "UINavigationBar+Style.h"

#import <LQGCategory/LQGCategory.h>

@implementation LQGBaseViewController (Style)

+ (void)load {
    [self replaceMethodWithOldSelector:@selector(lqg_preferredStatusBarStyle) newSelector:@selector(_lqg_preferredStatusBarStyle)];
    [self replaceMethodWithOldSelector:@selector(lqg_setupNavigationBar) newSelector:@selector(_lqg_setupNavigationBar)];
}

- (UIStatusBarStyle)_lqg_preferredStatusBarStyle {
    return self.navigationBar.style == UINavigationBarStyleBlack ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (void)_lqg_setupNavigationBar {
    self.navigationBar.style = UINavigationBarStyleWhite;
    self.navigationBar.hiddenShadow = NO;
    [self _lqg_setupNavigationBar];
}

@end
