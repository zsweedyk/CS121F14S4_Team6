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
#import "FireballSprite.h"
#import "HighScoreModel.h"



@implementation MainScene

{
    
    SheepController* _sheepController;
    DataView* _dataView;
    DataModel* _dataModel;
    double _currentScore;
    int _targetScore;
    BOOL _gameEnded;
    BOOL _touchedSheep;
    int _countDownTillStart;
    SKLabelNode* _readyLabels;
    SKSpriteNode* _gameOverBacklay;
    GameOverButton* _gameOverPopup;
    NSString* _mode;
    NSMutableArray* _arrOfSounds;
    NSTimer* _gameStartTimer;
    SKSpriteNode* _dragonGreen;
    SKSpriteNode* _dragonBlue;
    NSArray* _dragonAnimationFrames;
    char _sheepOper;
    NSString* _sheepValue;
    HighScoreModel* _highScoreModel;
    
}





// Creates an SKScene while noting which mode we have entered
- (id) initWithSize:(CGSize)size andSKView:(SKView *)skView andMode:(NSString *)mode
{
    
    _mode = mode;
    _gameEnded = false;
    _countDownTillStart = 4;
    
    
    _arrOfSounds = [NSMutableArray new];
    _touchedSheep = false;
    _highScoreModel = [[HighScoreModel alloc] init];
    [_highScoreModel checkExists];
    
    
    
    self = [super initWithSize:size];
    _sheepController = [[SheepController alloc] init];
    [self setup];
    
   
    // Set up dragon animation frames
    NSMutableArray* dragonFrames = [NSMutableArray array];
    SKTextureAtlas* dragonAnimationAtlas = [SKTextureAtlas atlasNamed:@"dragon"];
    NSUInteger numImages = dragonAnimationAtlas.textureNames.count;
    
    
    for (int i = 1; i <= numImages; i++) {
        NSString* textureName = [NSString stringWithFormat:@"dragonAnimation%d",i];
        SKTexture* temp = [dragonAnimationAtlas textureNamed:textureName];
        [dragonFrames addObject:temp];
    }
    
    _dragonAnimationFrames = dragonFrames;
    
    return self;
    
}



- (void) setup
{
    
    [self setupBackground];
    [self setupDragons];
    [self prepareForGame];
    [self setupData];
    
}



// 3, 2, 1, Go! Before the game starts
- (void) prepareForGame
{
    
    NSString* fontType = @"MalayalamSangamMN-Bold";
    CGFloat labelX = self.frame.size.width * 0.5;
    CGFloat labelY = self.frame.size.height * 0.5;
    
    UIColor* transparentColor = [[UIColor alloc] initWithRed:0.3 green:0.3 blue:0.3 alpha:0.45];
    _gameOverBacklay = [[SKSpriteNode alloc] initWithColor:transparentColor size:CGSizeMake(self.size.width, self.size.height)];
    _gameOverBacklay.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    _gameOverBacklay.zPosition = 3;
    
    [self addChild:_gameOverBacklay];
    
    _readyLabels = [[SKLabelNode alloc] initWithFontNamed:fontType];
    _readyLabels.fontSize = 150;
    _readyLabels.fontColor = [UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1.0];
    _readyLabels.position = CGPointMake(labelX, labelY);
    _readyLabels.zPosition = 4;
    _readyLabels.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _readyLabels.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _readyLabels.text = @"Ready?";
    
    [self addChild:_readyLabels];
    [self initializeTimer];
    
}



// Start timer countdown
- (void) initializeTimer
{
    
    _gameStartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gameStartTimerAction) userInfo:nil repeats:YES];
    
}



// Displays preparation timer
- (void) gameStartTimerAction
{
    
    if (_countDownTillStart == 1) {
        
        _readyLabels.text = @"Go!";
        --_countDownTillStart;
        
    } else if (_countDownTillStart < 1) {
        
        [_gameStartTimer invalidate];
        [_readyLabels removeFromParent];
        [_gameOverBacklay removeFromParent];
        
        [_dataView initializeTimer];
        [_sheepController setupSheep:self forMode:_mode];
        
    } else {
        --_countDownTillStart;
        [self changeReadyLabelText];
        
    }
    
}



