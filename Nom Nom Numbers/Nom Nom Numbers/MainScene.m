//
//  MainScene.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "MainScene.h"
#import "SheepView.h"

@implementation MainScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self setup];
    }
    
    return self;
    
}

-(void) setup {
    [self setupBackground];
    [self setupDragon];
    [self setupSheep];
}

-(void) setupBackground {
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
}

-(void) setupDragon {
    
    SKSpriteNode *dragon = [SKSpriteNode spriteNodeWithImageNamed:@"dragon"];
    dragon.position = CGPointMake(840, 170);
    dragon.anchorPoint = CGPointZero;
    dragon.xScale = .5;
    dragon.yScale = .5;
    [self addChild:dragon];
}

-(void) setupSheep {
    
    SheepView* sheepview = [[SheepView alloc] init];
    SKSpriteNode *sheep = [sheepview makeASheep];
    [self addChild:sheep];
    
}

@end
