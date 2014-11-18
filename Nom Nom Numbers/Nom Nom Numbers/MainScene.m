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
    char _sheepOper;
    NSString* _sheepValue;
}

// Bitmaps for fireball and sheep collision detection
// Note that this and all collision related code is slightly adapted from this site:
// http://www.raywenderlich.com/42699/spritekit-tutorial-for-beginners

static const uint32_t fireballCategory     =  0x1 << 0;
static const uint32_t sheepCategory        =  0x1 << 1;

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
    
    // Set up physics and delegate for collision detection
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
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
    SKSpriteNode* fireballNode = [fireballSprite fireball];
    
    // Send fireball at the middle of the sheep touched
    SKSpriteNode* sheepSpriteNode = (SKSpriteNode*) node;
    CGPoint sheepMiddle = CGPointMake(node.position.x, node.position.y + (sheepSpriteNode.size.height/2));
    [fireballSprite sendFireballTo:sheepMiddle OnScene:self];
    
    // Change the name of the sheep so you can't touch it again
    node.name = @"touchedSheep";
    
    // Set up collision physics but only on the sheep that was touched
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sheepSpriteNode.size.width/2];
    node.physicsBody.dynamic = YES;
    node.physicsBody.categoryBitMask = sheepCategory;
    node.physicsBody.contactTestBitMask = fireballCategory;
    node.physicsBody.collisionBitMask = 0;
    
    fireballNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fireballNode.size];
    fireballNode.physicsBody.dynamic = YES;
    fireballNode.physicsBody.categoryBitMask = fireballCategory;
    fireballNode.physicsBody.contactTestBitMask = sheepCategory;
    fireballNode.physicsBody.collisionBitMask = 0;
    fireballNode.physicsBody.usesPreciseCollisionDetection = YES;
}

- (SKLabelNode*) newScoreNode
{
    SKLabelNode* scoreNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
    
    NSString *oper = [NSString stringWithFormat:@"%c",_sheepOper];
    NSString* myString=[NSString stringWithFormat:@"%@%@",oper,_sheepValue];
    
    // if sheep value was a fraction, only display fraction part since displaying decimal
    // portion as well will get too cramped
    NSCharacterSet *parens = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSRange searchRange = NSMakeRange(0, myString.length);
    NSRange foundRange = [myString rangeOfCharacterFromSet:parens options:0 range:searchRange];
    // check if there are parentheses (the value is a fraction that contains its decimal counterpart
    if (foundRange.location != NSNotFound){
        NSRange range = [myString rangeOfString:@"("];
        NSString *shortString = [myString substringToIndex:range.location];
        scoreNode.text = shortString;
    }
    else {
        scoreNode.text = myString;
    }
    // set color to be off-white so text is visible even with sheep passing by
    scoreNode.fontColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    scoreNode.fontSize = 24;
    
    scoreNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-50);
    scoreNode.name = @"scoreNode";
    
    return scoreNode;
}

- (void) makeNewSheep:(SKNode*)node
{
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

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // Determine which physicsBody has the lower bitmask
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    SKNode* sheep = [secondBody node];
    SKNode* fireball = [firstBody node];
    fireball.hidden = TRUE;
    
    // Make sure one body is a sheep and call the makeNewSheep method
    if ((firstBody.categoryBitMask & fireballCategory) != 0 &&
        (secondBody.categoryBitMask & sheepCategory) != 0)
    {
        [self makeNewSheep:sheep];
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
