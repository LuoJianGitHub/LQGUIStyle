//
//  UINavigationBar+Style.m
//  LQGUIStyle
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

#import "UINavigationBar+Style.h"

#import <LQGMacro/LQGMacro.h>
#import <LQGCategory/LQGCategory.h>

@implementation UINavigationBar (Style)

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

- (UINavigationBarStyle)style {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setStyle:(UINavigationBarStyle)style {
    if (!style) return;
    if (style == self.style) return;
    
    objc_setAssociatedObject(self, @selector(style), @(style), OBJC_ASSOCIATION_COPY);
    
    UIColor *barTintColor, *tintColor;
    switch (style) {
        case UINavigationBarStyleWhite:
            barTintColor = [UIColor whiteColor];
            tintColor = [UIColor colorWithHex:0x333333];
            break;
        case UINavigationBarStyleBlack:
            barTintColor = [UIColor blackColor];
            tintColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    
    UIImage *shadowImage = [UIImage new];
    UIImage *backgroundImage = [UIImage imageWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64) color:barTintColor];
    NSDictionary *titleTextAttributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName:tintColor
    };
    UIFont *itemFont = [UIFont systemFontOfSize:15];
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        
        appearance.shadowColor = [UIColor clearColor];
        appearance.shadowImage = shadowImage;
        
//        appearance.backgroundImage = backgroundImage;
//        appearance.backgroundImageContentMode = UIViewContentModeScaleToFill;
        
        appearance.backgroundColor = barTintColor;

        appearance.titleTextAttributes = titleTextAttributes;
        
        appearance.buttonAppearance.normal.titleTextAttributes = appearance.buttonAppearance.highlighted.titleTextAttributes = @{
            NSFontAttributeName:itemFont,
            NSForegroundColorAttributeName:tintColor
        };
        
        self.scrollEdgeAppearance = self.standardAppearance = appearance;
    } else {
        self.shadowImage = shadowImage;
        
//        [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        
        self.barTintColor = barTintColor;
        
        self.titleTextAttributes = titleTextAttributes;
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:itemFont}
                                                    forState:UIControlStateNormal];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:itemFont}
                                                    forState:UIControlStateHighlighted];
    }
    
    self.tintColor = tintColor;
            
    self.translucent = NO;
}

@end
