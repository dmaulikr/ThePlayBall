//
//  rankscene.m
//  TheRunningBall
//
//  Created by OurEDA on 14-7-8.
//
//

#import "rankscene.h"

@implementation rankscene
+(CCScene *) scene
{
	return [[self alloc]init];
}
-(id)init
{
    if (self = [super init])
    {
        //WithColor:ccc4(255, 215, 0, 255)
        CGSize win = [[UIScreen mainScreen]bounds].size;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
            winsize= CGSizeMake(win.height, win.width);
        }
        else
        {
            winsize= win;
            
        }
//        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"back.png"];
//        CCButton * back_button = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
//        [back_button setTarget:self selector:@selector(tran_to_start)];
//        [self addChild:back_button];
        //背景颜色
        CCNodeColor* back = [[CCNodeColor alloc]initWithColor:[CCColor colorWithRed:255/255.f green:58/255.f blue:74/255.f alpha:1.0f]];
        [self addChild:back];
        long first = 0;
        long second = 0;
       long third = 0;
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheHigestLevel"]) {
            first =[[NSUserDefaults standardUserDefaults] integerForKey:@"TheHigestLevel"];
        }
        CCLabelTTF*leve = [CCLabelTTF labelWithString:@"排行榜" fontName:@"Marker Felt" fontSize:45];
        leve.position = ccp(winsize.height/2, winsize.width*4/5+20);
        [self addChild:leve];
        CCLabelTTF*leve1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"第一名:%ld关", first] fontName:@"Marker Felt" fontSize:40];
                leve1.position = ccp(winsize.height/2, winsize.width*3/5);
               [self addChild:leve1];
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheSecondLevel"]) {
            second =[[NSUserDefaults standardUserDefaults] integerForKey:@"TheSecondLevel"];
        }
        CCLabelTTF*leve2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"第二名:%ld关", second] fontName:@"Marker Felt" fontSize:40];
        leve2.position = ccp(winsize.height/2, winsize.width*2/5);
        [self addChild:leve2];

        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"TheThirdLevel"]) {
            third=[[NSUserDefaults standardUserDefaults] integerForKey:@"TheThirdLevel"];
        }
        CCLabelTTF*leve3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"第三名:%ld关", third] fontName:@"Marker Felt" fontSize:40];
        leve3.position = ccp(winsize.height/2, winsize.width*1/5);
        [self addChild:leve3];
        
        CCSpriteFrame* spr = [CCSpriteFrame frameWithImageNamed:@"back.png"];
        CCButton * back_button = [[CCButton alloc]initWithTitle:@"" spriteFrame:spr];
        [back_button setTarget:self selector:@selector(tran_to_start)];
       // FMSimpleButton* back_button = [FMSimpleButton createSimpleButton:@"back.png" downPath:nil target:self Function:@selector(tran_to_start)];
        
        back_button.position = ccp(50,winsize.width-60 );
        [self addChild:back_button];

    }

    return self;
    
}
-(void)tran_to_start
{
    [[CCDirector sharedDirector] replaceScene:[StarSceneTwo scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];

    // [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"huabanxie.mp3"];
}
@end
