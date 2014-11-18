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

@implementation MainScene
{
    SKView* _skView;
    SheepController* _sheepController;
    DataView* _dataView;
    DataModel* _dataModel;
    double _currentScore;
    BOOL _gameEnded;
    BOOL _touchedSheep;
    int _countDownTillStart;
    SKLabelNode* _readyLabels;
    GameOverButton* gameOverPopup;
    NSMutableArray* arrOfSounds;
    NSTimer* _gameStartTimer;
    SKSpriteNode* _dragonAndBarn;
    NSArray* _dragonAnimationFrames;
}

- (id) initWithSize:(CGSize)size andSKView:(SKView*)skView
{
    _skView = skView;
    _gameEnded = false;
    _countDownTillStart = 4;
    
    arrOfSounds = [NSMutableArray new];
    
    _touchedSheep = false;
   
    self = [super initWithSize:size];
    [self setup];
    
    [self prepareForGame];
    
    // Set up dragon animation frames
    NSMutableArray* dragonFrames = [NSMutableArray array];
    SKTextureAtlas* dragonAnimationAtlas = [SKTextureAtlas atlasNamed:@"barnAndDragon"];
    NSUInteger numImages = dragonAnimationAtlas.textureNames.count;
    for (int i = 1; i <= numImages; i++) {
        NSString* textureName = [NSString stringWithFormat:@"barnAndDragonAnimation%d",i];
        SKTexture* temp = [dragonAnimationAtlas textureNamed:textureName];
        [dragonFrames addObject:temp];
    }
    _dragonAnimationFrames = dragonFrames;
    
    return self;
}

- (void) setup
{
    [self setupBackground];
    [self setupDragon];
    [self setupData];
}

- (void) prepareForGame
{
    NSString* fontType = @"MalayalamSangamMN-Bold";
    CGFloat labelX = self.frame.size.width * 0.5;
    CGFloat labelY = self.frame.size.height * 0.5;
    
    _readyLabels = [[SKLabelNode alloc] initWithFontNamed:fontType];
    _readyLabels.fontSize = 150;
    _readyLabels.fontColor = [UIColor redColor];
    _readyLabels.position = CGPointMake(labelX, labelY);
    _readyLabels.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _readyLabels.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _readyLabels.text = @"Ready?";
    
    [self addChild:_readyLabels];
    [self initializeTimer];
}

- (void) initializeTimer
{
    _gameStartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gameStartTimerAction) userInfo:nil repeats:YES];
}

- (void) gameStartTimerAction
{
    if (_countDownTillStart == 1) {
        _readyLabels.text = @"Go!";
        --_countDownTillStart;
        
    } else if (_countDownTillStart < 1) {
        [_gameStartTimer invalidate];
        [_readyLabels removeFromParent];
        
        [_dataView initializeTimer];
        _sheepController = [[SheepController alloc] init];
        [_sheepController setupSheep:self];
    } else {
        --_countDownTillStart;
        [self changeReadyLabelText];
    }
}

- (void) changeReadyLabelText
{
    _readyLabels.text = [NSString stringWithFormat:@"%d", _countDownTillStart];
}

- (void) restart
{
    _gameEnded = false;
    [gameOverPopup removeFromParent];
    
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
    
    _dragonAndBarn = dragon;
    [self addChild:dragon];
}

- (void) setupData
{
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] init];
    [_dataView setupData:self withScore:_currentScore];
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
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqual: @"sheep"]) {
        // Prevents another sheep from being touched during Fireball
        if(!_touchedSheep) {
            [self touchedSheep:node];
            [self playSheepNoise:self];
        }
        
    } else if ([node.name isEqual:@"quitbutton"]) {
//        [self playButtonNoise:self];
        [self quitGame];
    
    } else if ([node.name isEqual:@"quitaction"]) {
        // BACK TO MAIN SCREEN
//        [self playButtonNoise:self];
        SKScene *startScene = [[StartScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        SKTransition *transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:startScene transition:transition];
        
    } else if ([node.name isEqual:@"playagainaction"]) {
        // PLAY AGAIN
//        [self playButtonNoise:self];
        [self restart];
    }
}

