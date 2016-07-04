//
//  ShareBar.h
//  ShareBar
//
//  Created by Jakey on 16/6/12.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectPlatformHandler) (id data);
typedef void(^ShareButtonHandler) (id item);

@interface ShareBar : UIView
@property (nonatomic,assign)  CGFloat itemWidth;
+(ShareBar*)bar;

- (instancetype)init __attribute__((unavailable("Forbidden use init!")));

- (void)addPlatform:(NSString*)title icon:(UIImage*)icon handler:(SelectPlatformHandler)shareButtonHandler;
- (void)show;
- (void)dismiss;
@end
