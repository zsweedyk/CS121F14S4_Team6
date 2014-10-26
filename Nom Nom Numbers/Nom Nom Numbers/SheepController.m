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

@implementation SheepController : UIViewController {
    SKScene* _skScene;
    NSMutableArray* _arrOfSheepModel;
    SheepSprite* _sheepSprite;
}

struct sheepObj {
    __unsafe_unretained SheepModel* model;
    __unsafe_unretained SKNode* spriteNode;
    //__unsafe_unretained SheepSprite* sheepSprite;
};
typedef struct sheepObj sheepObj;

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
        
        SKNode *newSheepNode = [_sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        NSString* sheepName = @"sheep"; //[NSString stringWithFormat:@"sheep%d",i];
        newSheepNode.name = sheepName;
        

        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
        [dictionary setValue:value forKey:@"Value"];
        [dictionary setValue:operAsString forKey:@"Operator"];
        [newSheepNode setUserData:dictionary];
    
        [_skScene addChild:newSheepNode];
//        sheepObj sheepObject;
//        sheepObject.model = sheepModel;
//        sheepObject.spriteNode = newSheepNode;
//        NSValue* boxedSheepObject = [NSValue value:&sheepObject withObjCType:@encode(sheepObj)];
//        [_arrOfSheepModel addObject:boxedSheepObject];
        //[_arrOfSheepModel addObject:sheepModel];

    }
    
}

- (SheepModel*)findSheepObj:(SKNode *)node {
 
    NSValue *temp;
    sheepObj sheepObject;
    //NSLog(@"sheep count %d", [_arrOfSheepModel count]);
    for (int i = 0; i < [_arrOfSheepModel count]; i++) {
        temp = [_arrOfSheepModel objectAtIndex:i];
        [temp getValue:&sheepObject];
        if ([sheepObject.spriteNode isEqual: node]) {
            //NSLog(@"sheep found %@", [sheepObject.model getValue]);
            return sheepObject.model;
        }
    }
    
    NSLog(@"sheep not found");
    return sheepObject.model;
}

//- (NSString*)getSheepValue:(SKNode *)node {
//    
////    struct sheepObj sheepObject = [self findSheepObj:node];
////    SheepModel* model = [self findSheepObj:node];
////    return [model getValue];
//    
//}

//- (char)getSheepOper:(SKNode *)node {
//    
//    struct sheepObj sheepObject = [self findSheepObj:node];
//    
//    return [sheepObject.model getOperator];
//}

- (void)generateNewSheep:(SKNode*)node {
    
        SheepModel* newSheepModel = [[SheepModel alloc] init];
        [newSheepModel makeSheep];
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
        [newSheepNode setPosition:CGPointMake(740, newSheepNode.position.y)];
}
@end
