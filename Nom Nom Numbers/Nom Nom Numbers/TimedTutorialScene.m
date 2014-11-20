//
//  TimedTutorialScene.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/10/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "MainScene.h"
#import "TimedTutorialScene.h"
#import "SheepSprite.h"
#import "SheepModel.h"
#import "DataView.h"
#import "DataModel.h"
#import "SheepController.h"

@implementation TimedTutorialScene
{
    SKView* _skView;
    DataView* _dataView;
    DataModel* _dataModel;
    bool _firstTime;
    SheepController* _sheepController;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView
{
    
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    _skView = skView;
    _sheepController = [[SheepController alloc] init];
    _firstTime = YES; //varialbe indicating the first time sheep are off-screen
    
    [self setup];
    return self;
}

- (void) setup
{
    
    [self setupBackground];
    [self setupDragon];
    
    // add Quit button on the top-right
    SKLabelNode* quit = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quit.fontSize = 40;
    quit.fontColor = [UIColor whiteColor];
    quit.position = CGPointMake(self.size.width * 0.8, self.size.height * 0.93);
    quit.text = @"Quit";
    quit.name = @"quit";
    [self addChild:quit];
    
    [self startGame];
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

- (void) startGame
{
    
    CGFloat sceneX = self.size.width;
    CGFloat sceneY = self.size.height;
    
    // Create popup to start the game
    SKSpriteNode* startPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    startPopup.size = CGSizeMake(sceneX * 0.42, sceneY * 0.4);
    startPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    startPopup.name = @"startpopup";
    startPopup.zPosition = 2;
    [self addChild:startPopup];
    
    CGFloat popupX = startPopup.size.width;
    CGFloat popupY = startPopup.size.height;
    
    // Create title label on the popup
    SKLabelNode* startPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupTitle.fontColor = [UIColor whiteColor];
    startPopupTitle.fontSize = 30;
    startPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupTitle.position = CGPointMake(0, popupY * 0.35);
    startPopupTitle.text = @"Welcome to timed mode tutorial!";
    [startPopup addChild:startPopupTitle];
    
    // Create title label for dragon description
    SKLabelNode* startPopupDragon1 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupDragon1.fontColor = [UIColor whiteColor];
    startPopupDragon1.fontSize = 18;
    startPopupDragon1.position = CGPointMake(0, popupY * 0.15);
    startPopupDragon1.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupDragon1.text = [NSString stringWithFormat:@"You are a hungry dragon waiting to eat sheep."];
    [startPopup addChild:startPopupDragon1];
    
    SKLabelNode* startPopupDragon2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupDragon2.fontColor = [UIColor whiteColor];
    startPopupDragon2.fontSize = 18;
    startPopupDragon2.position = CGPointMake(0, popupY * 0.09);
    startPopupDragon2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupDragon2.text = [NSString stringWithFormat:@"However, you need to pick right sheep to eat."];
    [startPopup addChild:startPopupDragon2];
    
    SKLabelNode* startPopupDragon3 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupDragon3.fontColor = [UIColor whiteColor];
    startPopupDragon3.fontSize = 18;
    startPopupDragon3.position = CGPointMake(0, popupY * 3);
    startPopupDragon3.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupDragon3.text = [NSString stringWithFormat:@"Your score will update based on the sheep you click on."];
    [startPopup addChild:startPopupDragon3];
    
    // Ask the user to click on a sheep
    SKLabelNode* startPopupClick = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupClick.fontColor = [UIColor blueColor];
    startPopupClick.fontSize = 25;
    startPopupClick.position = CGPointMake(0, popupY*(-0.05));
    startPopupClick.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupClick.text = [NSString stringWithFormat:@"Please click on a sheep to learn how"];
    [startPopup addChild:startPopupClick];
    
    SKLabelNode* startPopupClick2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startPopupClick2.fontColor = [UIColor blueColor];
    startPopupClick2.fontSize = 25;
    startPopupClick2.position = CGPointMake(0, popupY*(-0.12));
    startPopupClick2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startPopupClick2.text = [NSString stringWithFormat:@" your score changes accordingly."];
    [startPopup addChild:startPopupClick2];
    
    // Create confirmation button (start the game)
    SKSpriteNode* startButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
    startButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    startButton.position = CGPointMake(0, popupY * -0.35);
    [startPopup addChild:startButton];
    
    SKLabelNode* startButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    startButtonLabel.fontColor = [UIColor whiteColor];
    startButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    startButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    startButtonLabel.text = @"Start";
    startButtonLabel.name = @"startaction";
    [startButton addChild:startButtonLabel];

}


- (void) setupSheep
{
    // Add sheep to the tutorial screen
    SheepSprite* _sheepSprite = [[SheepSprite alloc] init];
    for (int i = 1; i < 6; i++) {
        SheepModel* sheepModel = [[SheepModel alloc] init];
        [sheepModel makeSheepFrom:-100 to:100];
        
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


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqual: @"sheep"]) {
        
        // if clicking on a sheep
        node.name = @"sheep1";
        
        // get the operator and value of the sheep, and store the original and updated scores
        NSMutableDictionary* sheepData = node.userData;
        char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
        NSString* sheepValue = [sheepData objectForKey:@"Value"];
        double _originalScore = [_dataModel getScore];
        [_dataModel applySheepChar:sheepOper andValue:sheepValue];
        double _currentScore = [_dataModel getScore];
        
        // setup popup explaining how score changes
        SKLabelNode* popup = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        popup.fontSize = 35;
        popup.fontColor = [UIColor whiteColor];
        popup.position = CGPointMake(500,140);
        NSString* title = [NSString stringWithFormat:@"the score is updated to: "];
        popup.text = title;
        popup.name = @"popup";
        [node addChild:popup];
        
        SKLabelNode* popup2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        popup2.fontSize = 35;
        popup2.fontColor = [UIColor whiteColor];
        popup2.position = CGPointMake(500,100);
        NSString* title2 = [NSString stringWithFormat:@"%.2f %c %@ = %.2f", _originalScore, sheepOper, sheepValue, _currentScore];
        popup2.text = title2;
        popup2.name = @"popup2";
        [node addChild:popup2];
        
        // pause all animation for 5 seconds
        SKAction *stop = [SKAction speedTo:0 duration:0];
        SKAction *wait = [SKAction speedTo:0 duration:2];
        SKAction *run = [SKAction speedTo:1 duration:0];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *disappear = [SKAction runAction:remove onChildWithName:@"sheep1"];
        [self runAction:[SKAction sequence:@[stop, wait, disappear, run]]];
        
        [self addChild:[self newScoreNode:node]];
        CGFloat Xdimensions = self.size.width;
        CGFloat Ydimensions = self.size.height;
        
        // create newScore label for score animation
        CGFloat scoreY = Ydimensions * 0.93;
        CGFloat scoreX = Xdimensions * 0.02;
        
        SKNode* scoreNode = [self childNodeWithName:@"scoreNode"];
        
        // score animation
        if (scoreNode != nil) {
            scoreNode.name = nil;
            
            SKAction* zoom = [SKAction scaleTo: 2.0 duration: 0.1];
            SKAction* move = [SKAction moveTo:(CGPointMake(scoreX+150, scoreY-50)) duration:0.5];
            SKAction* pause = [SKAction waitForDuration: 0.25];
            SKAction* fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction* remove = [SKAction removeFromParent];
            SKAction* moveSequence = [SKAction sequence:@[zoom, move, pause, fadeAway, remove]];
            
            [scoreNode runAction: moveSequence completion:^{
                [_dataView updateScore:_currentScore];
            }];
        }
        
    } else if ([node.name isEqual: @"startgame"] || [node.name isEqual: @"quit"]) {
        
        // if finishing the game and clicking 'Start' button or quit the tutorial
        SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init] andMode:@"timed"];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
        
    } else if ([node.name isEqual: @"startaction"]) {
        
        // if clicking 'Start' to start the tutorial
        _dataModel = [DataModel alloc];
        _dataView = [[DataView alloc] init];
        [_dataView setupData:self withScore:0 andMode:@"timed" andModel:_dataModel andSheepController:_sheepController];
        [self addChild:_dataView];
        [[self childNodeWithName:@"startpopup"] removeFromParent];
        [self setupSheep];
    }

}

