//
//  ShareBar.m
//  ShareBar
//
//  Created by Jakey on 16/6/12.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "ShareBar.h"
#import "ShareBarItem.h"
#define CANCLE_HEIGHT 40
#define SELF_HEIGHT  130

@interface ShareBar()
{
    SelectPlatformHandler _selectPlatformHandler;
    UIView *_backgroundView;
}
@property (nonatomic,strong) NSMutableArray *activePlatforms;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *cancleButton;
@property (nonatomic,strong) UIView *borderLayer;


@end

@implementation ShareBar
+ (ShareBar*)bar{
    ShareBar *bar = [[ShareBar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SELF_HEIGHT)];
    return bar;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)reloadData:(BOOL)relayout{
    UIWindow *window      = [UIApplication sharedApplication].keyWindow;
    _backgroundView.frame = window.bounds;
    CGRect rect = self.frame;
    rect.size.width = window.bounds.size.width;
    rect.origin.y =CGRectGetMaxY(window.bounds) - CGRectGetHeight(rect);
    self.frame = rect;
    
    if (relayout) {
        self.scrollView.frame = CGRectMake(0, 5, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CANCLE_HEIGHT-5*2);
        self.cancleButton.frame = CGRectMake(0, CGRectGetHeight(self.frame)-CANCLE_HEIGHT, CGRectGetWidth(self.frame), CANCLE_HEIGHT);
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame)-CANCLE_HEIGHT, self.frame.size.width, [UIScreen mainScreen].scale/2.0);
    }else{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self addSubview:self.scrollView];
        [self addSubview:self.cancleButton];
        [self addSubview:self.borderLayer];
    }
    
    NSArray *total = self.activePlatforms;
    CGFloat width = ([total count]<=5)?(CGRectGetWidth(self.scrollView.frame)/[total count]):((self.itemWidth>0)?:64);
    width = (width<=CGRectGetWidth(self.scrollView.frame)/[total count])?CGRectGetWidth(self.scrollView.frame)/[total count]:((self.itemWidth>0)?:64);
    //    NSLog(@"width2:%lf",width);
    
    [total enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShareBarItem *buttonItem = [ShareBarItem buttonWithType:UIButtonTypeCustom];
        [buttonItem setTitleColor:[UIColor colorWithWhite:0.561 alpha:1.000] forState:UIControlStateNormal];
        [buttonItem setTitleColor:[UIColor colorWithWhite:0.561 alpha:1.000] forState:UIControlStateSelected];
        buttonItem.titleLabel.textAlignment = NSTextAlignmentCenter;
        buttonItem.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
        buttonItem.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [buttonItem setTitle:[obj objectForKey:@"title"] forState:UIControlStateNormal];
        
        if ([[obj objectForKey:@"icon"] isKindOfClass:[UIImage class]]) {
            [buttonItem setImage:[obj objectForKey:@"icon"] forState:UIControlStateNormal];
        }
        
        buttonItem.frame = CGRectMake(idx*width, 0, width, CGRectGetHeight(self.scrollView.frame));
        [buttonItem addTarget:self action:@selector(selectedPlatform:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonItem.userInfo = obj;
        
        [self.scrollView addSubview:buttonItem];
    }];
    self.scrollView.contentSize = CGSizeMake(width*[total count], CGRectGetHeight(self.scrollView.frame));
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIWindow *window      = [UIApplication sharedApplication].keyWindow;
    _backgroundView.frame = window.bounds;
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SELF_HEIGHT);
    rect.origin.y =CGRectGetMaxY(window.bounds) - CGRectGetHeight(rect);
    self.frame =rect;
    [self reloadData:YES];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrollView;
}

- (NSMutableArray *)activePlatforms{
    if (!_activePlatforms) {
        _activePlatforms = [NSMutableArray array];
    }
    return _activePlatforms;
}
- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
- (UIView *)borderLayer{
    if (!_borderLayer) {
        _borderLayer = [[UIView alloc] init];
        _borderLayer.backgroundColor = [UIColor colorWithWhite:0.898 alpha:1.000];
        _borderLayer.layer.shadowColor=[UIColor grayColor].CGColor;
        _borderLayer.layer.shadowOffset=CGSizeMake(0, 0.1);
        _borderLayer.layer.shadowOpacity=0.2;
    }
    return _borderLayer;
}
- (void)cancleButtonTouched:(UIButton*)button{
    [self dismiss];
}
- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    [self reloadData:NO];
}
#pragma --mark handler method

- (IBAction)selectedPlatform:(ShareBarItem*)buttonItem{
    if (buttonItem.userInfo) {
        if ([buttonItem.userInfo objectForKey:@"handler"]) {
            ShareButtonHandler handler = [buttonItem.userInfo objectForKey:@"handler"];
            if(handler){
                handler(buttonItem.userInfo);
            }
        }
    }
    [self dismiss];
}

- (void)addPlatform:(NSString*)title icon:(UIImage*)icon handler:(ShareButtonHandler)shareButtonHandler{
    [self.activePlatforms addObject:@{@"title":title,@"icon":icon?:[NSNull null],@"handler":[shareButtonHandler copy]}];
    [self reloadData:NO];
}

- (void)show
{
    UIWindow *window      = [UIApplication sharedApplication].keyWindow;
    _backgroundView       = [[UIView alloc] initWithFrame:window.bounds];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor        = [UIColor blackColor];
    _backgroundView.userInteractionEnabled = YES;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [window addSubview:_backgroundView];
    
    CGRect rect = self.frame;
    rect.origin.y =CGRectGetMaxY(window.bounds);
    self.frame= rect;
    
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.5;
        CGRect rect = self.frame;
        rect.origin.y =CGRectGetMaxY(window.bounds) - CGRectGetHeight(rect);
        self.frame= rect;
        
    }];
}
- (void)dismiss{
    [self hide];
}
- (void)hide
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect newRect   = self.frame;
    newRect.origin.y = window.bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
        self.frame = newRect;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        [self removeFromSuperview];
    }];
}
@end
