//
//  Level.m
//  TheRunningBall
//
//  Created by OurEDA-25 on 13-7-16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

static Level* level = nil;
@implementation Level
@synthesize le;
-(id)init
{
    if (self = [super init]) {
        le = 1;
    }
    return self;
}
-(void)levedown
{
    le = 1;
}
-(void)leveup
{
    le++;
}
+(Level*)shardeLevel
{
    if (level ==nil) {
        level = [[Level alloc]init];
        
    }
    return  level;
}
-(void)dealloc
{
  //  [super dealloc];
}
@end
