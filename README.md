# ShareBar-Demo
ShareBar,a custom menu deafult supports share platform,it not a demo,just ui is a demo

![](https://raw.githubusercontent.com/shaojiankui/ShareBar-Demo/master/demo.gif)


##usage

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




