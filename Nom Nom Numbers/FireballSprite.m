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
    _fireBurnTime = 0.5;
    _fireball = [[SKEmitterNode alloc] init];
    
    return self;
}

- (void) sendFireballTo:(CGPoint)destination OnScene:(SKScene*)scene
{
    CGSize barnSize = [UIImage imageNamed:@"barnAndDragon"].size;
    barnSize.height *= 0.5;
    barnSize.width *= 0.5;
    CGSize sceneSize = scene.size;
    
    CGPoint start = CGPointMake(sceneSize.width - barnSize.width + 30, (sceneSize.height / 2) - 50);
    
    NSString *fireballPath = [[NSBundle mainBundle] pathForResource:@"FireballParticle" ofType:@"sks"];
    _fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:fireballPath];
    _fireball.targetNode = scene;
    _fireball.position = start;
    
    [scene addChild: _fireball];
    SKAction* moveFireball = [SKAction moveTo:destination duration:_fireballTravelTime];
    SKAction* dieOut = [SKAction runBlock:^{ _fireball.particleBirthRate = 0; }];
    SKAction* waitForFire = [SKAction waitForDuration:_fireBurnTime];
    SKAction* remove = [SKAction removeFromParent];
    [_fireball runAction:[SKAction sequence:@[moveFireball, dieOut, waitForFire, remove]]];
    
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"FireParticle" ofType:@"sks"];
    SKEmitterNode* fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    CGSize sheepSize = [UIImage imageNamed:@"Sheep"].size;
    CGPoint fireDestination = destination;
    fireDestination.y -= (sheepSize.height/4);
    fire.position = fireDestination;

    SKAction* waitForFireball = [SKAction waitForDuration:_fireballTravelTime - 0.1];
    SKAction* fireDieOut = [SKAction runBlock:^{ fire.particleBirthRate = 0; }];
    SKAction* addFire = [SKAction runBlock:^{ [scene addChild: fire]; }];
    [_fireball runAction:[SKAction sequence:@[waitForFireball, addFire, fireDieOut, waitForFire, remove]]];

}

@end
