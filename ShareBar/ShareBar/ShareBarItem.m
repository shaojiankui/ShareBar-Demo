//
//  ShareBarItem.m
//  ShareBar
//
//  Created by Jakey on 16/3/30.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//
#define RImageHeightPercent 0.65

#import "ShareBarItem.h"

@implementation ShareBarItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)layoutSubviews {
//    [super layoutSubviews];
//    
//    // Center image
//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width/2;
//    center.y = self.imageView.frame.size.height/2+5;
//    self.imageView.center = center;
//    
//    //Center text
//    CGRect newFrame = [self titleLabel].frame;
//    newFrame.origin.x = 0;
//    newFrame.origin.y = self.imageView.frame.size.height + 10;
//    newFrame.size.width = self.frame.size.width;
//    
//    self.titleLabel.frame = newFrame;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//}
//初始化imageview
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (contentRect.size.width-contentRect.size.height* RImageHeightPercent)/2;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.height* RImageHeightPercent;
    CGFloat imageH = contentRect.size.height* RImageHeightPercent;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//初始化title
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = contentRect.size.height* RImageHeightPercent;
    CGFloat width =contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - RImageHeightPercent);
    
    return CGRectMake(x, y, width, height);
}
@end
