//
//  MainView.m
//  CFUITestingDemo
//
//  Created by wjc on 16/10/29.
//  Copyright © 2016年 wjc. All rights reserved.
//

#import "MainView.h"

@implementation MainView

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

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    NSString *str1 = @"画线";
    [self drawText:str1 atPoint:CGPointMake(20.0, 20.0) FontSize:15];
    [self drawLineOnContext:context FromPoint:CGPointMake(20.0, 40.0)  toPoint:CGPointMake(300.0, 40.0)];
    
    NSString *str2 = @"画多边形和阴影和填充颜色";
    [self drawText:str2 atPoint:CGPointMake(20.0, 50.0) FontSize:15];
    
    UIBezierPath *btnPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20.0, 70.0, 280.0, 50) cornerRadius:4];
    
    do {
        CGContextSaveGState(context);
        //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(-1, -1), 3.0, [UIColor whiteColor].CGColor);
        CGContextAddPath(context, btnPath.CGPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    } while (0);
    
    //设置阴影
    CGContextSetShadow(context, CGSizeMake(2, 2), 10);
    //添加高亮效果
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //开始描边
    [[UIColor blackColor] setStroke];
    //[btnPath stroke];
    //开始填充颜色
    [btnPath fill];
    
    NSString *str3 = @"渐变填充颜色";
    //去除阴影
    CGContextSetShadow(context, CGSizeMake(0, 0), 0);
    [self drawText:str3 atPoint:CGPointMake(20.0, 130.0) FontSize:15];
    
    
    CGContextSaveGState(context);
    CGRect newRect = CGRectMake(40.0, 150, 240, 50);
    UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:newRect];
    //CGContextAddRect(context, newRect);
    [newPath addClip];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0.3 green:0.0 blue:0.0 alpha:0.2].CGColor,
                        (__bridge id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.8].CGColor];
    const CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(40.0, 150.0), CGPointMake(280.0, 200.0), 0);
    
    CGContextRestoreGState(context);
    
    
    NSString *str4 = @"当前形变矩阵CTM";
    [self drawText:str4 atPoint:CGPointMake(20.0, 220.0) FontSize:15];
    
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CFRelease(colorSpace);
    CFRelease(gradient);
    
    /**
     *  ////////////////////
     */
    
    /*
    CGRect bounds = self.bounds;
    
    // 根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // 是最外层圆形成为视图的外接圆
    float maxRadius = hypotf(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        // 用来设置绘制起始位置
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    // 设置线条宽度为 10 点
    path.lineWidth = 10;
    
    // 设置绘制颜色为灰色
    [[UIColor lightGrayColor] setStroke];
    
    // 绘制路径
    [path stroke];
     
     */
}

- (void)drawText:(NSString *)str atPoint:(CGPoint)point FontSize:(float)fontSize
{
    [[UIColor blackColor] set];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]};
    [str drawAtPoint:point withAttributes:attributes];
}

-(void)drawLineOnContext:(CGContextRef)context FromPoint:(CGPoint)point1 toPoint:(CGPoint)point2
{
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextStrokePath(context);
}


@end
