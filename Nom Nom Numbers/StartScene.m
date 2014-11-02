//
//  StartPage.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/1/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import "StartScene.h"
#import "MainScene.h"

@implementation StartScene {
    SKView* _skView;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView {
    
    if (self = [super initWithSize:size]) {
        
    }
    _skView = skView;
    [self setup];
    
    return self;
}

- (void)setup {
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    SKLabelNode* title = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    title.fontSize = 60;
    title.fontColor = [UIColor whiteColor];
    title.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.9);
    title.text = @"Nom Nom Numbers";
    title.name = @"title";
    [self addChild:title];
    
    SKLabelNode* startButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startButton.fontSize = 45;
    startButton.fontColor = [UIColor whiteColor];
    startButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.6);
    startButton.text = @"Start Game";
    startButton.name = @"startButton";
    [self addChild:startButton];
    
    SKLabelNode* infoButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    infoButton.fontSize = 45;
    infoButton.fontColor = [UIColor whiteColor];
    infoButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    infoButton.text = @"How To Play";
    infoButton.name = @"infoButton";
    [self addChild:infoButton];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"startButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    if ([node.name isEqual: @"infoButton"]) {
        NSLog(@"Information Button Pressed");
    }
    
}

@end
