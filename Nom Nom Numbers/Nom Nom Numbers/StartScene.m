//
//  StartPage.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/1/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import "StartScene.h"
#import "MainScene.h"
#import "TimedTutorialScene.h"
#import "TargetTutorialScene.h"
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
    
    SKLabelNode* timeStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timeStartButton.fontSize = 45;
    timeStartButton.fontColor = [UIColor blackColor];
    timeStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.4);
    timeStartButton.text = @"Timed Mode";
    timeStartButton.name = @"timeStartButton";
    [self addChild:timeStartButton];
    
    SKLabelNode* targetStartButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetStartButton.fontSize = 45;
    targetStartButton.fontColor = [UIColor blackColor];
    targetStartButton.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.3);
    targetStartButton.text = @"Target Mode";
    targetStartButton.name = @"targetStartButton";
    [self addChild:targetStartButton];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"timeStartButton"]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TimeModeHasLaunched"]) {
            
            // first time launch timed-mode, so display the tutorial
            SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"timed"];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            // already launched timed-mode before, so go straight into the timed-mode gameplay
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TimeModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene *timedTutorialScence = [[TimedTutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:timedTutorialScence transition:transition];

        }
        
    }
    
    if ([node.name isEqual: @"targetStartButton"]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TargetModeHasLaunched"]) {
            
            // first time launch target-mode, so display the tutorial
            SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"target"];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            
            // already launched timed-mode before, so go straight into the target-mode gameplay
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TargetModeHasLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SKScene *targetTutorialScence = [[TargetTutorialScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:targetTutorialScence transition:transition];

        }
        
        
    }
    
    if ([node.name isEqual: @"infoButton"]) {
        [self playButtonNoise:self];
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