// Changes label in preparation timer to appropriate text
- (void) changeReadyLabelText
{
    _readyLabels.text = [NSString stringWithFormat:@"%d", _countDownTillStart];
    
}



// Used to reset settings for a new game
- (void) restart
{
    _gameEnded = false;
    [_gameOverPopup removeFromParent];
    
    // Reset data
    [_dataModel resetScore];
    _currentScore = 0;
    [_dataView updateScore:[_dataModel getScore]];
    [_dataView resetTimer];
    
    // Reset initial game prep
    _readyLabels.text = @"Ready?";
    _countDownTillStart = 4;
    
    [self prepareForGame];
    
}


- (void) setupBackground
{
    
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



- (void) setupDragons
{
    
    SKSpriteNode* dragon = [SKSpriteNode spriteNodeWithImageNamed:@"dragon"];
    CGSize dragonSize = [UIImage imageNamed:@"dragon"].size;
    CGSize screenSize = self.size;
    dragon.position = CGPointMake(screenSize.width - dragonSize.width*0.5 + 50,
                                  screenSize.height*0.5 - dragonSize.height*0.25);
    
    dragon.anchorPoint = CGPointZero;
    dragon.xScale = .5;
    dragon.yScale = .5;
    dragon.zPosition = 2;
    
    _dragonGreen = dragon;
    
    [self addChild:dragon];
    
    
    SKSpriteNode* dragon2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueDragon"];
    dragon2.position = CGPointZero;
    dragon2.anchorPoint = CGPointZero;
    dragon2.xScale = .5;
    dragon2.yScale = .5;
    dragon2.zPosition = 2;
    
    
    
    _dragonBlue = dragon2;    
    [self addChild:dragon2];
    
}



// Sets up data for the game

- (void) setupData

{
    
    // Create DataModel
    
    _dataModel = [[DataModel alloc] init];
    
    _dataModel.customDelegate = _sheepController;
    
    _currentScore = [_dataModel getScore];
    
    
    
    // Create DataView
    
    _dataView = [[DataView alloc] init];
    
    _targetScore = [_sheepController getTargetScore];
    
    [_dataView setupData:self withScore:_currentScore andMode:_mode andModel:_dataModel andTargetScore:_targetScore];
    
    _dataView.customDelegate = self;
    
    [self addChild:_dataView];
    
    
    
    // Create Quit button
    
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"redButton"];
    
    quitButton.size = CGSizeMake(120, 60);
    
    quitButton.position = CGPointMake(self.size.width * 0.92, self.size.height * 0.95);
    
    quitButton.name = @"quitbutton";
    
    quitButton.zPosition = 2;
    
    [self addChild:quitButton];
    
    
    
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    
    quitButtonLabel.fontSize = 45;
    
    quitButtonLabel.fontColor = [UIColor whiteColor];
    
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    quitButtonLabel.text = @"Quit";
    
    quitButtonLabel.name = @"quitbutton";
    
    [quitButton addChild:quitButtonLabel];
    
}



