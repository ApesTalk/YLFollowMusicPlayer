//
//  YLPlayerViewController.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/4.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLPlayerViewController.h"
#import "YLPlayTitleView.h"
#import "YLMusic.h"
#import "UIImageView+WebCache.h"
#import "UIView+YLAnimation.h"
#import "YLSlider.h"
#import "DOUAudioStreamer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSInteger, YLPlayMode) {
    YLPlayModeOrder,//列表循环
    YLPlayModeRandom,//随机
    YLPlayModeLoop,//单曲循环
};

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface YLPlayerViewController ()
{
    CGPoint pauseNeedleCenter;
    CGPoint playNeedleCenter;
}
@property(nonatomic,assign)YLPlayMode playMode;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)YLMusic *currentMusic;
@property(nonatomic,strong)YLPlayTitleView *titleView;
@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIImageView *discView;
@property(nonatomic,strong)UIImageView *posterView;
@property(nonatomic,strong)UIImageView *needle;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UILabel *minLabel;
@property(nonatomic,strong)YLSlider *slider;
@property(nonatomic,strong)UILabel *maxLabel;
@property(nonatomic,strong)UIButton *modeBtn;
@property(nonatomic,strong)UIButton *previousBtn;
@property(nonatomic,strong)UIButton *playBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)DOUAudioStreamer *streamer;
@end

@implementation YLPlayerViewController
- (instancetype)init
{
    if(self = [super init]){
        _currentIndex = -1;
        
        _titleView = [[YLPlayTitleView alloc]initWithFrame:CGRectMake(0, 0, kFrameWidth - 120, kNavigationBarHeight - kStatusBarHeight)];
        _titleView.tintColor = [UIColor blackColor];
        _bgView = [[UIImageView alloc]init];
        _discView = [[UIImageView alloc]init];
        _posterView = [[UIImageView alloc]init];
        _needle = [[UIImageView alloc]init];
        _needle.frame = CGRectMake((kFrameWidth - 80) / 2.0 + 20, kNavigationBarHeight - 26, 80, 140);
        _needle.image = [UIImage imageNamed:@"yl_play_needle_play"];
        [_needle yl_rotateWithAngle:-M_PI / 8 anchorPoint:CGPointMake(0, 0)];
        //校验center
        _needle.center = CGPointMake(_needle.center.x - 8, _needle.center.y + 10);
        pauseNeedleCenter = _needle.center;
        
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _minLabel = [[UILabel alloc]init];
        _slider = [[YLSlider alloc]init];
        _maxLabel = [[UILabel alloc]init];
        
        _modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return self;
}

+ (instancetype)sharePalyer
{
    static YLPlayerViewController *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[YLPlayerViewController alloc]init];
    });
    return player;
}

