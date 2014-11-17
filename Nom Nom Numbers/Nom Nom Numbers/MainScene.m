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
#import "QuitGameButton.h"
#import "GameOverButton.h"
#import "StartScene.h"

@implementation MainScene
{
    SKView* _skView;
    SheepController* _sheepController;
    DataView* _dataView;
    DataModel* _dataModel;
    double _currentScore;
    BOOL _gameEnded;
    GameOverButton* gameOverPopup;
    NSString* _mode;
}

- (id) initWithSize:(CGSize)size andSKView:(SKView*)skView andMode:(NSString*)mode
{
    _mode = mode;
    _skView = skView;
    _gameEnded = false;
    
   
    self = [super initWithSize:size];
    [self setup];

    
    return self;
}

- (void) setup
{
    [self setupBackground];
    [self setupDragon];
    
    _sheepController = [[SheepController alloc] init];
    [_sheepController setupSheep:self];

    
    [self setupData];

}

- (void) restart
{
    _gameEnded = false;
    [_dataModel resetScore];
    _currentScore = 0;
    [_dataView updateScore:[_dataModel getScore]];
    [_dataView resetTimer];
    [gameOverPopup removeFromParent];
    [_sheepController setupSheep:self];
}

- (void) setupBackground
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
}

- (void) setupDragon
{
    SKSpriteNode *dragon = [SKSpriteNode spriteNodeWithImageNamed:@"barnAndDragon"];
    CGSize barnSize = [UIImage imageNamed:@"barnAndDragon"].size;
    dragon.position = CGPointMake(self.size.width - barnSize.width*0.5, 0);
    dragon.anchorPoint = CGPointZero;
    dragon.xScale = .5;
    dragon.yScale = .5;
    dragon.zPosition = 2;
    [self addChild:dragon];
}

- (void) setupData
{

        // Create DataModel
        _dataModel = [DataModel alloc];
        _currentScore = [_dataModel getScore];
        
        // Create DataView
        _dataView = [[DataView alloc] init];
        [_dataView setupData:self withScore:_currentScore andMode:_mode andModel:_dataModel];
        _dataView.customDelegate = self;
        [self addChild:_dataView];
        
        // Create Quit button
        SKLabelNode* quitButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        quitButton.fontSize = 45;
        quitButton.fontColor = [UIColor whiteColor];
        quitButton.position = CGPointMake(self.size.width * 0.8, self.size.height * 0.93);
        quitButton.text = @"Quit";
        quitButton.name = @"quitbutton";
        quitButton.zPosition = 2;
        [self addChild:quitButton];

    if ([_mode isEqualToString:@"target"]) {
        SKLabelNode* targetButton = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        targetButton.fontSize = 45;
        targetButton.fontColor = [UIColor whiteColor];
        targetButton.position = CGPointMake(self.size.width*.35, self.size.height * .93);
        targetButton.text = @"Hit Me!";
        targetButton.name = @"targetbutton";
        targetButton.zPosition = 2;
        [self addChild:targetButton];
    }
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    NSLog(@"touched with %@", node.name);
    if ([node.name isEqual: @"sheep"]) {
        NSLog(@"sheep tapped");
        [_sheepController generateNewSheep:node];
        NSMutableDictionary* sheepData = node.userData;
        char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
        NSString* sheepValue = [sheepData objectForKey:@"Value"];
        
        [_dataModel applySheepChar:sheepOper andValue:sheepValue];
        _currentScore = [_dataModel getScore];
        [_dataView updateScore:_currentScore];
        
    } else if ([node.name isEqual:@"quitbutton"]) {
        NSLog(@"hurlo");
        //[_sheepController removeFromParentViewController];
        [self quitGame];
    
    } else if ([node.name isEqual:@"quitaction"]) {
        // BACK TO MAIN SCREEN
        SKScene *startScene = [[StartScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:startScene transition:transition];
    } else if ([node.name isEqual:@"playagainaction"]) {
        // PLAY AGAIN
        NSLog(@"RestartGameWHEE!");
        [self restart];
    } else if ([node.name isEqual:@"targetbutton"]) {
        NSLog(@"target button clicked");
        [self showGameResults:_dataView];
        
    }
}

- (void) update:(NSTimeInterval)currentTime
{
        [self enumerateChildNodesWithName:@"sheep"
              usingBlock:^(SKNode *node, BOOL *stop) {
            
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
    [_dataView stopTimer];
    
    // Create the Game Over popup
    gameOverPopup = [[GameOverButton alloc] init];
    double score;
    if ([_mode isEqualToString:@"target"]) {
        double time = [_dataView getCurrentTime];
        //calculate difference in score
        int targetScore = [_dataModel getTargetScore];
        double diff = abs(_currentScore - targetScore);
        //calculate percentage off of target score that current score is
        score = (targetScore - diff)/targetScore;
        
        //prevent divide by 0
        if (time == 0) {
            time = 1;
        }
        NSLog(@"1/time) * score * 100 = %f * %f * 100", (1/time), score);
        //reward a faster time
        score = (1/time) * score * 100;
        if (score < 0) {
            score = 0;
        }
        
    } else {
        score = _currentScore;
    }
    [gameOverPopup setupData:self withScore:score];
    [self addChild: gameOverPopup];
}

- (void) quitGame
{
    _gameEnded = true;
    [_dataView stopTimer];
    
    // Create the Quit popup
    QuitGameButton* quitPopup = [[QuitGameButton alloc] init];

    [quitPopup setupData:self withScore:_currentScore];
    [self addChild:quitPopup];
}


@end
