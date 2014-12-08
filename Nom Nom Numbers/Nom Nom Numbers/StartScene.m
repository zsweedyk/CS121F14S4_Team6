//
//  StartPage.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/1/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import "StartScene.h"
#import "MainScene.h"
#import "TutorialScene.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation StartScene
{
    SKView* _skView;
    NSMutableArray* _arrOfSounds;
}

- (id) initWithSize:(CGSize)size andSKView:(SKView *)skView
{
    
    _arrOfSounds = [NSMutableArray new];
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    _skView = skView;
    [self setup];
    
    return self;
}

- (void) setup
{
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"StartPageBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    SKLabelNode* timeStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timeStartButton.fontSize = 45;
    timeStartButton.fontColor = [UIColor blackColor];
    timeStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.45);
    timeStartButton.text = @"Timed Mode";
    timeStartButton.name = @"timeStartButton";
    [self addChild:timeStartButton];
    
    SKLabelNode* targetStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetStartButton.fontSize = 45;
    targetStartButton.fontColor = [UIColor blackColor];
    targetStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.37);
    targetStartButton.text = @"Target Mode";
    targetStartButton.name = @"targetStartButton";
    [self addChild:targetStartButton];
    
    SKLabelNode* tutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    tutorialButton.fontSize = 45;
    tutorialButton.fontColor = [UIColor blackColor];
    tutorialButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.29);
    tutorialButton.text = @"Tutorial";
    tutorialButton.name = @"tutorialButton";
    [self addChild:tutorialButton];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode* node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"timeStartButton"]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TimeModeHasLaunched"]) {
            
            // Already launched timed-mode before, so go straight into the timed-mode gameplay
            SKScene* gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"timed"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            // First time launch timed-mode, so display the tutorial
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TimeModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene* timedTutorialScence = [[TutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode: @"timed" andOrigin:@"startingGame"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:timedTutorialScence transition:transition];
        }
    }
    
    if ([node.name isEqual: @"targetStartButton"]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TargetModeHasLaunched"]) {
            // Already launched timed-mode before, so go straight into the target-mode gameplay
            SKScene* gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            // First time launch target-mode, so display the tutorial
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TargetModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene* targetTutorialScence = [[TutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target" andOrigin:@"startingGame"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:targetTutorialScence transition:transition];
        }
    }
    
    if ([node.name isEqual: @"tutorialButton"]) {
        [self playButtonNoise:self];
        
        SKLabelNode* timedTutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        timedTutorialButton.fontSize = 30;
        timedTutorialButton.fontColor = [UIColor blackColor];
        timedTutorialButton.position = CGPointMake(self.size.width * 0.42, self.size.height * 0.31);
        timedTutorialButton.text = @"Timed Mode";
        timedTutorialButton.name = @"timedTutorialButton";
        [self addChild:timedTutorialButton];
        
        SKLabelNode* targetTutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        targetTutorialButton.fontSize = 30;
        targetTutorialButton.fontColor = [UIColor blackColor];
        targetTutorialButton.position = CGPointMake(self.size.width * 0.42, self.size.height * 0.27);
        targetTutorialButton.text = @"Target Mode";
        targetTutorialButton.name = @"targetTutorialButton";
        [self addChild:targetTutorialButton];
    }
    
    if ([node.name isEqual: @"timedTutorialButton"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TimeModeHasLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SKScene* timedTutorialScence = [[TutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode: @"timed"  andOrigin:@"tutorialButton"];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:timedTutorialScence transition:transition];
    }
    
    if ([node.name isEqual: @"targetTutorialButton"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TargetModeHasLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SKScene* targetTutorialScence = [[TutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target" andOrigin:@"tutorialButton"];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:targetTutorialScence transition:transition];
    }
}

// Plays noise when button is clicked
- (IBAction) playButtonNoise:(id)sender
{
    NSString* fileName = @"Click";
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL* fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [_arrOfSounds removeAllObjects];
    [_arrOfSounds addObject:newPlayer];
    [newPlayer prepareToPlay];
    [newPlayer play];
}

@end
