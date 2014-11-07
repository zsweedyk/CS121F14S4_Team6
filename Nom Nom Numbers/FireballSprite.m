//
//  FireballSprite.m
//  Nom Nom Numbers
//
//  Created by Dani Demas on 11/5/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "FireballSprite.h"

@implementation FireballSprite

- (id) init
{
    self = [super init];
    
    _fireballTravelTime = 0.4;
    _fireball = [[SKSpriteNode alloc] initWithImageNamed:@"Sheep"];
    
    return self;
}

- (void) sendFireballTo:(CGPoint)destination OnScene:(SKScene*)scene
{
    CGSize barnSize = [UIImage imageNamed:@"barnAndDragon"].size;
    barnSize.height *= 0.5;
    barnSize.width *= 0.5;
    CGSize sceneSize = scene.size;
    
    CGPoint start = CGPointMake(sceneSize.width - barnSize.width, (sceneSize.height / 2) - 50);
    _fireball.size = CGSizeMake(20,20);
    _fireball.position = start;
    
    NSLog(@"Sending fireball from x %f y %f to x %f y %f", start.x, start.y, destination.x, destination.y);
    
    [scene addChild:_fireball];
    SKAction* moveFireball = [SKAction moveTo:destination duration:_fireballTravelTime];
    SKAction* remove = [SKAction removeFromParent];
    [_fireball runAction:[SKAction sequence:@[moveFireball, remove]]];
}

@end
