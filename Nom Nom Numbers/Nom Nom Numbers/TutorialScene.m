//
//  TutorialScene.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 12/7/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//



#import "TutorialScene.h"
#import "MainScene.h"
#import "SheepSprite.h"
#import "SheepModel.h"
#import "DataView.h"
#import "DataModel.h"
#import "SheepController.h"
#import "StartScene.h"

@implementation TutorialScene
{
    DataView* _dataView;
    DataModel* _dataModel;
    bool _firstTime;
    bool _click;
    NSString* _mode;
    NSString* _origin;
    SheepController* _sheepController;
}

-(id)initWithSize:(CGSize)size andSKView:(SKView*)skView andMode:(NSString *)mode andOrigin:(NSString *)origin
{
    
    self = [super initWithSize:size];
    _sheepController = [[SheepController alloc] init];
    _firstTime = YES; // varialbe indicating the first time sheep are off-screen
    _click = NO;
    _mode = mode; // variable indicating which mode the tutorial should launch for
    _origin = origin; // variable indicating how the tutorial is evoked
    [self setup];
    return self;
}

- (void) setup
{
    
    [self setupBackground];
    [self setupDragon];
    
    // Create Quit button
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"redButton"];
    quitButton.size = CGSizeMake(120, 60);
    quitButton.position = CGPointMake(self.size.width * 0.92, self.size.height * 0.95);
    quitButton.name = @"quit";
    quitButton.zPosition = 2;
    [self addChild:quitButton];
    
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButtonLabel.fontSize = 45;
    quitButtonLabel.fontColor = [UIColor whiteColor];
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitButtonLabel.text = @"Quit";
    quitButtonLabel.name = @"quit";
    [quitButton addChild:quitButtonLabel];
    
    [self startGame];
}

- (void) setupBackground
{
    // Set up background picture for the tutorial scene
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    SKSpriteNode* barn = [SKSpriteNode spriteNodeWithImageNamed:@"barnHorizontal"];
    CGSize barnSize = [UIImage imageNamed:@"barnHorizontal"].size;
    barn.position = CGPointMake(0, (background.size.height - barnSize.height*.5));
    barn.anchorPoint = CGPointZero;
    barn.xScale = .5;
    barn.yScale = .5;
    barn.zPosition = 2;
    [self addChild:barn];
    
}

- (void) setupDragon
{
    // Set up dragon image on the tutorial scene
    SKSpriteNode* dragon = [SKSpriteNode spriteNodeWithImageNamed:@"dragon"];
    CGSize dragonSize = [UIImage imageNamed:@"dragon"].size;
    CGSize screenSize = self.size;
    dragon.position = CGPointMake(screenSize.width - dragonSize.width*0.5 + 50,
                                  screenSize.height*0.5 - dragonSize.height*0.25);
    dragon.anchorPoint = CGPointZero;
    dragon.xScale = .5;
    dragon.yScale = .5;
    dragon.zPosition = 2;
    
    [self addChild:dragon];
    
    SKSpriteNode* dragon2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueDragon"];
    dragon2.position = CGPointZero;
    dragon2.anchorPoint = CGPointZero;
    dragon2.xScale = .5;
    dragon2.yScale = .5;
    dragon2.zPosition = 2;
    
    [self addChild:dragon2];
}

