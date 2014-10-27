//
//  MainScene.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "MainScene.h"
#import "SheepSprite.h"
#import "SheepController.h"
#import "DataView.h"
#import "DataModel.h"

@implementation MainScene {
    SKView* _skView;
    SheepController* _sheepController;
    DataView* _dataView;
    DataModel* _dataModel;
    double _currentScore;
    BOOL _gameEnded;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView {
    _skView = skView;
    _sheepController = [[SheepController alloc] init];
    _gameEnded = false;
    if (self = [super initWithSize:size]) {
        [self setup];
    }
    
    return self;
}

-(void) setup {
    [self setupBackground];
    [self setupDragon];
    [self setupData];
    [_sheepController setupSheep:self];
}

-(void) setupBackground {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
}

-(void) setupDragon {
    SKSpriteNode *dragon = [SKSpriteNode spriteNodeWithImageNamed:@"barnAndDragon"];
    CGSize barnSize = [UIImage imageNamed:@"barnAndDragon"].size;
    dragon.position = CGPointMake(self.size.width - barnSize.width*0.5, 0);
    dragon.anchorPoint = CGPointZero;
    dragon.xScale = .5;
    dragon.yScale = .5;
    dragon.zPosition = 2;
    [self addChild:dragon];
}

- (void) setupData {
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] init];
    [_dataView setupData:self withScore:_currentScore];
    _dataView.customDelegate = self;
    [self addChild:_dataView];
    
//    // Create Quit button
    SKLabelNode* quitButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButton.fontSize = 45;
    quitButton.fontColor = [UIColor whiteColor];
    quitButton.position = CGPointMake(self.size.width * 0.8, self.size.height * 0.93);
    quitButton.text = @"Quit";
    quitButton.name = @"quitbutton";
    [self addChild:quitButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqual: @"sheep"]) {
        [_sheepController generateNewSheep:node];
        NSMutableDictionary* sheepData = node.userData;
        char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
        NSString* sheepValue = [sheepData objectForKey:@"Value"];
        NSLog(@"Sheep tapped with value: %@, operation: %c", sheepValue, sheepOper);
        [_dataModel applySheepChar:sheepOper andValue:sheepValue];
        _currentScore = [_dataModel getScore];
        [_dataView updateScore:_currentScore];
        
    } else if ([node.name isEqual:@"quitbutton"]) {
        NSLog(@"hurlo");
        [self quitGame];
    }
 
}

- (void)update:(NSTimeInterval)currentTime {
    
        [self enumerateChildNodesWithName:@"sheep" usingBlock:^(SKNode *node, BOOL *stop) {
            if (node.position.x < -150){
                [_sheepController generateNewSheep:node];
            }
            if (_gameEnded) {
                [node removeFromParent];
            }
        }];

}

// Delegate Function: Shows result when game is over
- (void) showGameResults:(DataView *)controller
{
    _gameEnded = true;
    // Create a UIAlert to show score
    NSString* alertTitle = @"Time's up!";
    NSString* gameResult = [NSString stringWithFormat:@"Your score was %.3f", _currentScore];
    
    UIAlertView *finishedGameResult = [[UIAlertView alloc]
                                       initWithTitle: alertTitle
                                       message: gameResult
                                       delegate: self
                                       cancelButtonTitle: @"OK"
                                       otherButtonTitles: nil];
    [finishedGameResult show];
}

- (void) quitGame
{
    
    _gameEnded = true;
    // Create a UIAlert to show score
    NSString* alertTitle = @"You quit the game!";
    NSString* gameResult = [NSString stringWithFormat:@"Your score was %.3f", _currentScore];
    
    UIAlertView *quitGameAlert = [[UIAlertView alloc]
                                  initWithTitle: alertTitle
                                  message: gameResult
                                  delegate: self
                                  cancelButtonTitle: @"OK"
                                  otherButtonTitles: nil];
    [_dataView stopTimer];
    [quitGameAlert show];
}



@end
