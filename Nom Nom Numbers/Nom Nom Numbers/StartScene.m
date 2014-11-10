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
    
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    
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
    
    SKLabelNode* timeStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timeStartButton.fontSize = 45;
    timeStartButton.fontColor = [UIColor whiteColor];
    timeStartButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.6);
    timeStartButton.text = @"Timed Mode";
    timeStartButton.name = @"timeStartButton";
    [self addChild:timeStartButton];
    
    SKLabelNode* targetStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetStartButton.fontSize = 45;
    targetStartButton.fontColor = [UIColor whiteColor];
    targetStartButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    targetStartButton.text = @"Target Mode";
    targetStartButton.name = @"targetStartButton";
    [self addChild:targetStartButton];
    
    SKLabelNode* infoButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    infoButton.fontSize = 45;
    infoButton.fontColor = [UIColor whiteColor];
    infoButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.4);
    infoButton.text = @"How To Play";
    infoButton.name = @"infoButton";
    [self addChild:infoButton];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"timeStartButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"timed"];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    if ([node.name isEqual: @"targetStartButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target"];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    if ([node.name isEqual: @"infoButton"]) {
        NSLog(@"Information Button Pressed");
    }
    
}

@end
