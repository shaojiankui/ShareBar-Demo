# ShareBar-Demo
ShareBar,a custom menu deafult supports share platform,it not a demo,just ui is a demo

![image](https://raw.githubusercontent.com/shaojiankui/ShareBar-Demo/master/show.png)

##usage

	@property (weak, nonatomic) IBOutlet ShareBar *shareBar;

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





