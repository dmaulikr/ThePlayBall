//
//  Level.h
//  TheRunningBall
//
//  Created by OurEDA-25 on 13-7-16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Level : CCNode {

}
@property(nonatomic,assign)NSInteger le;
+(Level*)shardeLevel;
-(void)levedown;
-(void)leveup;
@end