- (void) touchedSheep:(SKNode*)node
{
    _touchedSheep = true;
    
    FireballSprite* fireballSprite = [[FireballSprite alloc] init];
    
    NSUInteger numFrames = [_dragonAnimationFrames count];
    [_dragonAndBarn runAction:[SKAction animateWithTextures: _dragonAnimationFrames
                                               timePerFrame: [fireballSprite animationTime]/numFrames
                                                     resize: YES
                                                    restore: YES]];
    
    // Send fireball at the middle of the sheep touched
    SKSpriteNode* sheepSpriteNode = (SKSpriteNode*) node;
    CGPoint sheepMiddle = CGPointMake(node.position.x, node.position.y + (sheepSpriteNode.size.height/2));
    [fireballSprite sendFireballTo:sheepMiddle OnScene:self];
    
    [NSTimer scheduledTimerWithTimeInterval: [fireballSprite fireballTravelTime] +
                                             [fireballSprite animationTime]
                                     target: self
                                   selector: @selector(makeNewSheep:)
                                   userInfo: node
                                    repeats: NO];
}

- (void) makeNewSheep:(NSTimer*)incomingTimer
{
    SKNode* node;
    
    if([incomingTimer userInfo] != nil) {
        node = [incomingTimer userInfo];
    }
    
    [_sheepController generateNewSheep:(SKNode*)node];
    NSMutableDictionary* sheepData = node.userData;
    _sheepOper = *[[sheepData objectForKey:@"Operator"] UTF8String];
    _sheepValue = [sheepData objectForKey:@"Value"];
    
    [_dataModel applySheepChar:_sheepOper andValue:_sheepValue];
    _currentScore = [_dataModel getScore];
    [_dataView updateScore:_currentScore];
    
    // show updating score with animated label
    [self addChild: [self newScoreNode]];
    
    CGFloat Xdimensions = self.size.width;
    CGFloat Ydimensions = self.size.height;
    
    // dimensions of score label (from data view class)
    CGFloat scoreY = Ydimensions * .93;
    CGFloat scoreX = Xdimensions * .02;
    
    SKNode *scoreNode = [self childNodeWithName:@"scoreNode"];
    
    if (scoreNode != nil)
    {
        scoreNode.name = nil;
        
        SKAction *zoom = [SKAction scaleTo: 2.0 duration: 0.1];
        SKAction *move = [SKAction moveTo:(CGPointMake(scoreX+150, scoreY-50)) duration:0.5];
        SKAction *pause = [SKAction waitForDuration: 0.25];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[zoom, move, pause, fadeAway, remove]];
        
        [scoreNode runAction: moveSequence];
    }
    
    _touchedSheep = false;
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
    [gameOverPopup setupData:self withScore:_currentScore];
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

- (IBAction)playSheepNoise:(id)sender
{
    // StrongFire is a clip taken from:
    // http://soundbible.com/1348-Large-Fireball.html
    NSString* fileName = @"StrongFire";
    int randomValue = arc4random_uniform(2);
    
    if (randomValue == 1) {
        fileName = @"WeakFire";
    }
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [arrOfSounds removeAllObjects];
    [arrOfSounds insertObject:newPlayer atIndex:0];
    newPlayer.volume = 1.0;
    [newPlayer prepareToPlay];
    [newPlayer play];
}

- (IBAction)playButtonNoise:(id)sender
{
//    NSString* fileName = @"Click";
//    
//    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    
//    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
//    [arrOfSounds removeAllObjects];
//    [arrOfSounds addObject:newPlayer];
//    [newPlayer prepareToPlay];
//    [newPlayer play];
}


@end
