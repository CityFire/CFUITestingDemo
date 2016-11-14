//
//  ViewController.m
//  CFUITestingDemo
//
//  Created by wjc on 16/10/28.
//  Copyright © 2016年 wjc. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "blueView.h"
#import "yellowView.h"
#import "RedView.h"
#import "OrangeView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet MainView *mainView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet OrangeView *orangeView;
@property (weak, nonatomic) IBOutlet blueView *blueView;
@property (weak, nonatomic) IBOutlet yellowView *yellowView;
@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UIView *pinkView;

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.blueView.clipsToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@, tag:%@", self.view.subviews, @(self.view.tag));
//
//    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"subView%@:%@, tag:%@", @(idx), subView, @(subView.tag));
//    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
