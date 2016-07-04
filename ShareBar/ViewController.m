//
//  ViewController.m
//  ShareBar
//
//  Created by Jakey on 16/3/30.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareTouched:(id)sender {
    ShareBar *shareBar = [ShareBar bar];
    
    [shareBar addPlatform:@"微信" icon:[UIImage imageNamed:@"share_icon_weixin"] handler:^(id data) {
        NSLog(@"微信");
    }];
    [shareBar addPlatform:@"朋友圈" icon:[UIImage imageNamed:@"share_icon_pengyouquan"] handler:^(id data) {
        NSLog(@"朋友圈");
    }];
    [shareBar addPlatform:@"学员地盘" icon:[UIImage imageNamed:@"share_icon_zone"] handler:^(id data) {
        NSLog(@"学员地盘");
    }];
    [shareBar addPlatform:@"教师地盘" icon:[UIImage imageNamed:@"share_icon_teacher"] handler:^(id data) {
        NSLog(@"教师地盘");
    }];
    
    [shareBar show];
}
@end
