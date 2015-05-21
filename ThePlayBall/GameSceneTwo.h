//
//  GameSceneTwo.h
//  TheRunningBall
//
//  Created by OurEDA-01 on 13-7-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
//#import "FMSimpleButton.h"
#import "StarSceneTwo.h"
#import "Level.h"
@interface GameSceneTwo : CCScene <AVAudioPlayerDelegate>{
   CGSize winsize;
    CGSize screenSize;
    CGPoint playerVelocity;
    float totaltime;
    int f_tag;
    NSInteger count1;
    CCSprite* over_background;
   // AVAudioPlayer *myBackMusic;
}
+(CCScene *) scene;
@property(nonatomic,retain)CMMotionManager* acceleration;
@property(nonatomic,retain)CCSprite* ball;
@property(nonatomic,retain)CCSprite* aim;
@property(nonatomic,retain)CCLabelTTF* scorelable;
@property(nonatomic,retain)NSMutableArray *role;
@end
