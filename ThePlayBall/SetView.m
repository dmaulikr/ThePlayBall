//
//  SetView.m
//  TheRunningBall
//
//  Created by OurEDA on 14-10-9.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "SetView.h"
#import "userDefault.h"

@implementation SetView
@synthesize accleBut;
@synthesize musicBut;
@synthesize handBut;

+(SetView *) scene
{
	return [[self alloc]init];
}

-(id)init
{
    if (self = [super init]) {
        [self initView];
        
    }
    return self;
}
-(void)initView
{
    
    
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }

    CCNodeColor* backgd = [[CCNodeColor alloc]initWithColor:[CCColor colorWithRed:255/255.f green:58/255.f blue:74/255.f alpha:1.0f]];
    [self addChild:backgd];
    CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"back.png"];
    CCButton * back_button = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
    [back_button setTarget:self selector:@selector(tran_to_back)];
    back_button.position = ccp(50,winsize.width-60 );
    [self addChild:back_button];
    
    CCLabelTTF* lable1 = [CCLabelTTF labelWithString:@"重力感应" fontName:@"Verdana-Bold" fontSize:20];
    lable1.position = ccp(winsize.height/2-60, winsize.width*3/4);
    lable1.color = [CCColor blackColor];
    [self addChild:lable1];
    //[lable1 setColor:ccc3(0, 0, 0)];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:ifTheGameUseAccle]) {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"重力开.png"];
        accleBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        [accleBut setTarget:self selector:@selector(accleButclick:)];
        CCSpriteFrame* spr1 = [CCSpriteFrame frameWithImageNamed:@"手动关.png"];
        handBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr1];
        [handBut setTarget:self selector:@selector(handButclick:)];
      accleBut.position = ccp(winsize.height/2+10, winsize.width*3/4);
       [self addChild:accleBut];
        handBut.position = ccp(winsize.height/2+10, winsize.width/2);
        [self addChild:handBut];
    }
    else
    {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"重力关.png"];
        accleBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        [accleBut setTarget:self selector:@selector(accleButclick:)];
        CCSpriteFrame* spr1 = [CCSpriteFrame frameWithImageNamed:@"手动开.png"];
        handBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr1];
        [handBut setTarget:self selector:@selector(handButclick:)];
        accleBut.position = ccp(winsize.height/2+10, winsize.width*3/4);
        [self addChild:accleBut];
        handBut.position = ccp(winsize.height/2+10, winsize.width/2);
        [self addChild:handBut];
        
    }
    
    
    CCLabelTTF* lable2 = [CCLabelTTF labelWithString:@"手动操作" fontName:@"Verdana-Bold" fontSize:20];
    lable2.position = ccp(winsize.height/2-60, winsize.width/2);
    [self addChild:lable2];
    //[lable2 setColor:ccc3(0, 0, 0)];
    
    CCLabelTTF* lable3 = [CCLabelTTF labelWithString:@"开启音乐" fontName:@"Verdana-Bold" fontSize:20];
    lable3.position = ccp(winsize.height/2-60, winsize.width/4);
    [self addChild:lable3];
    lable2.color = [CCColor blackColor];
    lable3.color = [CCColor blackColor];
    //[lable3 setColor:ccc3(0, 0, 0)];

    if ([[NSUserDefaults standardUserDefaults]boolForKey:ifTheMusicIson]) {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"声音开.png"];
        musicBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        musicBut.togglesSelectedState = YES;
        [musicBut setTarget:self selector:@selector(musicButclick:)];
        musicBut.position = ccp(winsize.height/2+10, winsize.width/4);
        //musicBut.tag = 1;
        [self addChild:musicBut];
    }
    else
    {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"声音关.png"];
        musicBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        [musicBut setTarget:self selector:@selector(musicButclick:)];
        musicBut.togglesSelectedState = NO;
        musicBut.position = ccp(winsize.height/2+10, winsize.width/4);
       // musicBut.tag = 1;
        [self addChild:musicBut];
    }

    
}
-(void)accleButclick:(CCButton*)but
{
    [accleBut removeFromParentAndCleanup:YES];
    [handBut removeFromParentAndCleanup:YES];
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
         winsize= win;
    }
    else
    {
        winsize= CGSizeMake(win.height, win.width);
    }
    CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"重力开.png"];
    accleBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
    [accleBut setTarget:self selector:@selector(accleButclick:)];
    CCSpriteFrame* spr1 = [CCSpriteFrame frameWithImageNamed:@"手动关.png"];
    handBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr1];
    [handBut setTarget:self selector:@selector(handButclick:)];
    accleBut.position = ccp(winsize.width/2+10, winsize.height*3/4);
    [self addChild:accleBut];
    handBut.position = ccp(winsize.width/2+10, winsize.height/2);
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ifTheGameUseAccle];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self addChild:handBut];
}
-(void)musicButclick:(CCButton*)but
{
    [musicBut removeFromParentAndCleanup:YES];
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }
    if (but.togglesSelectedState) {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"声音关.png"];
        musicBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        musicBut.togglesSelectedState = NO;
        [musicBut setTarget:self selector:@selector(musicButclick:)];
        musicBut.position = ccp(winsize.height/2+10, winsize.width/4);
        [self addChild:musicBut];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ifTheMusicIson];
    }
    else
    {
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"声音开.png"];
        musicBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        musicBut.togglesSelectedState  = YES;
        [musicBut setTarget:self selector:@selector(musicButclick:)];
        musicBut.position = ccp(winsize.height/2+10, winsize.width/4);
        [self addChild:musicBut];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ifTheMusicIson];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
   }
-(void)handButclick:(CCButton*)but
{
    [accleBut removeFromParentAndCleanup:YES];
    [handBut removeFromParentAndCleanup:YES];
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }

    CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"重力关.png"];
    accleBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
    [accleBut setTarget:self selector:@selector(accleButclick:)];
    CCSpriteFrame* spr1 = [CCSpriteFrame frameWithImageNamed:@"手动开.png"];
    handBut = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr1];
    [handBut setTarget:self selector:@selector(handButclick:)];
    accleBut.position = ccp(winsize.height/2+10, winsize.width*3/4);
    [self addChild:accleBut];
    handBut.position = ccp(winsize.height/2+10, winsize.width/2);
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ifTheGameUseAccle];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self addChild:handBut];
}
-(void)tran_to_back
{
  //  [[CCDirector sharedDirector]replaceScene:[CCTransition transitionWithDuration:0.5f scene:[StarSceneTwo scene]]];
    [[CCDirector sharedDirector] replaceScene:[StarSceneTwo scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
}

@end
