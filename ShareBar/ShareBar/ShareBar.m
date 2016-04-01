//
//  ShareBar.m
//  ShareBar
//
//  Created by Jakey on 16/3/30.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "ShareBar.h"
#import "ShareBarItem.h"
@interface ShareBar()
{
    SelectPlatformHandler _selectPlatformHandler;
    ShareButtonHandler _thumbButtonHandler;
}
@property (nonatomic,strong) NSMutableArray *manualButtons;
@property (nonatomic,strong) NSMutableArray *activePlatforms;

@property (nonatomic,strong) UIView *titieView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *thumbButton;

@end

@implementation ShareBar

-(void)reloadData:(BOOL)relayout{
  
    if (relayout) {
        self.scrollView.frame = CGRectMake(0, 20, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-20);
        self.titieView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 20);
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.titieView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    }else{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self addSubview:self.titieView];
        [self addSubview:self.scrollView];
    }
    self.thumbButton.frame = CGRectMake(CGRectGetWidth(self.titieView.frame)-50, 0, 50, CGRectGetHeight(self.titieView.frame));
    [self.titieView addSubview:self.thumbButton];
   
    NSArray *total = [self.activePlatforms arrayByAddingObjectsFromArray:self.manualButtons];
    CGFloat width = ([total count]<=5)?(CGRectGetWidth(self.scrollView.frame)/[total count]):((self.itemWidth>0)?:64);
            width = (width<=CGRectGetWidth(self.scrollView.frame)/[total count])?CGRectGetWidth(self.scrollView.frame)/[total count]:((self.itemWidth>0)?:64);
//    NSLog(@"width:%lf",width);
   
    [total enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShareBarItem *buttonItem = [ShareBarItem buttonWithType:UIButtonTypeCustom];
        [buttonItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [buttonItem setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        buttonItem.titleLabel.textAlignment = NSTextAlignmentCenter;
        buttonItem.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        buttonItem.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [buttonItem setTitle:[obj objectForKey:@"title"] forState:UIControlStateNormal];
        
        if ([[obj objectForKey:@"icon"] isKindOfClass:[UIImage class]]) {
            [buttonItem setBackgroundImage:[obj objectForKey:@"icon"] forState:UIControlStateNormal];
        }
        [buttonItem.layer setBorderWidth:1];
        buttonItem.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:230/255.0 blue:232/255.0 alpha:1] CGColor];
        
        buttonItem.frame = CGRectMake(idx*width, 0, width, CGRectGetHeight(self.scrollView.frame));
        [buttonItem addTarget:self action:@selector(selectedPlatform:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonItem.userInfo = obj;
        
        [self.scrollView addSubview:buttonItem];
    }];
    self.scrollView.contentSize = CGSizeMake(width*[total count], CGRectGetHeight(self.scrollView.frame));
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self reloadData:YES];
}

-(UIView *)titieView{
    if (!_titieView) {
        _titieView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _titieView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrollView;
}
-(UIButton *)thumbButton{
    if(!_thumbButton){
        _thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thumbButton setTitle:@"赞" forState:UIControlStateNormal];
        [_thumbButton addTarget:self action:@selector(thumbButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thumbButton;
}
-(NSMutableArray *)manualButtons{
    if (!_manualButtons) {
        _manualButtons = [NSMutableArray array];
    }
    return _manualButtons;
}
-(NSMutableArray *)activePlatforms{
    if (!_activePlatforms) {
          _activePlatforms = [NSMutableArray array];
    }
    return _activePlatforms;
}

-(void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    [self reloadData:NO];
}
#pragma --mark handler method
-(IBAction)thumbButtonTouched:(id)sender{
    if (_thumbButtonHandler) {
        _thumbButtonHandler(nil);
    }
}
-(IBAction)selectedPlatform:(ShareBarItem*)buttonItem{
    if (_selectPlatformHandler && buttonItem.userInfo) {
        if ([buttonItem.userInfo objectForKey:@"identifier"]) {
            _selectPlatformHandler((ShareBarPlatform)[[buttonItem.userInfo objectForKey:@"identifier"] integerValue]);
        }
        if ([buttonItem.userInfo objectForKey:@"handler"]) {
            ShareButtonHandler handler = [buttonItem.userInfo objectForKey:@"handler"];
            if(handler){
                handler(buttonItem.userInfo);
            }
        }
    }
    
}
-(void)thumbButtonHandler:(ShareButtonHandler)shareButtonHandler{
    _thumbButtonHandler = [shareButtonHandler copy];
}
-(void)activePlatforms:(ShareBarPlatform)platform handler:(SelectPlatformHandler)selectPlatformHandler{
    _selectPlatformHandler = [selectPlatformHandler copy];
    [self active:platform];
}
-(void)addPlatform:(NSString*)title icon:(UIImage*)icon handler:(ShareButtonHandler)shareButtonHandler{
    [self.manualButtons addObject:@{@"title":title,@"icon":icon,@"handler":[shareButtonHandler copy]}];
    [self reloadData:NO];
}

//-(void)enable:(BOOL)enable withPlatform:(SHARE_PLATFORM)platform{
//    for (NSDictionary *dic in self.activePlatforms) {
//        if (!enable && [[dic objectForKey:@"identifier"] integerValue] == platform) {
//            [self.activePlatforms removeObject:dic];
//        }else{
//          [self active:platform];
//        }
//    }
//}
- (void)active:(ShareBarPlatform)platform
{
    if (platform == 0)
    {
        return;
    }
    if (platform & ShareBarPlatformWeixin){
        [self.activePlatforms addObject:@{@"title":@"微信",@"icon":@"share_weixin_icon",@"identifier":@(ShareBarPlatformWeixin)}];
        
    }
    if (platform & ShareBarPlatformPengyouquan){
        [self.activePlatforms addObject:@{@"title":@"朋友圈",@"icon":@"share_weixin_pengyouquan_icon",@"identifier":@(ShareBarPlatformPengyouquan)}];
        
    }
    if (platform & ShareBarPlatformWeibo){
        [self.activePlatforms addObject:@{@"title":@"微博",@"icon":@"share_weibo_icon",@"identifier":@(ShareBarPlatformWeibo)}];
        
    }
    if (platform & ShareBarPlatformQQ){
        [self.activePlatforms addObject:@{@"title":@"QQ",@"icon":@"share_qq_icon",@"identifier":@(ShareBarPlatformQQ)}];
        
    }
    if ((platform & ShareBarPlatformQQZone) == ShareBarPlatformQQZone){
        [self.activePlatforms addObject:@{@"title":@"QQ空间",@"icon":@"share_qqzone_icon",@"identifier":@(ShareBarPlatformQQZone)}];
        
    }
    [self reloadData:NO];
}

@end
