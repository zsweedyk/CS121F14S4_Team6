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

@implementation SheepController
{
    SKScene* skScene;
    NSMutableArray* arrOfSheepModel;
    SheepSprite* sheepSprite;
}

struct sheepObj
{
    __unsafe_unretained SheepModel* model;
    __unsafe_unretained SKNode* spriteNode;
};

typedef struct sheepObj sheepObj;

- (void) setupSheep:(SKScene*)mainScene {
    sheepSprite = [[SheepSprite alloc] init];
    arrOfSheepModel = [[NSMutableArray alloc] initWithCapacity:5];
    arrOfSounds = [NSMutableArray new];
    skScene = mainScene;
    
    for (int i = 1; i < 6; i++) {
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheep];
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        
        SKNode *newSheepNode = [sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        NSString* sheepName = @"sheep"; //[NSString stringWithFormat:@"sheep%d",i];
        newSheepNode.name = sheepName;

        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
        [dictionary setValue:value forKey:@"Value"];
        [dictionary setValue:operAsString forKey:@"Operator"];
        [newSheepNode setUserData:dictionary];
    
        [skScene addChild:newSheepNode];
    }
    
    [self playSheepNoise:self];
}


- (void) generateNewSheep:(SKNode*)node
{
    SheepModel* newSheepModel = [[SheepModel alloc] init];
    [newSheepModel makeSheep];
    NSString* value = [newSheepModel getValue];
    char oper = [newSheepModel getOperator];
    
    SKNode *newSheepNode = [sheepSprite createSheepWithValue:value andOper:oper atPos:node.position];
    newSheepNode.name = @"sheep";
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
    [dictionary setValue:value forKey:@"Value"];
    [dictionary setValue:operAsString forKey:@"Operator"];
    [newSheepNode setUserData:dictionary];
    
    [node removeFromParent];
    [skScene addChild:newSheepNode];
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

@end
