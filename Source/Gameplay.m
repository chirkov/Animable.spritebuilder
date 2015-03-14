//
//  Gameplay.m
//  Animable
//
//  Created by Chirkov Dima on 14.03.15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    
    CCNode* bubble = [CCBReader load:@"Bubble"];
    bubble.position = ccp(0, 0);
    
    [_physicsNode addChild:bubble];
    
    CGPoint launchDirection = ccp(1, 1);
    CGPoint force = ccpMult(launchDirection, 80000);
    [bubble.physicsBody applyForce:force];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    [self bubbleInteration];
}

- (void)bubbleInteration {
    CCLOG(@"Bubble touched");
    
}

@end
