//
//  StartPage.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/1/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import "StartScene.h"
#import "MainScene.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation StartScene {
    SKView* _skView;
    NSMutableArray* arrOfSounds;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView {
    arrOfSounds = [NSMutableArray new];
    
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    
    _skView = skView;
    [self setup];
    
    return self;
}

- (void)setup {
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"StartPageBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
<<<<<<< HEAD
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
=======
    SKLabelNode* startButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startButton.fontSize = 45;
    startButton.fontColor = [UIColor blackColor];
    startButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.5);
    startButton.text = @"Start Game";
    startButton.name = @"startButton";
    [self addChild:startButton];
    
    SKLabelNode* infoButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    infoButton.fontSize = 45;
    infoButton.fontColor = [UIColor blackColor];
    infoButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.4);
>>>>>>> Beta
    infoButton.text = @"How To Play";
    infoButton.name = @"infoButton";
    [self addChild:infoButton];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
<<<<<<< HEAD
    
    if ([node.name isEqual: @"timeStartButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"timed"];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    if ([node.name isEqual: @"targetStartButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target"];
=======
    if ([node.name isEqual: @"startButton"]) {
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        [self playButtonNoise:self];
>>>>>>> Beta
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    if ([node.name isEqual: @"infoButton"]) {
        [self playButtonNoise:self];
        NSLog(@"Information Button Pressed");
    }
}

- (IBAction)playButtonNoise:(id)sender
{
    NSString* fileName = @"Click";
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [arrOfSounds removeAllObjects];
    [arrOfSounds addObject:newPlayer];
    [newPlayer prepareToPlay];
    [newPlayer play];
}

@end