// Looks for touches to the screen, matches touch to an appropriately named node

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    SKNode* node = [self nodeAtPoint:location];
    
    
    
    // Sheep clicked
    
    if ([node.name isEqual: @"sheep"]) {
        
        
        
        // Prevents another sheep from being touched during Fireball
        
        if(!_touchedSheep) {
            
            [self touchedSheep:node];
            
            [self playSheepNoise:self];
            
        }
        
        
        
    } else if ([node.name isEqual:@"quitbutton"]) {
        
        [self playButtonNoise:self];
        
        [self quitGame];
        
        
        
        // Back to main screen
        
    } else if ([node.name isEqual:@"quitaction"]) {
        
        [self playButtonNoise:self];
        
        SKScene* startScene = [[StartScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        
        [self.view presentScene:startScene transition:transition];
        
        
        
        // Play Again
        
    } else if ([node.name isEqual:@"playagainaction"]) {
        
        [self playButtonNoise:self];
        
        [self restart];
        
        
        
        // TARGET MODE: End Game
        
    } else if ([node.name isEqual:@"targetbutton"]) {
        
        [self playButtonNoise:self];
        
        [self showGameResults:_dataView];
        
    }
    
}



- (void) touchedSheep:(SKNode *)node

{
    
    _touchedSheep = true;
    
    
    
    FireballSprite* fireballSprite = [[FireballSprite alloc] init];
    
    
    
    NSUInteger numFrames = [_dragonAnimationFrames count];
    
    [_dragonGreen runAction:[SKAction animateWithTextures: _dragonAnimationFrames
                             
                                             timePerFrame: [fireballSprite animationTime]/numFrames
                             
                                                   resize: YES
                             
                                                  restore: YES]];
    
    
    
    // Send fireball at the middle of the sheep touched
    
    SKSpriteNode* sheepSpriteNode = (SKSpriteNode *) node;
    
    CGPoint sheepMiddle = CGPointMake(node.position.x + (sheepSpriteNode.size.width/2),
                                      
                                      node.position.y + (sheepSpriteNode.size.height));
    
    [fireballSprite sendFireballTo:sheepMiddle OnScene:self];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval: [fireballSprite fireballTravelTime] +
     
     [fireballSprite animationTime]
     
                                     target: self
     
                                   selector: @selector(makeNewSheep:)
     
                                   userInfo: node
     
                                    repeats: NO];
    
}



// Add score animation

- (SKSpriteNode *) newScoreNodeAtLocation: (CGPoint)loc

{
    
    SKSpriteNode* mutton = [SKSpriteNode spriteNodeWithImageNamed:@"mutton"];
    
    SKLabelNode* scoreNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
    
    
    
    mutton.position = loc;
    
    mutton.name = @"scoreNode";
    
    mutton.xScale = .1;
    
    mutton.yScale = .1;
    
    
    
    NSString *oper = [NSString stringWithFormat:@"%c",_sheepOper];
    
    NSString* myString=[NSString stringWithFormat:@"%@%@",oper,_sheepValue];
    
    
    
    // If sheep value was a fraction, only display fraction part (not decimal part)
    
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
    
    
    
    scoreNode.fontColor = [UIColor blackColor];
    
    scoreNode.fontSize = 48;
    
    
    
    [mutton addChild:scoreNode];
    
    
    
    return mutton;
    
}



// Add animation to the score node

- (void) animateScoreNode

{
    
    CGFloat Xdimensions = self.size.width;
    
    CGFloat Ydimensions = self.size.height;
    
    
    
    // Dimensions of score label (from data view class)
    
    CGFloat scoreY = Ydimensions * 0.2;
    
    CGFloat scoreX = Xdimensions * 0.1;
    
    
    
    SKNode* scoreNode = [self childNodeWithName:@"scoreNode"];
    
    _currentScore = [_dataModel getScore];
    
    
    
    if (scoreNode != nil) {
        
        scoreNode.name = nil; // change name so we don't affect this node anymore
        
        
        
        SKAction* zoom = [SKAction scaleTo: 0.5 duration: 0.1];
        
        SKAction* move = [SKAction moveTo:(CGPointMake(scoreX-2, scoreY-50)) duration:0.5];
        
        SKAction* pause = [SKAction waitForDuration: 0.1];
        
        SKAction* fadeAway = [SKAction fadeOutWithDuration: 0.25];
        
        SKAction* remove = [SKAction removeFromParent];
        
        SKAction* moveSequence = [SKAction sequence:@[zoom, move, pause, fadeAway, remove]];
        
        
        
        SKAction* open = [SKAction setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"blueDragonOpen"]]];
        
        SKAction* basketPause = [SKAction waitForDuration: 0.5];
        
        SKAction* close = [SKAction setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"blueDragon"]]];
        
        SKAction* dragonSequence = [SKAction sequence:@[open, basketPause, close]];
        
        
        
        [_dragonBlue runAction:dragonSequence];
        
        [scoreNode runAction: moveSequence completion:^{
            
            [_dataView updateScore:_currentScore];
            
        }];
        
    }
    
}



