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
    float changeSize;
    bool isGrow[5];
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.debugDraw = FALSE;
    
    for (int i = 0; i < 5; i++) {
        randSize = ((float)arc4random() / ARC4RANDOM_MAX) / 4 + 0.25f;
        randX = ((double)arc4random() / ARC4RANDOM_MAX) * 2 - 1;
        randY = ((double)arc4random() / ARC4RANDOM_MAX) * 2 - 1;
        randPositionX = ((double)arc4random() / ARC4RANDOM_MAX) * 400 + 50;
        randPositionY = ((double)arc4random() / ARC4RANDOM_MAX) * 200 + 50;
        bubbles[i] = [CCBReader load:@"Bubble"];
        bubbles[i].position = ccp(randPositionX, randPositionY);
        bubbles[i].scale = randSize;
        [_physicsNode addChild:bubbles[i]];
        CGPoint launchDirection = ccp(randX, randY);
        CGPoint force = ccpMult(launchDirection, 1000);
        [bubbles[i].physicsBody applyForce:force];
        isGrow[i] = TRUE;
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    for (int i = 0; i < 5; i++) {
        bool isTouch = CGRectContainsPoint(bubbles[i].boundingBox, touch.locationInWorld);
        if (isTouch) {
            [self bubbleInteration:i];
        }
    }
}

- (void)bubbleInteration:(int)number {
    NSLog(@"%d", number);
    CCParticleSystem *effect = (CCParticleSystem *)[CCBReader load:@"Effect"];
    effect.autoRemoveOnFinish = TRUE;
    effect.position = bubbles[number].position;
    [bubbles[number].physicsBody setVelocity:ccp(0.0f, 0.0f)];
    [self addChild:effect];
}


- (void)update:(CCTime)delta {
    for (int i = 0; i < 5; i++) {
        if (isGrow[i]) {
            changeSize = bubbles[i].scale + 1.0f;
        } else {
            changeSize = bubbles[i].scale - 1.0f;
        }
        if (isGrow[i] && bubbles[i].scale > 0.5f) {
            isGrow[i] = FALSE;
        }
        if (!isGrow[i] && bubbles[i].scale < 0.25f) {
            isGrow[i] = TRUE;
        }
        changeSize = bubbles[i].scale;
        bubbleVelocity = bubbles[i].physicsBody.velocity;
        bubbleForce = ccpMult(bubbleVelocity, 0.5);
        [bubbles[i].physicsBody applyForce:bubbleForce];
        [bubbles[i] setScale:changeSize];
    }
    
}


@end