- (NSTimer *)timer
{
    if(!_timer){
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = _titleView;
    
    [self setSubViews];
    
//    [_needle lm_rotateWithAngle:-M_PI / 8 anchorPoint:CGPointMake(0, 0)];
//    //校验center
//    _needle.center = CGPointMake(_needle.center.x - 8, _needle.center.y + 10);
//    pauseNeedleCenter = _needle.center;
    
    
    [self remoteControlAfterIOS71];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(audioInterrupt:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViews
{
    _bgView.contentMode = UIViewContentModeScaleAspectFill;
    _bgView.frame = CGRectMake(0, 0, kFrameWidth, kFrameHeight);
    [self.view addSubview:_bgView];
    
    UIImageView *discBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yl_play_disc_radio_bg"]];
    discBg.frame = CGRectMake(0, 0, 220, 220);
    discBg.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [_bgView addSubview:discBg];
    
    _discView.image = [UIImage imageNamed:@"yl_play_disc"];
    _discView.frame = discBg.bounds;
    [discBg addSubview:_discView];
    
    _posterView.frame = CGRectInset(_discView.bounds, 41, 41);
    _posterView.layer.cornerRadius = _posterView.bounds.size.height / 2.0;
    _posterView.layer.masksToBounds = YES;
    _posterView.backgroundColor = [UIColor redColor];
    [_discView addSubview:_posterView];
    
    //发散灯光效果
//    _needle.frame = CGRectMake((kFrameWidth - 80) / 2.0 + 20, kNavigationBarHeight - 26, 80, 140);
//    _needle.image = [UIImage imageNamed:@"yl_play_needle_play"];
    [self.view addSubview:_needle];
    

    CGFloat x = (kFrameWidth - 60) * 0.5;
    CGFloat y = kFrameHeight - 80;
    _playBtn.frame = CGRectMake(x, y, 60, 60);
    [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_pause"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBtn];
    
    x += 30 + 30;
    _nextBtn.frame = CGRectMake(x, y, 60, 60);
    [_nextBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_next"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    x = (kFrameWidth - 60) * 0.5 - 30 - 30;
    _previousBtn.frame = CGRectMake(x, y, 60, 60);
    [_previousBtn setImage:[UIImage imageNamed:@"yl_play_btn_prev"] forState:UIControlStateNormal];
    [_previousBtn addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_previousBtn];
    
    x = 10;
    _modeBtn.frame = CGRectMake(x, y, 60, 60);
    [_modeBtn setImage:[UIImage imageNamed:@"yl_playlist_icn_order"] forState:UIControlStateNormal];
    [_modeBtn addTarget:self action:@selector(changeMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modeBtn];
    
    x = 30;
    y -= 70;
    _likeBtn.frame = CGRectMake(x, y, 35, 35);
    [_likeBtn setImage:[UIImage imageNamed:@"yl_play_icn_love_prs"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(favorite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeBtn];
    
    _commentBtn.frame = CGRectMake(90, y, 35, 35);
    [_commentBtn setImage:[UIImage imageNamed:@"yl_play_icn_cmt_prs"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentBtn];
    
    x = 10;
    y += 35 + 10;
    _minLabel.frame = CGRectMake(x, y, 40, 20);
    _minLabel.font = [UIFont systemFontOfSize:10];
    _minLabel.textColor = [UIColor whiteColor];
    _minLabel.textAlignment = NSTextAlignmentCenter;
    _minLabel.text = @"00:00";
    [self.view addSubview:_minLabel];
    
    x += 40 + 5;
    _slider.frame = CGRectMake(x, y, kFrameWidth - 110, 20);
    _slider.minimumTrackTintColor = [UIColor redColor];
    _slider.maximumTrackTintColor = [UIColor lightGrayColor];
    _slider.minimumValue = 0.0;
    _slider.maximumValue = 1.0;
    [_slider setThumbImage:[UIImage imageNamed:@"yl_playbar_btn_prs"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderTouchUp:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    [self.view addSubview:_slider];
    
    _maxLabel.frame = CGRectMake(kFrameWidth - 50, y, 40, 20);
    _maxLabel.font = [UIFont systemFontOfSize:10];
    _maxLabel.textColor = [UIColor whiteColor];
    _maxLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_maxLabel];
}

- (void)setCurrentMusic:(YLMusic *)currentMusic
{
    if([currentMusic isKindOfClass:[YLMusic class]]){
        _currentMusic = currentMusic;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"musicbg1" ofType:@"jpeg"];
        UIImage *holder = [UIImage imageWithContentsOfFile:path];
        [_bgView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.poster] placeholderImage:holder];
        [_titleView refreshWithMusic:_currentMusic];
        [_posterView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.poster] placeholderImage:holder];
        NSString *likeImageName = _currentMusic.isFavorited ? @"yl_play_icn_loved_prs" : @"yl_play_icn_love_prs";
        [_likeBtn setImage:[UIImage imageNamed:likeImageName] forState:UIControlStateNormal];
        
        //切换锁屏
        [self updateLockedScreenMusic];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if(_currentIndex  != currentIndex && currentIndex >= 0){
        _currentIndex = currentIndex;
        [self resetStreamer];
    }
}

- (void)loadMusics:(NSArray *)musics
{
    _musicList = musics;
    if(_musicList.count > 0){
        self.currentIndex = 0;
    }
}

- (void)loadMusics:(NSArray *)musics withIndex:(NSInteger)index
{
    _musicList = musics;
    if(_musicList.count > index){
        self.currentIndex = index;
    }
}

- (BOOL)isPlaying
{
    if(!_streamer) return NO;
    return _streamer.status == DOUAudioStreamerPlaying;
}

- (void)sliderValueChanged:(YLSlider *)slider
{
    [_streamer pause];
    _streamer.currentTime = slider.value * _streamer.duration;
}

- (void)sliderTouchUp:(YLSlider *)slider
{
    NSLog(@"值改变结束：%.2f",slider.value);
    [_streamer play];
}

- (void)cancelStreamer
{
    if (_streamer != nil) {
        [_streamer pause];
        [_streamer removeObserver:self forKeyPath:@"status"];
        [_streamer removeObserver:self forKeyPath:@"duration"];
        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        _streamer = nil;
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)resetStreamer
{
    [self cancelStreamer];
    
    if (_musicList.count == 0 || _currentIndex < 0 || _currentIndex >= _musicList.count){
//        [_miscLabel setText:@"(No tracks available)"];
    }else{
        YLMusic *music = [_musicList objectAtIndex:_currentIndex];
        self.currentMusic = music;
        
        _streamer = [DOUAudioStreamer streamerWithAudioFile:music];
        [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
        [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
        [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
        
        [_streamer play];
        [self.timer fire];
        [self updateBufferingStatus];
        [self setupHintForStreamer];
    }
}

- (void)setupHintForStreamer
{
    NSUInteger nextIndex = _currentIndex + 1;
    if (nextIndex >= _musicList.count) {
        nextIndex = 0;
    }
    
    if(_musicList.count > nextIndex){
        [DOUAudioStreamer setHintWithAudioFile:[_musicList objectAtIndex:nextIndex]];
    }
}

- (void)timerAction
{
    NSLog(@"%f  %f",_streamer.currentTime,_streamer.duration);
    NSInteger fromMinutes = _streamer.currentTime / 60;
    NSInteger fromSeconds = _streamer.currentTime - fromMinutes * 60;
    _minLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)fromMinutes,(long)fromSeconds];
    
    NSInteger toMinutes = _streamer.duration / 60;
    NSInteger toSeconds = _streamer.duration - toMinutes * 60;
    _maxLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)toMinutes,(long)toSeconds];
    
    if ([_streamer duration] == 0.0) {
        [_slider setValue:0.0f animated:NO];
    }else{
        [_slider setValue:[_streamer currentTime] / [_streamer duration] animated:YES];
    }
    
    [self updateLockedScreenMusic];
}

- (void)updateStatus
{
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            NSLog(@"playing");
            [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_pause"] forState:UIControlStateNormal];
            [_discView yl_start360DegreeRotateWithDuration:50];
            [self needleRotateClockwise:NO];
            break;
            
        case DOUAudioStreamerPaused:
            NSLog(@"paused");
            [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_play"] forState:UIControlStateNormal];
            [_discView yl_stop360DegreeRotate];
            [self needleRotateClockwise:YES];
            break;
            
        case DOUAudioStreamerIdle:
            NSLog(@"idle");
            [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_play"] forState:UIControlStateNormal];
            [_discView yl_stop360DegreeRotate];
            [self needleRotateClockwise:YES];
            break;
            
        case DOUAudioStreamerFinished:
            NSLog(@"finished");
            if(_playMode == YLPlayModeLoop){
                [self resetStreamer];
            }else{
                [self next];
            }
            break;
            
        case DOUAudioStreamerBuffering:
            NSLog(@"buffering");
            break;
            
        case DOUAudioStreamerError:
            NSLog(@"error");
            break;
    }
}

- (void)updateBufferingStatus
{
//    [_minLabel setText:[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[_streamer receivedLength] / 1024 / 1024, (double)[_streamer expectedLength] / 1024 / 1024, [_streamer bufferingRatio] * 100.0, (double)[_streamer downloadSpeed] / 1024 / 1024]];
//    
//    if ([_streamer bufferingRatio] >= 1.0) {
//        NSLog(@"sha256: %@", [_streamer sha256]);
//    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        [self performSelector:@selector(timerAction)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)play
{
    if ([_streamer status] == DOUAudioStreamerPaused ||
        [_streamer status] == DOUAudioStreamerIdle) {
        [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_pause"] forState:UIControlStateNormal];
        [self needleRotateClockwise:NO];
        [_streamer play];
    }
    else {
        [_playBtn setImage:[UIImage imageNamed:@"yl_runfm_btn_play"] forState:UIControlStateNormal];
        [self needleRotateClockwise:YES];
        [_streamer pause];
    }
}

- (void)previous
{
    if(_playMode == YLPlayModeRandom){
        NSInteger randomIndex = arc4random() % _musicList.count;
        _currentIndex = randomIndex;
    }else{
        if(--_currentIndex <= 0) {
            _currentIndex = 0;
        }
        [self resetStreamer];
    }
}

- (void)next
{
    if(_playMode == YLPlayModeRandom){
        NSInteger randomIndex = arc4random() % _musicList.count;
        _currentIndex = randomIndex;
    }else{
        if(++_currentIndex >= [_musicList count]) {
            _currentIndex = 0;
        }
    }
    [self resetStreamer];
}

-(void)changeMode
{
    if(_playMode == YLPlayModeOrder){
        [_modeBtn setImage:[UIImage imageNamed:@"yl_playlist_icn_shuffle"] forState:UIControlStateNormal];
        _playMode = YLPlayModeRandom;
    }else if (_playMode == YLPlayModeRandom){
        [_modeBtn setImage:[UIImage imageNamed:@"yl_playlist_icn_one"] forState:UIControlStateNormal];
        _playMode = YLPlayModeLoop;
    }else{
        [_modeBtn setImage:[UIImage imageNamed:@"yl_playlist_icn_loop"] forState:UIControlStateNormal];
        _playMode = YLPlayModeOrder;
    }
}

- (void)favorite
{
    if(_currentMusic){
        UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
        [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
            [_likeBtn.layer setValue:@(0.80) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
                [_likeBtn.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
                    [_likeBtn.layer setValue:@(1) forKeyPath:@"transform.scale"];
                } completion:NULL];
            }];
        }];
        if(_currentMusic.isFavorited){
            [_likeBtn setImage:[UIImage imageNamed:@"yl_play_icn_love_prs"] forState:UIControlStateNormal];
        }else{
            [_likeBtn setImage:[UIImage imageNamed:@"yl_play_icn_loved_prs"] forState:UIControlStateNormal];
        }
        _currentMusic.favorite = !_currentMusic.isFavorited;
    }
}

- (void)comment
{
    
}

- (void)needleRotateClockwise:(BOOL)clockwise
{
    if(!clockwise){
        [_needle yl_rotateWithAngle:0 anchorPoint:CGPointMake(0, 0)];
        //校验center
        if(playNeedleCenter.x == 0 && playNeedleCenter.y == 0){
            playNeedleCenter = CGPointMake(_needle.center.x + 5, _needle.center.y - 10);
        }
        _needle.center = playNeedleCenter;
    }else{
        [_needle yl_rotateWithAngle:-M_PI / 8 anchorPoint:CGPointMake(0, 0)];
        //校验center
        if(pauseNeedleCenter.x == 0 && pauseNeedleCenter.y == 0){
            pauseNeedleCenter = CGPointMake(_needle.center.x - 8, _needle.center.y + 10);
        }
        _needle.center = pauseNeedleCenter;
    }
}

- (void)audioInterrupt:(NSNotification *)notification
{
    
}

#pragma mark ----锁屏时候的设置，效果需要在真机上才可以看到
- (void)updateLockedScreenMusic
{
    // 播放信息中心
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
    // 初始化播放信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    // 专辑名称
    info[MPMediaItemPropertyAlbumTitle] = self.currentMusic.name;
    // 歌手
    info[MPMediaItemPropertyArtist] = self.currentMusic.singer;
    // 歌曲名称
    info[MPMediaItemPropertyTitle] = self.currentMusic.name;
    // 设置图片
    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:_bgView.image];
    // 设置持续时间（歌曲的总时间）
    info[MPMediaItemPropertyPlaybackDuration] = [NSNumber numberWithDouble:_streamer.duration];
    // 设置当前播放进度
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = [NSNumber numberWithDouble:_streamer.currentTime];
    
    // 切换播放信息
    center.nowPlayingInfo = info;
    
    // 远程控制事件 Remote Control Event
    // 加速计事件 Motion Event
    // 触摸事件 Touch Event
    
    // 开始监听远程控制事件
    // 成为第一响应者（必备条件）
    [self becomeFirstResponder];
    // 开始监控
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

#pragma mark---iOS 7.1之前如何处理RemoteComtrol
#pragma mark - 远程控制事件监听
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//
//- (void)remoteControlReceivedWithEvent:(UIEvent *)event
//{
//    //    event.type; // 事件类型
//    //    event.subtype; // 事件的子类型
//    //    UIEventSubtypeRemoteControlPlay                 = 100,
//    //    UIEventSubtypeRemoteControlPause                = 101,
//    //    UIEventSubtypeRemoteControlStop                 = 102,
//    //    UIEventSubtypeRemoteControlTogglePlayPause      = 103,
//    //    UIEventSubtypeRemoteControlNextTrack            = 104,
//    //    UIEventSubtypeRemoteControlPreviousTrack        = 105,
//    //    UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
//    //    UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
//    //    UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
//    //    UIEventSubtypeRemoteControlEndSeekingForward    = 109,
//    switch (event.subtype) {
//        case UIEventSubtypeRemoteControlPlay:
//        case UIEventSubtypeRemoteControlPause:
//            [self play];
//            break;
//            
//        case UIEventSubtypeRemoteControlNextTrack:
//            [self next];
//            break;
//            
//        case UIEventSubtypeRemoteControlPreviousTrack:
//            [self previous];
//            
//        default:
//            break;
//    }
//}


#pragma mark---iOS 7.1之后如何处理RemoteComtrol
- (void)remoteControlAfterIOS71
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //返回值根据需要返回，一般情况下返回MPRemoteCommandHandlerStatusSuccess即可
    [[MPRemoteCommandCenter sharedCommandCenter].playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // play
        [self play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [[MPRemoteCommandCenter sharedCommandCenter].pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // pause
        [self play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [[MPRemoteCommandCenter sharedCommandCenter].togglePlayPauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        // play or pause
        [self play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [[MPRemoteCommandCenter sharedCommandCenter].previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self previous];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [[MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self next];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}
@end
