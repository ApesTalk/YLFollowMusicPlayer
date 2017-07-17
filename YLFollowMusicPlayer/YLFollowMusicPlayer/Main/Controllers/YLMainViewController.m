//
//  YLMainViewController.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLMainViewController.h"
#import "YLPlayerViewController.h"
#import "YLMusic.h"
#import "YLMusic+Provider.h"
#import "YLMainMusicListCell.h"
#import "YLUIFactory.h"
#import "NSArray+YLBoundsCheck.h"
#import "YLNavigationController.h"
#import "NAKPlaybackIndicatorView.h"

static NSString *cellIdentifier = @"YLMainMusicListCell";

@interface YLMainViewController ()
{
    NSArray *musicList;
}
@property(nonatomic,strong)NAKPlaybackIndicatorView *indicator;
@property(nonatomic,strong)UITableView *table;
@end

@implementation YLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Follow";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavItems];
    
    musicList = [YLMusic yl_remoteTracks];
//    musicList = [NSMutableArray array];
//    for(NSInteger i = 0; i < 10; i++){
//        YLMusic *music = [[YLMusic alloc]init];
//        if(i % 2 == 0){
//            music.objId = 10001;
//            music.name = @"让牛逼的";
//            music.singer = @"耳光乐队";
//            music.poster = @"http://sp.9sky.com/disc/cover/1005097/20170209134713564.jpg";
//            music.audioFileURL = [NSURL URLWithString:@"http://sp.9sky.com/convert/song/music/1005097/20170209141353049.mp3"];
//            music.duration = 4.50;
//        }else{
//            music.objId = 10000;
//            music.name = @"小眼睛";
//            music.singer = @"蔡淳佳";
//            music.poster = @"http://sp.9sky.com/disc/cover/141/20160926180748362.jpg";
//            music.audioFileURL = [NSURL URLWithString:@"http://sp.9sky.com/convert/song/music/141/20160926181108909.mp3"];
//            music.duration = 3.50;
//        }
//        [musicList addObject:music];
//    }
    _table = [YLUIFactory tableWithFrame:self.view.frame style:UITableViewStylePlain cellClass:@[cellIdentifier] delegate:self dataSource:self];
    _table.tableFooterView = [UIView new];
    [self.view addSubview:_table];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    YLPlayerViewController *player = [YLPlayerViewController sharePalyer];
    _indicator.state = [player isPlaying] ? NAKPlaybackIndicatorViewStatePlaying : NAKPlaybackIndicatorViewStateStopped;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavItems
{
    _indicator = [[NAKPlaybackIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _indicator.hidesWhenStopped = NO;
    _indicator.tintColor = [UIColor redColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playMusic)];
    [_indicator addGestureRecognizer:tapGesture];
    UIBarButtonItem *playItem = [[UIBarButtonItem alloc]initWithCustomView:_indicator];
    self.navigationItem.rightBarButtonItem = playItem;
}

#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return musicList.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 10, 0, 0);
    //http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:edge];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:edge];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLMainMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLMusic *music = [musicList yl_objectAtIndex:indexPath.row];
    [cell refreshWithObject:music];
    return cell;
}

#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    YLMusic *music = [musicList yl_objectAtIndex:row];
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier configuration:^(id cell) {
        [cell refreshWithObject:music];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLPlayerViewController *player = [YLPlayerViewController sharePalyer];
    [self.navigationController pushViewController:player animated:YES];
    [player loadMusics:musicList withIndex:indexPath.row];
}


#pragma mark---other methods

- (void)playMusic
{
    YLPlayerViewController *player = [YLPlayerViewController sharePalyer];
    [self.navigationController pushViewController:player animated:YES];
    [player loadMusics:musicList];
}


@end
