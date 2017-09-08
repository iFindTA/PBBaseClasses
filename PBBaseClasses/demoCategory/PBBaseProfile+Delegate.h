//
//  PBBaseProfile+Delegate.h
//  PBBaseClasses
//
//  Created by nanhujiaju on 2017/9/8.
//  Copyright © 2017年 nanhujiaju. All rights reserved.
//

#import "PBBaseProfile.h"
#import "AppDelegate.h"

@interface PBBaseProfile (Delegate)

#pragma mark -- Root TabBar Actions

/**
 *  @brief hidden/show root tabbar
 *
 *  @param hidden   wether hidden
 *  @param animated wether animated
 *  @Attentions:    this function need AppDelegate Class support '- (FLKBaseTabBarController *)rootTabBar' method
 *
 */
- (void)hideTabBar:(BOOL)hidden animated:(BOOL)animated;

/**
 *  @brief switch root controller
 *
 *  @param ismain wether main
 */
- (void)switchRoot2MainComponent:(BOOL)ismain;

/**
 *  @brief update tabBar's item badge value
 *
 *  @param value the value
 *  @param idx   the item's index
 */
- (void)setBadgeValue:(NSInteger)value atIndex:(NSUInteger)idx;
- (void)clearBadgeAtIndex:(NSUInteger)idx;

@end
