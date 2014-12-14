//
//  StartPage.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/1/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "StartScene.h"
#import "MainScene.h"
#import "HighScoreScene.h"
#import "TutorialScene.h"
#import "CreditsScene.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation StartScene
{
    NSMutableArray* _arrOfSounds; // a sequence of sound effects
    SKLabelNode* _timedTutorialButton;
    SKLabelNode* _targetTutorialButton;
}

- (id) initWithSize:(CGSize)size andSKView:(SKView *)skView
{  
    _arrOfSounds = [NSMutableArray new];
    self = [super initWithSize:size];
    [self setup];
    
    return self;
}

- (void) setup
{
    // set up background image
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"StartPageBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    // Time Mode button
    SKLabelNode* timeStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timeStartButton.fontSize = 45;
    timeStartButton.fontColor = [UIColor blackColor];
    timeStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.5);
    timeStartButton.text = @"Timed Mode";
    timeStartButton.name = @"timeStartButton";
    [self addChild:timeStartButton];
    
    // Target Mode button
    SKLabelNode* targetStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetStartButton.fontSize = 45;
    targetStartButton.fontColor = [UIColor blackColor];
    targetStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.4);
    targetStartButton.text = @"Target Mode";
    targetStartButton.name = @"targetStartButton";
    [self addChild:targetStartButton];
    
    // High Score Mode button
    SKLabelNode* highScoreButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    highScoreButton.fontSize = 45;
    highScoreButton.fontColor = [UIColor blackColor];
    highScoreButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.3);
    highScoreButton.text = @"High Scores";
    highScoreButton.name = @"highScoreButton";
    [self addChild:highScoreButton];
    
    // Tutorial button
    SKLabelNode* tutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    tutorialButton.fontSize = 45;
    tutorialButton.fontColor = [UIColor blackColor];
    tutorialButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.2);
    tutorialButton.text = @"Tutorial";
    tutorialButton.name = @"tutorialButton";
    [self addChild:tutorialButton];
    
    // Credit Page button
    SKLabelNode* creditsButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    creditsButton.fontSize = 45;
    creditsButton.fontColor = [UIColor blackColor];
    creditsButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.1);
    creditsButton.text = @"Credits";
    creditsButton.name = @"creditsButton";
    [self addChild:creditsButton];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode* node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"timeStartButton"]) {
        
        // Go to timed mode
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TimeModeHasLaunched"]) {
            
            // Already launched timed-mode before, so go straight into the timed-mode gameplay
            [self playButtonNoise:self];
            SKScene* gameScene = [[MainScene alloc] initWithSize:self.size andSKView:nil andMode:@"timed"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            
            // First time launch timed-mode, so display the tutorial
            [self playButtonNoise:self];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TimeModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene* timedTutorialScence = [[TutorialScene alloc] initWithSize:self.size andSKView:nil andMode: @"timed" andOrigin:@"startingGame"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:timedTutorialScence transition:transition];
        }
    }
    
    else if ([node.name isEqual: @"targetStartButton"]) {
        
        // Go to target mode
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TargetModeHasLaunched"]) {
            // Already launched timed-mode before, so go straight into the target-mode gameplay
            [self playButtonNoise:self];
            SKScene* gameScene = [[MainScene alloc] initWithSize:self.size andSKView:nil andMode:@"target"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            // First time launch target-mode, so display the tutorial
            [self playButtonNoise:self];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TargetModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene* targetTutorialScene = [[TutorialScene alloc] initWithSize:self.size andSKView:nil andMode:@"target" andOrigin:@"startingGame"];
            SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:targetTutorialScene transition:transition];
        }
    }
    
    else if ([node.name isEqual: @"highScoreButton"]) {
        
        // Go to high score stats page
        [self playButtonNoise:self];
        SKScene* highScoreScene = [[HighScoreScene alloc] initWithSize:self.size];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:highScoreScene transition:transition];
    }
    
    else if ([node.name isEqual: @"tutorialButton"]) {
        
        // User clicked on the tutorial button
        [self playButtonNoise:self];
        [self removeTutorialButtons];
        
        // Let the user choose which tutorial mode o go to
        _timedTutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        _timedTutorialButton.fontSize = 30;
        _timedTutorialButton.fontColor = [UIColor blackColor];
        _timedTutorialButton.position = CGPointMake(self.size.width * 0.42, self.size.height * 0.22);
        _timedTutorialButton.text = @"Timed Mode";
        _timedTutorialButton.name = @"timedTutorialButton";
        [self addChild:_timedTutorialButton];
        
        _targetTutorialButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        _targetTutorialButton.fontSize = 30;
        _targetTutorialButton.fontColor = [UIColor blackColor];
        _targetTutorialButton.position = CGPointMake(self.size.width * 0.42, self.size.height * 0.18);
        _targetTutorialButton.text = @"Target Mode";
        _targetTutorialButton.name = @"targetTutorialButton";
        [self addChild:_targetTutorialButton];
    }
    
    else if ([node.name isEqual: @"timedTutorialButton"]) {
        
        // Go to timed mode tutorial page
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TimedModeHasLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SKScene* timedTutorialScene = [[TutorialScene alloc] initWithSize:self.size andSKView:nil andMode:@"timed" andOrigin:@"tutorialButton"];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:timedTutorialScene transition:transition];
    }
    
    else if ([node.name isEqual: @"targetTutorialButton"]) {
        
        // Go to target mode tutorial page
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TargetModeHasLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SKScene* targetTutorialScene = [[TutorialScene alloc] initWithSize:self.size andSKView:nil andMode:@"target" andOrigin:@"tutorialButton"];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:targetTutorialScene transition:transition];
        
    } else if ([node.name isEqual: @"creditsButton"]) {
        [self playButtonNoise:self];
        
        SKScene* creditsScene = [[CreditsScene alloc] initWithSize:self.size andSKView:nil];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:creditsScene transition:transition];
        
    } else {
        
        [self removeTutorialButtons];
    }
}

- (void) removeTutorialButtons
{
    // Take away the tutorial mode selection
    if ([self childNodeWithName:@"timedTutorialButton"] != nil) {
        [_timedTutorialButton removeFromParent];
    }
    if ([self childNodeWithName:@"targetTutorialButton"]!= nil) {
        [_targetTutorialButton removeFromParent];
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
