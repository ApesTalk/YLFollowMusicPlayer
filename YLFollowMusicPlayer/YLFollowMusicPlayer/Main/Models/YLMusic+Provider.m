//
//  YLMusic+Provider.m
//  YLFollowMusicPlayer
//
//  Created by TK-001289 on 2017/6/23.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLMusic+Provider.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation YLMusic (Provider)
+ (void)load
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self yl_remoteTracks];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self yl_musicLibraryTracks];
    });
}

+ (NSArray *)yl_remoteTracks
{
    static NSArray *musics = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://douban.fm/j/mine/playlist?type=n&channel=1004693&from=mainsite"]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:NULL
                                                         error:NULL];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        
        NSMutableArray *allMusics = [NSMutableArray array];
        for (NSDictionary *song in [dict objectForKey:@"song"]) {
            YLMusic *music = [[YLMusic alloc] init];
            music.singer = [song objectForKey:@"artist"];
            music.name = [song objectForKey:@"title"];
            music.audioFileURL = [NSURL URLWithString:[song objectForKey:@"url"]];
            [allMusics addObject:music];
        }
        
        //测试1
        YLMusic *music =  [[YLMusic alloc]init];
        music.name = @"Rain";
        music.singer = @"Seasons for Change";
        music.audioFileURL = [NSURL URLWithString:@"http://sp.9sky.com/convert/song/music/428/20161023201151815.mp3"];
        [allMusics addObject:music];
        
        music =  [[YLMusic alloc]init];
        music.name = @"牙尖上的爱";
        music.singer = @"蔡龙波";
        music.audioFileURL = [NSURL URLWithString:@"http://sp.9sky.com/convert/song/music/1005979/20170303153447336.mp3"];
        [allMusics addObject:music];
        
        musics = [allMusics copy];
    });
    
    return musics;
}

+ (NSArray *)yl_musicLibraryTracks
{
    static NSArray *musics = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *allMusics = [NSMutableArray array];
        for (MPMediaItem *item in [[MPMediaQuery songsQuery] items]) {
            if ([[item valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
                continue;
            }
            
            YLMusic *music = [[YLMusic alloc] init];
            music.singer = [item valueForProperty:MPMediaItemPropertyArtist];
            music.name = [item valueForProperty:MPMediaItemPropertyTitle];
            music.audioFileURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
            [allMusics addObject:music];
        }
        
        for (NSUInteger i = 0; i < [allMusics count]; ++i) {
            NSUInteger j = arc4random_uniform((u_int32_t)[allMusics count]);
            [allMusics exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
        
        musics = [allMusics copy];
    });
    
    return musics;
}
@end
