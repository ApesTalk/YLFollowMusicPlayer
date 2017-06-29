//
//  YLConst.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#ifndef YLConst_h
#define YLConst_h

// 调试开关
#ifdef DEBUG
#define DLog(s, ...) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog(s, ...)
#endif

// 系统版本
#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


// 屏幕尺寸
#define kFrameWidth [UIScreen mainScreen].bounds.size.width
#define kFrameHeight [UIScreen mainScreen].bounds.size.height

// 状态条高度
#define kStatusBarHeight 20

// 导航栏高度
#define kNavigationBarHeight 64
// 底部工具栏高度
#define kTabBarHeight 49

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;             //相当于weakSelf = self
#define kStrongSelf(type) __strong typeof(type) type = weak##type;          //相当于self = weakSelf 此处self是block中的临时变量替代了全局变量self

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 图片
#define ImageOfFile(imageName,typeName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:typeName]]
#define ImageByName(value) [UIImage imageNamed:NSLocalizedString((value), nil)]

// 主题颜色
#define kThemeColor [UIColor blackColor]
#define kNavBgColor [UIColor whiteColor]
// 背景颜色（赭石）
#define kBackgroundColor RGBCOLOR(238, 237, 238)
// 线条颜色
#define kLineColor HEXCOLOR(0xe3e3e3)
// 字体颜色
#define kContentColor HEXCOLOR(0x999999)
#define kTitleColor HEXCOLOR(0x333333)
#define kCommonColor HEXCOLOR(0x666666)
#define kYellowColor HEXCOLOR(0xffc342)
#define kBrownColor  RGBCOLOR(212, 143, 97)

#define kYLPriorityNearRequired   999

#endif /* YLConst_h */