- (void) startGame
{
    
    CGFloat sceneX = self.size.width;
    CGFloat sceneY = self.size.height;
    
    // Create popup to start the game
    SKSpriteNode* startPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    if ([_mode isEqualToString:@"target"]) {
        startPopup.size = CGSizeMake(sceneX * 0.48, sceneY * 0.45);
    } else {
        startPopup.size = CGSizeMake(sceneX * 0.42, sceneY * 0.4);
    }
    
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
    startPopupTitle.text = [NSString stringWithFormat:@"Welcome to %@ mode tutorial!", _mode];
    [startPopup addChild:startPopupTitle];
    
    if ([_mode isEqualToString:@"target"]) {
        
        // Create title label for dragon description
        SKLabelNode* startPopupDragon1 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupDragon1.fontColor = [UIColor whiteColor];
        startPopupDragon1.fontSize = 18;
        startPopupDragon1.position = CGPointMake(0, popupY * 0.15);
        startPopupDragon1.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupDragon1.text = [NSString stringWithFormat:@"Now you have a target value to reach."];
        [startPopup addChild:startPopupDragon1];
        
        SKLabelNode* startPopupDragon2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupDragon2.fontColor = [UIColor whiteColor];
        startPopupDragon2.fontSize = 18;
        startPopupDragon2.position = CGPointMake(0, popupY * 0.05);
        startPopupDragon2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupDragon2.text = [NSString stringWithFormat:@"Your final point will be based on the difference between "];
        [startPopup addChild:startPopupDragon2];
        
        // Ask the user to click on a sheep
        SKLabelNode* startPopupDragon3 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupDragon3.fontColor = [UIColor whiteColor];
        startPopupDragon3.fontSize = 18;
        startPopupDragon3.position = CGPointMake(0, popupY * 0.01);
        startPopupDragon3.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupDragon3.text = [NSString stringWithFormat:@"your score and the target value, and the time you have spent."];
        [startPopup addChild:startPopupDragon3];
        
        SKLabelNode* startPopupClick = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupClick.fontColor = [UIColor blueColor];
        startPopupClick.fontSize = 25;
        startPopupClick.position = CGPointMake(0, popupY*(-0.13));
        startPopupClick.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupClick.text = [NSString stringWithFormat:@"Please tap on a sheep to learn how"];
        [startPopup addChild:startPopupClick];
        
        SKLabelNode* startPopupClick2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupClick2.fontColor = [UIColor blueColor];
        startPopupClick2.fontSize = 25;
        startPopupClick2.position = CGPointMake(0, popupY*(-0.20));
        startPopupClick2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupClick2.text = [NSString stringWithFormat:@"your score changes accordingly."];
        [startPopup addChild:startPopupClick2];
        
    } else {
        
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
        startPopupDragon2.text = [NSString stringWithFormat:@"However, you need to pick the right sheep to eat."];
        [startPopup addChild:startPopupDragon2];
        
        SKLabelNode* startPopupDragon3 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupDragon3.fontColor = [UIColor whiteColor];
        startPopupDragon3.fontSize = 18;
        startPopupDragon3.position = CGPointMake(0, popupY * 3);
        startPopupDragon3.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupDragon3.text = [NSString stringWithFormat:@"Your score will update based on the sheep you tap on."];
        [startPopup addChild:startPopupDragon3];
        
        // Ask the user to click on a sheep
        SKLabelNode* startPopupClick = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupClick.fontColor = [UIColor blueColor];
        startPopupClick.fontSize = 25;
        startPopupClick.position = CGPointMake(0, popupY*(-0.05));
        startPopupClick.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupClick.text = [NSString stringWithFormat:@"Please tap on a sheep to learn how"];
        [startPopup addChild:startPopupClick];
        
        SKLabelNode* startPopupClick2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        startPopupClick2.fontColor = [UIColor blueColor];
        startPopupClick2.fontSize = 25;
        startPopupClick2.position = CGPointMake(0, popupY*(-0.12));
        startPopupClick2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        startPopupClick2.text = [NSString stringWithFormat:@" your score changes accordingly."];
        [startPopup addChild:startPopupClick2];
    }
    
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
        
        NSString* value = [sheepModel getValue];
        char oper = [sheepModel getOperator];
        
        SKNode *newSheepNode = [_sheepSprite createSheepWithValue:value andOper:oper atPos:CGPointMake(i*110+200, 30)];
        newSheepNode.name = @"sheep";
        
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
        _click = YES;
        
        // get the operator and value of the sheep, and store the original and updated scores
        NSMutableDictionary* sheepData = node.userData;
        char sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
        NSString* sheepValue = [sheepData objectForKey:@"Value"];
        double _originalScore = [_dataModel getScore];
        [_dataModel applySheepChar:sheepOper andValue:sheepValue];
        double _currentScore = [_dataModel getScore];
        
        // setup popup explaining how score changes
        SKLabelNode* popup = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        popup.fontSize = 38;
        popup.fontColor = [UIColor whiteColor];
        popup.position = CGPointMake(150,380);
        NSString* title = [NSString stringWithFormat:@"the score is updated to: "];
        popup.text = title;
        popup.zPosition = 2;
        popup.name = @"popup";
        [node addChild:popup];
        
        SKLabelNode* popup2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        popup2.fontSize = 38;
        popup2.fontColor = [UIColor whiteColor];
        popup2.position = CGPointMake(150,330);
        NSString* title2 = [NSString stringWithFormat:@"%.2f %c %@ = %.2f", _originalScore, sheepOper, sheepValue, _currentScore];
        popup2.text = title2;
        popup2.zPosition = 2;
        popup2.name = @"popup2";
        [node addChild:popup2];
        
        // pause all animation for 3 seconds
        SKAction *stop = [SKAction speedTo:0 duration:0];
        SKAction *wait = [SKAction speedTo:0 duration:3];
        SKAction *run = [SKAction speedTo:1 duration:0];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *disappear = [SKAction runAction:remove onChildWithName:@"sheep1"];
        [self runAction:[SKAction sequence:@[stop, wait, disappear, run]]];
        
        [self addChild:[self newScoreNode:node]];
        CGFloat Xdimensions = self.size.width;
        CGFloat Ydimensions = self.size.height;
        
        // create newScore label for score animation
        CGFloat scoreY = Ydimensions * 0.10;
        CGFloat scoreX = Xdimensions * 0.17;
        
        SKNode* scoreNode = [self childNodeWithName:@"scoreNode"];
        
        // score animation
        if (scoreNode != nil) {
            scoreNode.name = nil;
            
            SKAction* zoom = [SKAction scaleTo: 2.0 duration: 0.1];
            SKAction* move = [SKAction moveTo:(CGPointMake(scoreX+150, scoreY-50)) duration:0.5];
            SKAction* pause = [SKAction waitForDuration: 0.20];
            SKAction* fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction* remove = [SKAction removeFromParent];
            SKAction* moveSequence = [SKAction sequence:@[zoom, move, pause, fadeAway, remove]];
            
            [scoreNode runAction: moveSequence completion:^{
                [_dataView updateScore:_currentScore];
            }];
        }
        
    } else if ([node.name isEqual: @"startgame"] || [node.name isEqual: @"quit"]) {
        
        // if finishing the game and clicking 'Start' button or quit the tutorial
        if ([_origin isEqual: @"startingGame"]) {
            
            // if the tutorial starts from the initial game loading, we start the game
            SKScene *gameScene = [[MainScene alloc] initWithSize:self.size andSKView:nil andMode:_mode];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:gameScene transition:transition];
            
        } else {
            
            // if the tutorial starts from the tutorial button, we go back to the home screen
            SKScene *startScene = [[StartScene alloc] initWithSize:self.size andSKView:nil];
            SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
            [self.view presentScene:startScene transition:transition];
            
        }
        
    } else if ([node.name isEqual: @"startaction"]) {
        
        // if clicking 'Start' to start the tutorial
        _dataModel = [DataModel alloc];
        _dataView = [[DataView alloc] init];
        [_dataView setupData:self withScore:0 andMode:_mode andModel:_dataModel andTargetScore:50];
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
    
    scoreNode.position = CGPointMake(node.position.x+50, node.position.y-30);
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
            if (node.position.y < self.size.height * 0.9) {
                flag1 = FALSE;
            }
        }];
        
        // tutorial ends when all sheep are offscreen or all sheep disappear
        if (((flag1 == TRUE) && (flag2 == TRUE)) || ((flag2 == FALSE) && (_click == YES))) {
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
    if ([_mode isEqualToString:@"target"]) {
        quitPopup.size = CGSizeMake(sceneX * 0.50, sceneY * 0.4);
    } else {
        quitPopup.size = CGSizeMake(sceneX * 0.38, sceneY * 0.3);
    }
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
    if ([_mode isEqualToString:@"target"]) {
        
        // Create content text on the popup
        SKLabelNode* quitPopupText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        quitPopupText.fontColor = [UIColor blueColor];
        quitPopupText.fontSize = 20;
        quitPopupText.position = CGPointMake(0, popupY * 0.10);
        quitPopupText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        quitPopupText.text = [NSString stringWithFormat:@"Your goal is to get as close as possible to the target point!"];
        [quitPopup addChild:quitPopupText];
        
        SKLabelNode* quitPopupTextTime = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        quitPopupTextTime.fontColor = [UIColor blueColor];
        quitPopupTextTime.fontSize = 25;
        quitPopupTextTime.position = CGPointMake(0, popupY * -0.05);
        quitPopupTextTime.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        quitPopupTextTime.text = [NSString stringWithFormat:@"When you think you are close enough,"];
        [quitPopup addChild:quitPopupTextTime];
        
        SKLabelNode* quitPopupTextTime2 = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        quitPopupTextTime2.fontColor = [UIColor blueColor];
        quitPopupTextTime2.fontSize = 25;
        quitPopupTextTime2.position = CGPointMake(0, popupY * -0.12);
        quitPopupTextTime2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        quitPopupTextTime2.text = [NSString stringWithFormat:@" press 'Hit Me!' to view your final score."];
        [quitPopup addChild:quitPopupTextTime2];
        
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
        
    } else {
        
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
    
}



@end
