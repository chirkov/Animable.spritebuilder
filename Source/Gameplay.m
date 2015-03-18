//
//  Gameplay.m
//  Animable
//
//  Created by Chirkov Dima on 14.03.15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#include "stdlib.h"
#define ARC4RANDOM_MAX 0x100000000

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CGPoint bubbleVelocity;
    CGPoint bubbleForce;
    CCNode* bubbles[5];
    float randSize;
    float randX;
    float randY;
    float randPositionX;
    float randPositionY;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.debugDraw = FALSE;
    
    for (int i = 0; i < 5; i++) {
        randSize = ((float)arc4random() / ARC4RANDOM_MAX)/2;
        randX = ((double)arc4random() / ARC4RANDOM_MAX);
        randY = ((double)arc4random() / ARC4RANDOM_MAX);
        randPositionX = ((double)arc4random() / ARC4RANDOM_MAX)*100;
        randPositionY = ((double)arc4random() / ARC4RANDOM_MAX)*100;
        NSLog(@"%d", arc4random() % 100);
        bubbles[i] = [CCBReader load:@"Bubble"];
        bubbles[i].position = ccp(randPositionX, randPositionY);
        bubbles[i].scale = randSize;
        [_physicsNode addChild:bubbles[i]];
        CGPoint launchDirection = ccp(randX, randY);
        CGPoint force = ccpMult(launchDirection, 1000);
        [bubbles[i].physicsBody applyForce:force];
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    [self bubbleInteration];
}

- (void)bubbleInteration {
    CCLOG(@"Bubble touched");
    
}

- (void)update:(CCTime)delta {
    for (int i = 0; i < 5; i++) {
        bubbleVelocity = bubbles[i].physicsBody.velocity;
        bubbleForce = ccpMult(bubbleVelocity, 0.5);
        [bubbles[i].physicsBody applyForce:bubbleForce];
    }
    
}

@end