- (SKLabelNode *) newScoreNode:(SKNode*) node
{
    SKLabelNode* scoreNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
    
    NSMutableDictionary* sheepData = node.userData;
    char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
    NSString* sheepValue = [sheepData objectForKey:@"Value"];
    
    NSString *oper = [NSString stringWithFormat:@"%c",sheepOper];
    NSString* myString=[NSString stringWithFormat:@"%@%@",oper,sheepValue];
    
    // If sheep value was a fraction, only display fraction part since displaying decimal
    // portion as well will get too cramped
    NSCharacterSet* parens = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSRange searchRange = NSMakeRange(0, myString.length);
    NSRange foundRange = [myString rangeOfCharacterFromSet:parens options:0 range:searchRange];
    
    // Check if there are parentheses (the value is a fraction that contains its decimal counterpart
    if (foundRange.location != NSNotFound){
        NSRange range = [myString rangeOfString:@"("];
        NSString* shortString = [myString substringToIndex:range.location];
        scoreNode.text = shortString;
        
    } else {
        scoreNode.text = myString;
    }
    
    // Set color to be off-white so text is visible even with sheep passing by
    scoreNode.fontColor = [UIColor colorWithRed:235/255.0f green:200/255.0f blue:150/255.0f alpha:1.0f];
    scoreNode.fontSize = 45;
    
    scoreNode.position = CGPointMake(node.position.x+200, node.position.y);
    scoreNode.name = @"scoreNode";
    
    return scoreNode;
}


