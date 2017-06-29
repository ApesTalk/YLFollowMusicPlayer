//
//  YLNavigationController.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLNavigationController.h"
#import "UINavigationBar+Awesome.h"
#import "YLConst.h"

@interface YLNavigationController ()

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customBarStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customBarStyle
{
    // 导航条颜色
    self.navigationBar.barTintColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3];
    // 修改导航条返回文字和箭头颜色
    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
    // 导航条标题属性
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    //    self.interactivePopGestureRecognizer.enabled = YES;
    //去掉半透明效果【虽然可以设置translucent为NO,但是整体页面改动会很大。】
    [self.navigationBar lt_setBackgroundColor:kNavBgColor];
    //去掉导航的黑色边框线条效果 【设置了shodowImage就必须设置backgroundImage，否则无效】
    [self.navigationBar setShadowImage:[UIImage new]];
    
}

@end
