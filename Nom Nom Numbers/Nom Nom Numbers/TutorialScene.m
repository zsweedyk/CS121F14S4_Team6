//
//  TutorialScene.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/10/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "TutorialScene.h"
#import "SheepSprite.h"
#import "SheepModel.h"
#import "DataView.h"
#import "DataModel.h"

@implementation TutorialScene {
    SKView* _skView;
    DataView* _dataView;
    DataModel* _dataModel;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView {
    
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    
    _skView = skView;
    [self setup];
    
    return self;
}

- (void)setup {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    SKLabelNode* title = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    title.fontSize = 40;
    title.fontColor = [UIColor whiteColor];
    title.position = CGPointMake(self.size.width * 0.8, self.size.height * 0.93);
    title.text = @"Tutorial";
    title.name = @"title";
    [self addChild:title];
    
    SKLabelNode* title2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    title2.fontSize = 40;
    title2.fontColor = [UIColor whiteColor];
    title2.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.7);
    title2.text = @"Please click on a sheep";
    title2.name = @"title2";
    [self addChild:title2];

    _dataModel = [DataModel alloc];

    _dataView = [[DataView alloc] init];
    [_dataView setupData:self withScore:0];
    [self addChild:_dataView];
    
    [self setupSheep];
}


- (void) setupSheep{
    SheepSprite* _sheepSprite = [[SheepSprite alloc] init];
    
    for (int i = 1; i < 6; i++) {
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheep];
        
        
        NSString* sheepName = @"sheep";
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        
        SKNode *newSheepNode = [_sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(740, i*100 - 40)];
        
        newSheepNode.name = sheepName;
        
        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        NSString* operAsString = [NSString stringWithFormat:@"%c",oper];
        [dictionary setValue:value forKey:@"Value"];
        [dictionary setValue:operAsString forKey:@"Operator"];
        [newSheepNode setUserData:dictionary];
        
        [self addChild:newSheepNode];
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqual: @"sheep"]) {

        NSMutableDictionary* sheepData = node.userData;
        char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
        NSString* sheepValue = [sheepData objectForKey:@"Value"];
        
        [_dataModel applySheepChar:sheepOper andValue:sheepValue];
        
        double _currentScore = [_dataModel getScore];
        [_dataView updateScore:_currentScore];
        
        SKSpriteNode* sheepSpriteNode = (SKSpriteNode*) node;
        sheepSpriteNode.parent.speed = 0;
        
        SKLabelNode* popup = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        popup.fontSize = 20;
        popup.fontColor = [UIColor whiteColor];
        popup.position = CGPointMake(node.position.x, node.position.y + (sheepSpriteNode.size.height));
        
        NSString* title = [NSString stringWithFormat:@"the updated score: %d %c %@ = %.2f", 0, sheepOper, sheepValue, _currentScore];
        popup.text = title;
        popup.name = @"popup";
        [self addChild:popup];
        
    }

}

@end
