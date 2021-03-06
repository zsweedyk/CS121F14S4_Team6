//
//  FireballSprite.h
//  Nom Nom Numbers
//
//  Created by Dani Demas on 11/5/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FireballSprite : NSObject

@property NSTimeInterval animationTime;
@property NSTimeInterval fireballTravelTime;
@property NSTimeInterval fireBurnTime;
@property SKEmitterNode* fireball;

- (void) sendFireballTo:(CGPoint)destination OnScene:(SKScene*)scene;

@end
