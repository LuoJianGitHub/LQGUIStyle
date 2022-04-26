//
//  UITabBar+Style.m
//  LQGUIStyle
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "UITabBar+Style.h"

#import <LQGCategory/LQGCategory.h>

@implementation UITabBar (Style)

+ (void)load {
    [self replaceMethodWithOldSelector:@selector(initWithFrame:) newSelector:@selector(lqg_initWithFrame:)];
}

- (instancetype)lqg_initWithFrame:(CGRect)frame {
    if ([self lqg_initWithFrame:frame]) {
        self.layer.shadowColor   = [UIColor blackColor].CGColor;// 阴影的颜色
        self.layer.shadowOpacity = 0.1;                         // 阴影透明度
        self.layer.shadowRadius  = 2;                           // 阴影扩散的范围控制
        self.layer.shadowOffset  = CGSizeZero;                  // 阴影的范围
    }
    return self;
}

- (BOOL)hiddenShadow {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHiddenShadow:(BOOL)hiddenShadow {
    objc_setAssociatedObject(self, @selector(hiddenShadow), @(hiddenShadow), OBJC_ASSOCIATION_COPY);
    
    self.layer.shadowOpacity = hiddenShadow ? 0.f : 0.1f;
}

- (UITabBarStyle)style {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setStyle:(UITabBarStyle)style {
    if (!style) return;
    if (style == self.style) return;
    
    objc_setAssociatedObject(self, @selector(style), @(style), OBJC_ASSOCIATION_COPY);
    
    UIColor *barTintColor, *normalTintColor, *selectedTintColor;
    switch (style) {
        case UITabBarStyleWhite:
            barTintColor = [UIColor whiteColor];
            normalTintColor = [UIColor colorWithHex:0x4D4D4D];
            selectedTintColor = [UIColor colorWithHex:0xFF730F];
            break;
        default:
            break;
    }
    
    UIImage *shadowImage = [UIImage new];
    UIImage *backgroundImage = [UIImage imageWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 49) color:barTintColor];
    UIFont *itemFont = [UIFont systemFontOfSize:10];
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        
        appearance.shadowColor = [UIColor clearColor];
        appearance.shadowImage = shadowImage;
        
        appearance.backgroundImage = backgroundImage;
        appearance.backgroundImageContentMode = UIViewContentModeScaleToFill;

        self.scrollEdgeAppearance = self.standardAppearance = appearance;
        
        self.unselectedItemTintColor = normalTintColor;
        self.tintColor = selectedTintColor;
        
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{NSFontAttributeName:itemFont}
                            forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:itemFont}
                            forState:UIControlStateSelected];
    } else {
        self.shadowImage = shadowImage;
        
        self.backgroundImage = backgroundImage;
        
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:normalTintColor,
                                       NSFontAttributeName:itemFont}
                            forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:selectedTintColor,
                                       NSFontAttributeName:itemFont}
                            forState:UIControlStateSelected];
    }
}

@end
