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
    
    
    [self.shareBar activePlatforms:ShareBarPlatformWeixin|ShareBarPlatformWeibo handler:^(ShareBarPlatform platformType) {
        switch (platformType) {
            case ShareBarPlatformWeixin:
            {
                NSLog(@"微信");
            }
                break;
            case ShareBarPlatformPengyouquan:
            {
                NSLog(@"朋友圈");
            }
                break;
            case ShareBarPlatformWeibo:
            {
                NSLog(@"微博");
            }
                break;
            case ShareBarPlatformQQ:
            {
                NSLog(@"QQ");
            }
                break;
            case ShareBarPlatformQQZone:
            {
                NSLog(@"QQZONE");
            }
                break;
            default:
                break;
        }
    }];
    [self.shareBar thumbButtonHandler:^(id item) {
        NSLog(@"点个赞");
    }];
  
    
    [self.shareBar addPlatform:@"手动添加" icon:[UIImage imageNamed:@"we.png"] handler:^(id item) {
        NSLog(@"手动添加1");
    }];
    [self.shareBar addPlatform:@"手动添加2" icon:[UIImage imageNamed:@"we.png"] handler:^(id item) {
        NSLog(@"手动添加2");
    }];
  
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
