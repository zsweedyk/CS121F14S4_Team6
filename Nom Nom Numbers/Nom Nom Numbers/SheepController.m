//
//  UIViewController+SheepController.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepController.h"
#import "SheepSprite.h"
#import "SheepModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Generator.h"

@implementation SheepController
{
    SKScene* _skScene;
    SheepSprite* _sheepSprite;
    Generator* _generator;
    int _targetScore;
    int _staggerOffset;
}

// Called only first time to initialize necessary sprite nodes and scenes, and then
// creates 5 sheep to be sent across the screen
- (void) setupSheep:(SKScene *)mainScene
{
    _sheepSprite = [[SheepSprite alloc] init];
    _skScene = mainScene;
    _arrOfSounds = [NSMutableArray new];

    for (int i = 0; i < 6; i++) {
        SKNode *newSheepNode = [[SKNode alloc] init];
        _staggerOffset = (i % 2)*80;
        newSheepNode.position = CGPointMake(i*105 + 250, -200 - _staggerOffset);
        [self makeSheep:newSheepNode];
    }
}

// Each time a sheep runs off the screen, this method creates a new individual sheep
- (void) generateNewSheep:(SKNode *)node
{
    [node removeFromParent];
    [self makeSheep:node];
}

// Given a node, this method does all the initilizations and communication necessary to create
// a fully functional sheep node
- (void) makeSheep:(SKNode *)node
{
    SheepModel* newSheepModel = [[SheepModel alloc] init];
    [newSheepModel makeSheepFrom:-100 to:100];
    NSString* value = [newSheepModel getValue];
    char oper = [newSheepModel getOperator];
    
    SKNode *newSheepNode = [_sheepSprite createSheepWithValue:value andOper:oper atPos:node.position];
    newSheepNode.name = @"sheep";
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    NSString* operAsString = [NSString stringWithFormat:@"%c",oper];

    [dictionary setValue:value forKey:@"Value"];
    [dictionary setValue:operAsString forKey:@"Operator"];
    [newSheepNode setUserData:dictionary];
    
    [_skScene addChild:newSheepNode];
    [self playSheepNoise:self];
    [newSheepNode setPosition:CGPointMake(newSheepNode.position.x, -150)];
    newSheepNode.zPosition = 0;
}

// Plays noise when sheep is created
- (IBAction) playSheepNoise:(id)sender
{
    NSString* fileName = @"Sheep";
    int randomValue = arc4random_uniform(2);
    
    if (randomValue == 1) {
        fileName = @"Sheep2";
    }
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL* fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [_arrOfSounds addObject:newPlayer];
    newPlayer.volume = 0.5;
    [newPlayer prepareToPlay];
    [newPlayer play];
}

// Generates a random integer from -100 to 100 in order to obtain a target score
- (int) getTargetScore
{
    _targetScore = 0;
    _generator = [[Generator alloc] init];
    
    while (_targetScore == 0) {
        _targetScore = [_generator generateIntegerfrom:-100 to:100];
    }
    
    return _targetScore;
}
@end
