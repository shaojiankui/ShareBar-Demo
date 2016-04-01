//
//  ShareBar.h
//  ShareBar
//
//  Created by Jakey on 16/3/30.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>


//位移枚举定义
typedef NS_ENUM(NSInteger, ShareBarPlatform)
{
    ShareBarPlatformWeixin       = 1<<0,                 //1
    ShareBarPlatformPengyouquan  = 1 << 1,       //2
    ShareBarPlatformWeibo        = 1 << 2,               //4
    ShareBarPlatformQQ           = 1 << 3,               //8
    ShareBarPlatformQQZone       = 1 << 4                //16
};
typedef void(^SelectPlatformHandler) (ShareBarPlatform platformType);
typedef void(^ShareButtonHandler) (id item);

IB_DESIGNABLE
@interface ShareBar : UIView
/**
 *  @author Jakey
 *
 *  平台多于5的的时候需要手动指定itemWidth,否则默认60
 */
@property (nonatomic) IBInspectable CGFloat itemWidth;
/**
 *  @author Jakey
 *
 *  初始化要分析的平台
 *
 *  @param platform              平台枚举 支持多个
 *  @param selectPlatformHandler 回调
 */
-(void)activePlatforms:(ShareBarPlatform)platform handler:(SelectPlatformHandler)selectPlatformHandler;
/**
 *  @author Jakey
 *
 *  手动添加一个平台按钮
 *
 *  @param title              平台标题
 *  @param icon               图标
 *  @param shareButtonHandler 回调
 */
-(void)addPlatform:(NSString*)title icon:(UIImage*)icon handler:(ShareButtonHandler)shareButtonHandler;
/**
 *  @author Jakey
 *
 *  点赞按钮回调
 *
 *  @param shareButtonHandler <#shareButtonHandler description#>
 */
-(void)thumbButtonHandler:(ShareButtonHandler)shareButtonHandler;

@end
