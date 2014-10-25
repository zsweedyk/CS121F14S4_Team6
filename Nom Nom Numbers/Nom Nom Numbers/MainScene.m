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
    
    for (int i = 1; i < 6; i++) {
        SKSpriteNode *newSheep = [sheepview makeASheep];
        //Sheep all have different names right now to show that they can be distinguished when clicked
        //Going to change them to all have the same name later on, and just use the userdata property
        //of SKNodes to distinguish values, operators, etc
        NSString* sheepName = [NSString stringWithFormat:@"sheep%d",i]; //@"sheep";
        newSheep.name = sheepName;
        [newSheep setPosition:CGPointMake(740, i*100 - 40)];
        [self addChild:newSheep];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    NSLog(@"%@ tapped",node.name);
 
}

- (void)update:(NSTimeInterval)currentTime {
    
    //Ideally we only have one of these that recognize the name "sheep" instead of "sheep(int)"
    //I only have the same code repeated so many times so that we can NSLog which sheep is clicked

    [self enumerateChildNodesWithName:@"sheep1" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -150){
            [node setPosition:CGPointMake(740, node.position.y)];
        }
    }];
    [self enumerateChildNodesWithName:@"sheep2" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -150){
            [node setPosition:CGPointMake(740, node.position.y)];
        }
    }];
    [self enumerateChildNodesWithName:@"sheep3" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -150){
            [node setPosition:CGPointMake(740, node.position.y)];
        }
    }];
    [self enumerateChildNodesWithName:@"sheep4" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -150){
            [node setPosition:CGPointMake(740, node.position.y)];
        }
    }];
    [self enumerateChildNodesWithName:@"sheep5" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -150){
            [node setPosition:CGPointMake(740, node.position.y)];
        }
    }];
}


- (void)sheepTapped {
    NSLog(@"Sheep tapped");
}

@end
