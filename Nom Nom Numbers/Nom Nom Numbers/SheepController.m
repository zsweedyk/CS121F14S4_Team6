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
    int _currentScore;
    int _staggerOffset;
    NSString* _mode;
}



// Called only first time to initialize necessary sprite nodes and scenes, and then
// creates 5 sheep to be sent across the screen
- (void) setupSheep:(SKScene *)mainScene forMode:(NSString *)mode
{
    _sheepSprite = [[SheepSprite alloc] init];
    _skScene = mainScene;
    _arrOfSounds = [NSMutableArray new];
    _mode = mode;
    
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

- (void) sendScore:(double)score {
    _currentScore = score;
}

- (NSString *)createValueForOper:(int)oper
{
    int pickValue = arc4random_uniform(5);
    int value = 5 * pickValue;
    NSString* valueString;
    
    switch (oper) {
        case 0:
            value = _targetScore - value;
            valueString = [NSString stringWithFormat:@" %d", value];
            break;
        case 1:
            value = _targetScore + value;
        default:
            break;
    }
    
    return valueString;
}

// Creates a sheep that is some operation and value away from target score
- (void) createTargetSheep:(SheepModel *)sheepModel
{
    int pickOperator = arc4random_uniform(4);
    int pickValue1 = arc4random_uniform(3)+1;
    int pickValue2 = arc4random_uniform(7)+1;
    int value = pickValue1 * pickValue2;
    NSString* valueString;
    
    int pickOffset = arc4random_uniform(8);
    
    int approxTarget;
    if (pickOffset == 0) {
        approxTarget = _targetScore;
    } else if (pickOffset < 4) {
        approxTarget = _targetScore - _currentScore - value*pickValue1;
    } else {
        approxTarget = _targetScore - _currentScore + value*pickValue1;
    }
    
    if (value == 0) {
        pickOperator = 0;
    }

    
    switch (pickOperator) {
        // addition case
        case 0:
            value = approxTarget - value;
            [sheepModel setOper:'+'];
            break;
        // subtraction case
        case 1:
            value = approxTarget + value;
            [sheepModel setOper:'-'];
            break;
        // multiplication case
        case 2:
            value = approxTarget / value;
            [sheepModel setOper:'x'];
            break;
        // division case
        default:
            value = pickValue2;
            [sheepModel setOper:'/'];
            break;
    }
    
    valueString = [NSString stringWithFormat:@" %d", value];
    [sheepModel setValue:valueString];
    
}

// Given a node, this method does all the initilizations and communication necessary to create
// a fully functional sheep node
- (void) makeSheep:(SKNode *)node
{
    SheepModel* newSheepModel = [[SheepModel alloc] init];
    int generateNiceSheep = arc4random_uniform(3);
    if ([_mode isEqualToString:@"timed"]) {
        if (_currentScore < 5) {
            [newSheepModel scoreIsLow:true];
            [newSheepModel makeSheepFrom:0 to:100];
        } else {
            [newSheepModel makeSheepFrom:-100 to:100];
        }
    } else {
        if (generateNiceSheep == 0) {
            [newSheepModel makeSheepFrom:-100 to:100];
        } else {
            [self createTargetSheep:newSheepModel];
        }
        
    }
    
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