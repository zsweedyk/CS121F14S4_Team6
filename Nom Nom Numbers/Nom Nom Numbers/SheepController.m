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
    
    
    SheepSprite* sheepSprite = [[SheepSprite alloc] init];
    _sheepSprite = sheepSprite;
    _arrOfSheepModel = [[NSMutableArray alloc] initWithCapacity:5];
    _skScene = mainScene;
    
    for (int i = 1; i < 6; i++) {
        
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheep];
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        
        SKNode *newSheep = [sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        //Sheep all have different names right now to show that they can be distinguished when clicked
        //Going to change them to all have the same name later on, and just use the userdata property
        //of SKNodes to distinguish values, operators, etc
        NSString* sheepName = @"sheep"; //[NSString stringWithFormat:@"sheep%d",i];
        newSheep.name = sheepName;
        
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
    //NSLog(@"count: %d", [_arrOfSheepModel count]);
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
    
    
        //[_skScene enumerateChildNodesWithName:@"sheep" usingBlock:^(SKNode *node, BOOL *stop)
        //SKNode* node = [_skScene childNodeWithName:@"sheep"];
    //{
            //if (node.position.x < -150){
                //int index = [self findSheepObjIndex:node];
                //NSLog(@"index: %d", index);
                //struct sheepObj sheepObject = [self findSheepObj:node];
                SheepModel* newSheepModel = [[SheepModel alloc] init];
                [newSheepModel makeSheep];
                NSString* value = [newSheepModel getValue];
                char oper = [newSheepModel getOperator];
                node = [_sheepSprite displayASheepWithValue:value andOper:oper atPos:CGPointMake(740, node.position.y)];
                node.name = @"sheep";
                //sheepObject.spriteNode = node;
                //sheepObject.model = newSheepModel;

                
                //[node setPosition:CGPointMake(740, node.position.y)];
                //[_skScene addChild:node];
            //}
      //  }];
    
    
    //Ideally we only have one of these that recognize the name "sheep" instead of "sheep(int)"
    //I only have the same code repeated so many times so that we can NSLog which sheep is clicked
    
//    [_skScene enumerateChildNodesWithName:@"sheep" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x < -150){
//            [node setPosition:CGPointMake(740, node.position.y)];
//        }
//    }];
//    [_skScene enumerateChildNodesWithName:@"sheep2" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x < -150){
//            [node setPosition:CGPointMake(740, node.position.y)];
//        }
//    }];
//    [_skScene enumerateChildNodesWithName:@"sheep3" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x < -150){
//            [node setPosition:CGPointMake(740, node.position.y)];
//        }
//    }];
//    [_skScene enumerateChildNodesWithName:@"sheep4" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x < -150){
//            [node setPosition:CGPointMake(740, node.position.y)];
//        }
//    }];
//    [_skScene enumerateChildNodesWithName:@"sheep5" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x < -150){
//            [node setPosition:CGPointMake(740, node.position.y)];
//        }
//    }];
}
@end