- (void) update:(NSTimeInterval)currentTime
{
    
    if (_firstTime == YES) {
        __block _Bool flag1 = TRUE; // detect if sheep are all off screen
        __block _Bool flag2 = FALSE; // detect if sheep objects exist
        
        [self enumerateChildNodesWithName:@"sheep" usingBlock:^(SKNode *node, BOOL *stop) {
            
            // sheep nodes exist
            flag2 = TRUE;
            // If at least one sheep is on screen, flag1 is FALSE
            if (node.position.x > -150) {
                flag1 = FALSE;
            }
        }];
        
        if ((flag1 == TRUE) && (flag2 == TRUE)) {
            _firstTime = NO;
            [self tutorialEnds];
        }
    }
}

- (void) tutorialEnds
{
    [_dataView stopTimer];
    CGFloat sceneX = self.size.width;
    CGFloat sceneY = self.size.height;
    
    // Create popup backlay
    UIColor* transparentColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    SKSpriteNode* gameOverBacklay = [[SKSpriteNode alloc] initWithColor:transparentColor size:CGSizeMake(sceneX, sceneY)];
    gameOverBacklay.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    gameOverBacklay.zPosition = 2;
    [self addChild:gameOverBacklay];
    
    // Create popup
    SKSpriteNode* quitPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    quitPopup.size = CGSizeMake(sceneX * 0.38, sceneY * 0.3);
    quitPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    
    SKSpriteNode* shadow = [[SKSpriteNode alloc] initWithImageNamed:@"popupShadow"];
    shadow.size = CGSizeMake(quitPopup.size.width * 1.1, quitPopup.size.height * 1.1);
    shadow.position = CGPointMake(quitPopup.position.x, quitPopup.position.y - 5);
    shadow.alpha = 0.5;
    quitPopup.zPosition = 2;
    
    [self addChild:shadow];
    [self addChild:quitPopup];
    
    CGFloat popupX = quitPopup.size.width;
    CGFloat popupY = quitPopup.size.height;
    
    // Create title label on the popup
    SKLabelNode* quitPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupTitle.fontColor = [UIColor whiteColor];
    quitPopupTitle.fontSize = 30;
    quitPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupTitle.position = CGPointMake(0, popupY * 0.35);
    quitPopupTitle.text = @"You finished the tutorial!";
    [quitPopup addChild:quitPopupTitle];
    
    // Create content text on the popup
    SKLabelNode* quitPopupText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupText.fontColor = [UIColor blueColor];
    quitPopupText.fontSize = 25;
    quitPopupText.position = CGPointMake(0, popupY * 0.10);
    quitPopupText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupText.text = [NSString stringWithFormat:@"Your goal is to maximize the score!"];
    [quitPopup addChild:quitPopupText];
    
    SKLabelNode* quitPopupTextTime = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupTextTime.fontColor = [UIColor blueColor];
    quitPopupTextTime.fontSize = 25;
    quitPopupTextTime.position = CGPointMake(0, popupY * -0.05);
    quitPopupTextTime.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupTextTime.text = [NSString stringWithFormat:@"You have 1 minute to go!"];
    [quitPopup addChild:quitPopupTextTime];
    
    // Create confirmation button (start timed mode) on popup
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
    quitButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    quitButton.position = CGPointMake(0, popupY * -0.35);
    quitButton.name = @"startgame";
    [quitPopup addChild:quitButton];
    
    // Create the label on the confirmation button
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButtonLabel.fontColor = [UIColor whiteColor];
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitButtonLabel.text = @"Start";
    quitButtonLabel.name = @"startgame";
    [quitButton addChild:quitButtonLabel];

}

@end
