//
//  YLBaseObject.h
//  YLFollowMusicPlayer
//
//  Created by lumin on 2017/3/2.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "YLBaseObject.h"

@implementation YLBaseObject
- (BOOL)isEqual:(id)object
{
    if(object && [object isKindOfClass:[self class]]){
        return self.objId == ((YLBaseObject *)object).objId;
    }else{
        return NO;
    }
}
@end
