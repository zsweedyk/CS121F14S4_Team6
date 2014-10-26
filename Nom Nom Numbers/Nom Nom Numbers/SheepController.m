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

@implementation SheepController {
    SKScene* _skScene;
    NSMutableArray* _arrOfSheepModel;
    SheepSprite* _sheepSprite;
}

struct sheepObj {
    __unsafe_unretained SheepModel* model;
    __unsafe_unretained SKNode* spriteNode;
};

- (void)setupSheep:(SKScene*)mainScene {
    
    
    _sheepSprite = [[SheepSprite alloc] init];
    //_sheepSprite = sheepSprite;
    _arrOfSheepModel = [[NSMutableArray alloc] initWithCapacity:5];
    _skScene = mainScene;
    
    for (int i = 1; i < 6; i++) {
        
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheep];
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        
        SKNode *newSheep = [_sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        NSString* sheepName = @"sheep"; //[NSString stringWithFormat:@"sheep%d",i];
        newSheep.name = sheepName;
        
        NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setValue:value forKey:@"Value"];
        [dictionary setValue:operAsString forKey:@"Operator"];
        [newSheep setUserData:dictionary];
        
        struct sheepObj sheepObject;
        sheepObject.model = sheepModel;
        sheepObject.spriteNode = newSheep;
        NSValue* boxedSheepObject = [NSValue valueWithBytes:&sheepObject objCType:@encode(struct sheepObj)];
        [_arrOfSheepModel addObject:boxedSheepObject];
        [_skScene addChild:newSheep];
    }
    
}

- (struct sheepObj)findSheepObj:(SKNode *)node {
 
    NSValue *temp;
    struct sheepObj sheepObject;
    for (int i = 0; i < [_arrOfSheepModel count]; i++) {
        temp = [_arrOfSheepModel objectAtIndex:i];
        [temp getValue:&sheepObject];
        if ([sheepObject.spriteNode isEqual: node]) {
            return sheepObject;
        }
    }
    
    return sheepObject;
}

- (void)generateNewSheep:(SKNode*)node {
    
        SheepModel* newSheepModel = [[SheepModel alloc] init];
        [newSheepModel makeSheep];
        NSString* value = [newSheepModel getValue];
        char oper = [newSheepModel getOperator];
    
        SKNode *newSheep = [_sheepSprite createSheepWithValue:value andOper:oper atPos:node.position];
        newSheep.name = @"sheep";

        [node removeFromParent];
        [_skScene addChild:newSheep];
        [newSheep setPosition:CGPointMake(740, newSheep.position.y)];
}
@end
