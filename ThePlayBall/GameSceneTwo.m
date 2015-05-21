//
//  GameSceneTwo.m
//  TheRunningBall
//
//  Created by OurEDA-01 on 13-7-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameSceneTwo.h"
#import "rankscene.h"
#import "userDefault.h"
//#import "SimpleAudioEngine.h"

@implementation GameSceneTwo
@synthesize ball;
@synthesize aim;
@synthesize role;
@synthesize scorelable;
@synthesize acceleration;
+(CCScene *) scene
{
	return [[self alloc]init];
}
// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init]) )
	{
        //WithColor:ccc4(255, 193, 37, 200)
        self.acceleration = [[CMMotionManager alloc]init];
       
       
        
        f_tag = 1;
        [self addView];
		//self.ball = [CCSprite spriteWithFile:@"ball.png"];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:ifTheGameUseAccle]) {
             [self setUserInteractionEnabled:NO];
             [self.acceleration startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     NSLog(@"++++++++++++重力感应");
                     float decel = 0.3f;
                     float sensitivity = 6.0f;
                     float maxVelocity = 100;
                     float accelX = accelerometerData.acceleration.y;
                     float accelY = -accelerometerData.acceleration.x;
                     playerVelocity.x = playerVelocity.x* decel + accelX*sensitivity;
                     playerVelocity.y = playerVelocity.y * decel + accelY*sensitivity;
                     if (playerVelocity.x > maxVelocity)
                     {
                         playerVelocity.x = maxVelocity;
                     }
                     else if (playerVelocity.x < - maxVelocity)
                     {
                         playerVelocity.x = - maxVelocity;
                     }
                     
                     if (playerVelocity.y > maxVelocity)
                     {
                         playerVelocity.y = maxVelocity;
                     }
                     else if (playerVelocity.y <- maxVelocity)
                     {
                         playerVelocity.y = -maxVelocity;
                     }
                 });
             }];
        }else
        {
            NSLog(@"手动操作");
            [self setUserInteractionEnabled:YES];
            [self.acceleration stopAccelerometerUpdates];
            
        }
        if ([[NSUserDefaults standardUserDefaults]boolForKey:ifTheMusicIson ]) {
            if (f_tag == 1) {
                [self musicPlay];
            }
        }
        
        
       // [self schedule:@selector(change) interval:0.1f];
        

	}
	return self;
}
-(void)addView
{
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:255/255.f green:58/255.f blue:74/255.f alpha:1.0f]];
    [self addChild:background];
    self.ball = [CCSprite spriteWithImageNamed:@"ball.png"];
    ball.position = ccp(winsize.height-30, winsize.width-30);
    [self addChild:ball];
    self.aim = [CCSprite spriteWithImageNamed:@"aim.png"];
    aim.position = ccp(aim.contentSize.width, aim.contentSize.height);
    totaltime = 0;
    [self addChild:aim];
    [self creatRole];
    [self schedule:@selector(update) interval:0.02f];

}
-(void)musicPlay
{
    //[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"huabanxie.mp3"];
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"huabanxie.mp3"];
     // [myBackMusic pause];
    [[OALSimpleAudio sharedInstance] playBg:@"huabanxie.mp3" loop:YES];
   // [myBackMusic stop];
}
-(void) update{
    // 用playerVelocity持续增加主角精灵的位置信息
    CGPoint pos = ball.position;
    pos.x += playerVelocity.x;
    pos.y += playerVelocity.y;
    // 如果主角精灵移动到了屏幕以外的话,它应该被停止
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        screenSize= CGSizeMake(win.height, win.width);
    }
    else
    {
        screenSize= win;
        
    }
   // CGSize screenSize = CGSizeMake(win.height, win.width);
    float imageWidthHalved = [ball texture].contentSize.width * 0.5f;
    float downboardLimit = [ball texture].contentSize.height*0.5f;
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.height - imageWidthHalved;
    float upBoardLimit = screenSize.width - downboardLimit;
    // 以防主角精灵移动到屏幕以外
    if (pos.x < leftBorderLimit)
    {
        pos.x = leftBorderLimit;
        playerVelocity = CGPointZero;
    }
    else if(pos.x > rightBorderLimit)
    {
        pos.x = rightBorderLimit;
        playerVelocity = CGPointZero;
    }
    if (pos.y <downboardLimit)
    {
        pos.y = downboardLimit;
        playerVelocity = CGPointZero;
    }
    else if (pos.y>upBoardLimit)
    {
        pos.y = upBoardLimit;
        playerVelocity = CGPointZero;
    }
  
    // 将更新过的位置信息赋值给主角精灵
    ball.position = pos;
    //NSLog(@"%.2f",totaltime);
    totaltime += 0.02;
    [self checkForCollision];
}
-(void) checkForCollision
{
    //NSLog(@"0.0.0.0.0.0.0.0.0");
    CCSprite* sp = [CCSprite spriteWithImageNamed:@"role1.png"];
    float playerImageSize = [ball texture].contentSize.width;
    float spiderImageSize = [sp texture].contentSize.width;
    float playerCollisionRadius = playerImageSize * 0.45f;
    float spiderCollisionRadius = spiderImageSize * 0.45f;
    // 这里的碰撞距离和图片形状大约一致
    float maxCollisionDistance = playerCollisionRadius + spiderCollisionRadius;
    float aimDistance = aim.contentSize.width/2+ball.contentSize.width/2;
    for (int i = 0; i < count1; i++)
    {
        CCSprite* role2 = [role objectAtIndex:i];
        float actualDistancex =ccpDistance(role2.position, ball.position);
            // 检查是否两个物体已经碰撞
        if(actualDistancex <maxCollisionDistance)
        {
            [self gameover];
        }
    }
    float a  =ccpDistance(ball.position, aim.position);
    if (a<aimDistance) {
        [self gamewin];
    }
}
-(void)gameover
{
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }
    [self unscheduleAllSelectors];
    CCNodeColor *nodeColor = [[CCNodeColor alloc]initWithColor:[CCColor colorWithRed:255/255.0f green:58/255.0f blue:74/255.0f alpha:1.0f] width:winsize.height height:winsize.width];
    over_background = [[CCSprite alloc] initWithTexture:nil rect:CGRectMake(0, 0, winsize.height, winsize.width)];
    [self addChild:over_background];
    [over_background addChild:nodeColor];
    over_background.position = ccp(winsize.height/2, winsize.width/2);
    //self.scorelable = [CCLabelTTF labelWithString:@"YOU   LOST" fontName:@"Arial" fontSize:48];
    CCSprite* lostImg = [CCSprite spriteWithImageNamed:@"lost 字体.png"];
    lostImg.position = CGPointMake(winsize.height/3,winsize.width*2/3);
    [over_background addChild:lostImg];
    //scorelable.position = CGPointMake(winsize.height/2,winsize.width-30);
    //scorelable.anchorPoint = CGPointMake(0.5f, 1.0f);
    //[self addChild:scorelable];
    if ([Level shardeLevel].le>[[NSUserDefaults standardUserDefaults] integerForKey:@"TheHigestLevel"])
    {
        [[NSUserDefaults standardUserDefaults]setInteger: [Level shardeLevel].le forKey:@"TheHigestLevel"];
    }
    else if([Level shardeLevel].le>[[NSUserDefaults standardUserDefaults] integerForKey:@"TheSecondLevel"])
    {
        [[NSUserDefaults standardUserDefaults]setInteger: [Level shardeLevel].le forKey:@"TheSecondLevel"];
    }
    else if ([Level shardeLevel].le>[[NSUserDefaults standardUserDefaults] integerForKey:@"TheThirdLevel"])
    {
        [[NSUserDefaults standardUserDefaults]setInteger: [Level shardeLevel].le forKey:@"TheThirdLevel"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    //CCButton* back_button = [FMSimpleButton createSimpleButton:@"continue.png" downPath:nil target:self Function:@selector(tran_to_start)];
    CCSprite* LostImgSp = [CCSprite spriteWithImageNamed:@"lost人物.png"];
    LostImgSp.position = CGPointMake(winsize.height*2/3,winsize.width/2);
    [self addChild:LostImgSp];
    CCSpriteFrame* spriteframe = [CCSpriteFrame frameWithImageNamed:@"back1.png"];
    CCButton* back_button = [CCButton buttonWithTitle:@"" spriteFrame:spriteframe];
    back_button.position = ccp(winsize.height/3, winsize.width/3);
    [back_button setTarget:self selector:@selector(tran_to_start)];
    [self addChild:back_button];
    [[Level shardeLevel]levedown];
}
-(void)gamewin
{
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
    }
    [self unscheduleAllSelectors];
    CCNodeColor *nodeColor = [[CCNodeColor alloc]initWithColor:[CCColor colorWithRed:255/255.0f green:58/255.0f blue:74/255.0f alpha:1.0f] width:winsize.height height:winsize.width];
    over_background = [[CCSprite alloc] initWithTexture:nil rect:CGRectMake(0, 0, winsize.height, winsize.width)];
    [over_background addChild:nodeColor];
    [self addChild:over_background];
    over_background.position = ccp(winsize.height/2, winsize.width/2);
    scorelable = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:30];
    scorelable.position = CGPointMake(winsize.height/3,winsize.width*2/3);
    scorelable.anchorPoint = CGPointMake(0.5f, 1.0f);
    CCSprite* lostImg = [CCSprite spriteWithImageNamed:@"WIN字体.png"];
    lostImg.position = CGPointMake(winsize.height/3,winsize.width*2/3+50);
    [over_background addChild:lostImg];
    [self addChild:scorelable];
    totaltime = 100/totaltime*[Level shardeLevel].le;
    scorelable.string = [NSString stringWithFormat:@"NEXT:第%ld关",[Level shardeLevel].le+1];
    CCSprite* LostImgSp = [CCSprite spriteWithImageNamed:@"win图标.png"];
    LostImgSp.position = CGPointMake(winsize.height*2/3,winsize.width/2);
    [self addChild:LostImgSp];
    CCSpriteFrame* spriteframe = [CCSpriteFrame frameWithImageNamed:@"Next.png"];
    CCButton* back_button = [CCButton buttonWithTitle:@"" spriteFrame:spriteframe];
    back_button.position = ccp(winsize.height/3, winsize.width/3+40);
    [back_button setTarget:self selector:@selector(tran_to_continue)];
    [self addChild:back_button];
    CCSpriteFrame* spriteframe1 = [CCSpriteFrame frameWithImageNamed:@"back1.png"];
    CCButton* cont_button = [CCButton buttonWithTitle:@"" spriteFrame:spriteframe1];
    cont_button.position = ccp(winsize.height/3, winsize.width/3-30);
    [cont_button setTarget:self selector:@selector(tran_to_start)];
    [self addChild:cont_button];
    [[Level shardeLevel]leveup];
}
-(void)tran_to_continue
{
    f_tag = 2;
    [over_background removeFromParent];
    [self removeAllChildrenWithCleanup:YES];
    [self addView];
   //[[CCDirector sharedDirector] replaceScene:[GameSceneTwo scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
}
-(void)tran_to_start
{
    [[OALSimpleAudio sharedInstance] stopBg];
 [[CCDirector sharedDirector] replaceScene:[StarSceneTwo scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];
}
//-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
//{
//    float decel = 0.3f;
//    float sensitivity = 6.0f;
//    float maxVelocity = 100;
//    float accelX = acceleration.y;
//    float accelY = -acceleration.x;
//    playerVelocity.x = playerVelocity.x* decel + accelX*sensitivity;
//    playerVelocity.y = playerVelocity.y * decel + accelY*sensitivity;
//    if (playerVelocity.x > maxVelocity)
//    {
//        playerVelocity.x = maxVelocity;
//    }
//    else if (playerVelocity.x < - maxVelocity)
//    {
//        playerVelocity.x = - maxVelocity;
//    }
//
//        if (playerVelocity.y > maxVelocity)
//    {
//        playerVelocity.y = maxVelocity;
//    }
//    else if (playerVelocity.y <- maxVelocity)
//    {
//        playerVelocity.y = -maxVelocity;
//    }
//        
//}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [self locationFromTouches:touches];
    
    // Log touch location
    //CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo* act = [CCActionMoveTo actionWithDuration:0.3f position:touchLoc];
    //CCMoveTo *move = [CCMoveTo actionWithDuration:0.3 position:touchLoc];
    [ball runAction:act];

}
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.5f position:touchLoc];
    [ball runAction:actionMove];
}
-(void)change
{
    	
}
-(CGPoint)locationFromTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView: [touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(void)creatRole
{
    CGSize win = [[UIScreen mainScreen]bounds].size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        winsize= CGSizeMake(win.height, win.width);
    }
    else
    {
        winsize= win;
        
    }

        int i,j;
        count1 = 0;
        float p = ([Level shardeLevel].le-1)/10;
        role = [[NSMutableArray alloc]initWithCapacity:100];
		for ( j=0,i = 0; ; i++)
        {
             CCSprite* role1 = [CCSprite spriteWithImageNamed:@"role1.png"];
            int ran = (CCRANDOM_0_1()+1.4);
            int ran2 = (CCRANDOM_0_1()+1.4);
            //role = [[NSMutableArray alloc]init];
            //NSLog(@"----------------------%f",winsize.height);
			role1.position = ccp(([role1 texture].contentSize.width)*i*(2-p)+ball.contentSize.width*ran, [role1 texture].contentSize.height*j*(2-p)+ball.contentSize.width*ran2);         
                if (role1.position.x<-ball.contentSize.width*2||role1.position.x > winsize.height||role1.position.y<-10)
                {
                        j++;
                        i=-1;
                }
            if (ccpDistance(role1.position, ball.position)>=(ball.contentSize.width/2+role1.contentSize.width/2)&&ccpDistance(role1.position, aim.position)>=(aim.contentSize.width/2+role1.contentSize.width/2)) {
            [self addChild:role1 z:0];
               // [self add]
            [role addObject:role1];
            count1++;
            }
            if (role1.position.y>winsize.width+ball.contentSize.height)
            {
                break;
            }
		}

}
-(void)dealloc
{
    self.aim = nil;
	//[super dealloc];
	//self.role = nil;
//    self.aim = nil;
//    //self.scorelable = nil;
//    self.ball = nil;
}
- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}
//- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
//{
//    // perform any interruption handling here
//    printf("Interruption Detected\n");
//    [[NSUserDefaults standardUserDefaults] setFloat:[myBackMusic currentTime] forKey:@"Interruption"];
//}
//
//- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
//{
//    // resume playback at the end of the interruption
//    printf("Interruption ended\n");
//    [myBackMusic play];
//    
//    // remove the interruption key. it won't be needed
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Interruption"];
//}
@end