// Create new sheep with value and operator

- (void) makeNewSheep:(NSTimer *)incomingTimer

{
    
    SKNode* node;
    
    
    
    if ([incomingTimer userInfo] != nil) {
        
        node = [incomingTimer userInfo];
        
    }
    
    
    
    [_sheepController generateNewSheep:(SKNode*)node];
    
    NSMutableDictionary* sheepData = node.userData;
    
    _sheepOper = *[[sheepData valueForKey:@"Operator"] UTF8String];
    
    _sheepValue = [sheepData objectForKey:@"Value"];
    
    
    
    [_dataModel applySheepChar:_sheepOper andValue:_sheepValue];
    
    
    
    CGPoint sheepLocation = node.position;
    
    
    
    // Show updating score with animated label
    
    [self addChild: [self newScoreNodeAtLocation:sheepLocation]];
    
    [self animateScoreNode];
    
    
    
    
    
    _touchedSheep = false;
    
}



// Update function continuously checks for sheep that exit the screen,

// and generates a new one if needed

- (void) update:(NSTimeInterval)currentTime

{
    
    [self enumerateChildNodesWithName:@"sheep" usingBlock:^(SKNode* node, BOOL* stop) {
        
        
        
        if (node.position.y > self.size.height - 100) {
            
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
    
    _gameOverPopup = [[GameOverButton alloc] init];
    
    double score;
    
    if ([_mode isEqualToString:@"target"]) {
        
        // Generate score for target mode
        
        double time = [_dataView getCurrentTime];
        
        score = [_dataModel calculateTargetScoreAtTime:time];
        
        [_highScoreModel saveTargetScore:score atTime:time];
        
        
        
        // Return score for timed mode
        
    } else {
        
        score = round(100 *_currentScore)/100.00;
        
        [_highScoreModel saveScore:score];
        
    }
    
    
    
    [_gameOverPopup setupData:self withScore:score];
    
    [self addChild: _gameOverPopup];
    
}





// Displays the popup for when Quit Game is pressed

- (void) quitGame

{
    
    _gameEnded = true;
    
    [_dataView stopTimer];
    
    
    
    // Create the Quit popup
    
    QuitGameButton* quitPopup = [[QuitGameButton alloc] init];
    
    
    
    double score;
    
    
    
    // Calculates score for Target mode
    
    if ([_mode isEqualToString:@"target"]) {
        
        double time = [_dataView getCurrentTime];
        
        score = [_dataModel calculateTargetScoreAtTime:time];
        
        [_highScoreModel saveTargetScore:score atTime:time];
        
        
        
        // Calculates score for Timed mode
        
    } else {
        
        score = _currentScore;
        
        [_highScoreModel saveScore:round(100 * score)/100.00];
        
    }
    
    
    
    [quitPopup setupData:self withScore:score];
    
    [self addChild:quitPopup];
    
}



// Plays noise when a sheep is clicked

- (IBAction) playSheepNoise:(id)sender

{
    
    // StrongFire is a clip taken from:
    
    // http://soundbible.com/1348-Large-Fireball.html
    
    NSString* fileName = @"StrongFire";
    
    int randomValue = arc4random_uniform(2);
    
    
    
    if (randomValue == 1) {
        
        fileName = @"WeakFire";
        
    }
    
    
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    
    NSURL* fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    
    [_arrOfSounds removeAllObjects];
    [_arrOfSounds insertObject:newPlayer atIndex:0];
    newPlayer.volume = 1.0;
    [newPlayer prepareToPlay];
    [newPlayer play];
    
}



// Plays noise when a button is clicked

- (IBAction) playButtonNoise:(id)sender
{
    
    NSString* fileName = @"Click";
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL* fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    
    [_arrOfSounds removeAllObjects];
    [_arrOfSounds addObject:newPlayer];
    [newPlayer prepareToPlay];
    [newPlayer play];
    
}





@end