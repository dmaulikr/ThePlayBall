//
//  StarSceneTwo.m
//  TheRunningBall
//
//  Created by OurEDA-25 on 13-7-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "StarSceneTwo.h"
#import "rankscene.h"

@implementation StarSceneTwo
+(StarSceneTwo*)scene
{
    return [[self alloc] init];
}

-(id)init
{
    if (self = [super init])
    {
    //CGSize winsize = [[CCDirector sharedDirector]winSize];
     //   CGSize wins =   [[CCDirector sharedDirector]viewSize];
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:255/255.f green:58/255.f blue:74/255.f alpha:1.0f]];
        [self addChild:background];
        CGSize win = [[UIScreen mainScreen]bounds].size;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
            winsize= CGSizeMake(win.height, win.width);
        }
        else
        {
            winsize= win;

        }
        
        // = [[UIScreen mainScreen] bounds].size;
        //FMSimpleButton* star_button = [FMSimpleButton createSimpleButton:@"stargame.jpg" downPath:nil target:self Function:@selector(stargame)];
        //start but
        CCSprite* spr = [CCSprite spriteWithImageNamed:@"不要脸.png"];
        spr.position = ccp(winsize.height/3, winsize.width/2);
        [self addChild:spr];
        CCButton *star_button = [CCButton buttonWithTitle:@"[ 开始游戏 ]" fontName:@"Verdana-Bold" fontSize:25.0f];
        NSLog(@"height %f  width %f -----height %f  width %f",winsize.height,winsize.width,win.height,win.width);
        star_button.position = ccp(winsize.height*2/3, winsize.width*3/4+10);
        star_button.color = [CCColor blackColor];
        [star_button setTarget:self selector:@selector(stargame)];
        [self addChild:star_button];
        //setting but
        CCButton *rank_button = [CCButton buttonWithTitle:@"[ 排行榜 ]" fontName:@"Verdana-Bold" fontSize:25.0f];
       rank_button.position = ccp(winsize.height*2/3, winsize.width/2+10);
        rank_button.color = [CCColor blackColor];
        [rank_button setTarget:self selector:@selector(tran_To_rankgameScene)];
        [self addChild:rank_button];
        //排行榜按钮
        CCButton *set_button= [CCButton buttonWithTitle:@"[ 设置 ]" fontName:@"Verdana-Bold" fontSize:25.0f];
        set_button.color = [CCColor blackColor];
        [set_button setTarget:self selector:@selector(tran_To_setScene)];
        set_button.position = ccp(winsize.height*2/3, winsize.width/4+10);
        [self addChild:set_button];
    }
    return self;
}
-(void)tran_To_setScene
{
    [[CCDirector sharedDirector] replaceScene:[SetView scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];

}
-(void)tran_To_rankgameScene
{
    [[CCDirector sharedDirector] replaceScene:[rankscene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];

}
-(void)stargame
{
    [[CCDirector sharedDirector] replaceScene:[GameSceneTwo scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];

}
-(void)dealloc
{
    //[super dealloc];
}
@end
