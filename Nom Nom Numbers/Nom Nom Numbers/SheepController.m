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

}



- (void) setupSheep:(SKScene*)mainScene {

    _sheepSprite = [[SheepSprite alloc] init];
    _skScene = mainScene;
    arrOfSounds = [NSMutableArray new];

    
    
    for (int i = 1; i < 6; i++) {
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheepFrom: -100 to: 100];
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        

        SKNode *newSheepNode = [_sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        newSheepNode.name = @"sheep";


        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
        [dictionary setValue:value forKey:@"Value"];
        [dictionary setValue:operAsString forKey:@"Operator"];
        [newSheepNode setUserData:dictionary];
        
        [_skScene addChild:newSheepNode];
        newSheepNode.zPosition = 1.0;
        [self playSheepNoise:self];

    }
    
    
}


- (void) generateNewSheep:(SKNode*)node
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
    
    [node removeFromParent];
    [_skScene addChild:newSheepNode];
    [self playSheepNoise:self];
    [newSheepNode setPosition:CGPointMake(880, newSheepNode.position.y)];
}

- (IBAction)playSheepNoise:(id)sender
{
    NSString* fileName = @"Sheep";
    int randomValue = arc4random_uniform(2);
    
    if (randomValue == 1) {
        fileName = @"Sheep2";
    }
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [arrOfSounds addObject:newPlayer];
    newPlayer.volume = 0.5;
    [newPlayer prepareToPlay];
    [newPlayer play];
}


- (int)getTagetScore {
    _generator = [[Generator alloc] init];
    _targetScore = [_generator generateIntegerfrom:-100 to:100];
    NSLog(@"sheep controller target score: %d", _targetScore);
    return _targetScore;
}
@end
