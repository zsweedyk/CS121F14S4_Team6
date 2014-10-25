//
//  MainScene.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "MainScene.h"
#import "SheepView.h"

@implementation MainScene {
    SKView* _skView;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView {
    _skView = skView;
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
    
    SKSpriteNode *sheep1 = [sheepview makeASheep];
    sheep1.name = @"sheep1";
    [sheep1 setPosition:CGPointMake(740, 170)];
    [self addChild:sheep1];

    
    SKSpriteNode *sheep2 = [sheepview makeASheep];
    sheep2.name = @"sheep2";
    [sheep2 setPosition:CGPointMake(740, 370)];
    [self addChild:sheep2];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    NSLog(@"%@",node.name);
 
}


- (void)sheepTapped {
    NSLog(@"Sheep tapped");
}

@end
