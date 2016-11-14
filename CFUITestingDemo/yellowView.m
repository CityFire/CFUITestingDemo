//
//  yellowView.m
//  CFUITestingDemo
//
//  Created by wjc on 16/10/29.
//  Copyright © 2016年 wjc. All rights reserved.
//

#import "yellowView.h"

@implementation yellowView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 1.判断当前控件是否接受事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    // 2.判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) {
        return nil;
    }
    // 3.从后往前遍历自己的子控件
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 寻找到最合适的view
            NSLog(@"subView%@:%@, tag:%@, alpha:%f", @(i), fitView, @(fitView.tag), fitView.alpha);
            return fitView;
        }
    }
    
    // 循环结束，表示没有比自己更合适的view
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}

@end
