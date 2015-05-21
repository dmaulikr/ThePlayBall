//
//  SetView.h
//  TheRunningBall
//
//  Created by OurEDA on 14-10-9.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "FMSimpleButton.h"
#import  "StarSceneTwo.h"
#import "cocos2d-ui.h"
@interface SetView : CCScene {
    CGSize winsize;
}
+(SetView *) scene;
@property(nonatomic,retain)CCButton* accleBut;
@property(nonatomic,retain)CCButton* handBut;
@property(nonatomic,retain)CCButton* musicBut;
@end
