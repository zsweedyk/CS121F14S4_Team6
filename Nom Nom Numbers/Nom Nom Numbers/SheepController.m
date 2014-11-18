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
#import "Generator.h"

@implementation SheepController
{
    SKScene* _skScene;
    NSMutableArray* _arrOfSheepModel;
    SheepSprite* _sheepSprite;
    Generator* _generator;
    int _targetScore;
}

struct sheepObj
{
    __unsafe_unretained SheepModel* model;
    __unsafe_unretained SKNode* spriteNode;
};

typedef struct sheepObj sheepObj;

- (void) setupSheep:(SKScene*)mainScene {
    _sheepSprite = [[SheepSprite alloc] init];
    _skScene = mainScene;
    
    
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
        [newSheepNode setPosition:CGPointMake(880, newSheepNode.position.y)];
}

- (int)getTagetScore {
    _generator = [[Generator alloc] init];
    _targetScore = [_generator generateIntegerfrom:-100 to:100];
    return _targetScore;
}
@end
