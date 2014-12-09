//
//  SKScene+HighScoreScene.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 11/23/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "HighScoreScene.h"
#import "HighScoreModel.h"
#import "StartScene.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation HighScoreScene {
    NSMutableArray* _arrOfSounds;
    SKSpriteNode* _scoreBoard;
    HighScoreModel * _model;
    SKLabelNode* _scoreText;
    SKLabelNode* _title;
    BOOL _onTimed;
}


- (id) initWithSize:(CGSize)size
{
    _arrOfSounds = [NSMutableArray new];
    _model = [[HighScoreModel alloc] init];
    _onTimed = true;
    self = [super initWithSize:size];
    [self setup];
    
    return self;
}

- (void) setup
{
    [self setupBackgroundWithMode];
    [self setupLayoutOn:_scoreBoard];
    [self setupScoreOn:_scoreBoard ForTimed:true];
    [self setupButtons];
}

- (void) setupBackgroundWithMode
{
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    _scoreBoard = [SKSpriteNode spriteNodeWithImageNamed:@"popup"];
    _scoreBoard.size = CGSizeMake(self.size.width*0.7, self.size.height*0.73);
    _scoreBoard.position = CGPointMake(self.size.width*0.42, self.size.height*0.4);
    [self addChild:_scoreBoard];
}

- (void) setupLayoutOn: (SKSpriteNode *)scoreBoard
{
    _title = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    _title.fontColor = [UIColor whiteColor];
    _title.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _title.position = CGPointMake(_scoreBoard.size.width*-0.45, _scoreBoard.size.height*0.38);
    _title.text = @"High Scores in Timed Mode";
    _title.fontSize = 40;
    [_scoreBoard addChild:_title];
    
    SKLabelNode* timedMode = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timedMode.fontColor = [UIColor lightTextColor];
    timedMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    timedMode.position = CGPointMake(scoreBoard.size.width*0.45, scoreBoard.size.height*0.3 - 360);
    timedMode.text = @"Timed Mode";
    timedMode.name = @"timedMode";
    [scoreBoard addChild:timedMode];
    
    SKLabelNode* targetMode = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetMode.fontColor = [UIColor lightTextColor];
    targetMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    targetMode.position = CGPointMake(scoreBoard.size.width*0.45, scoreBoard.size.height*0.3 - 405);
    targetMode.text = @"Target Mode";
    targetMode.name = @"targetMode";
    [scoreBoard addChild:targetMode];
}

- (void) setupScoreOn: (SKSpriteNode *)scoreBoard ForTimed:(BOOL)timed
{
    NSMutableArray* topTenScores = [_model getTopTenForTimed];
    
    if (!timed) {
        topTenScores = [_model getTopTenForTarget];
    }
    
    for (int i = 0; i < [topTenScores count]; i++) {
        SKLabelNode* number = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        number.fontColor = [UIColor whiteColor];
        number.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        number.position = CGPointMake(scoreBoard.size.width*-0.43, scoreBoard.size.height*0.3 - (45*i));
        number.text = [NSString stringWithFormat:@"%i.", i+1];
        [scoreBoard addChild:number];
        
        _scoreText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        _scoreText.fontColor = [UIColor whiteColor];
        _scoreText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreText.position = CGPointMake(scoreBoard.size.width*-0.35, scoreBoard.size.height*0.3 - (45*i));
        _scoreText.text = [NSString stringWithFormat:@"%@", [topTenScores objectAtIndex:i]];
        
        if (!timed) {
            _scoreText.text = [NSString stringWithFormat:@"%@", [[topTenScores objectAtIndex:i] objectAtIndex:1]];
            
            SKLabelNode* time = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
            time.fontColor = [UIColor whiteColor];
            time.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            time.position = CGPointMake(scoreBoard.size.width*-0.15, scoreBoard.size.height*0.3 - (45*i));
            time.text = [NSString stringWithFormat:@"in %@ seconds", [[topTenScores objectAtIndex:i] objectAtIndex:0]];
            [scoreBoard addChild:time];
        }
        [scoreBoard addChild:_scoreText];
    }
}

- (void) clearScores
{
    [_scoreBoard removeAllChildren];
    [self setupLayoutOn:_scoreBoard];
}

- (void) setupButtons
{
    SKSpriteNode* backButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
    backButton.size = CGSizeMake(200, 60);
    backButton.position = CGPointMake(self.size.width*.12, self.size.height*0.93);
    backButton.name = @"mainMenu";
    backButton.zPosition = 1;
    [self addChild:backButton];
    
    SKLabelNode* backButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    backButtonLabel.fontColor = [UIColor whiteColor];
    backButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    backButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    backButtonLabel.text = @"Main Menu";
    backButtonLabel.name = @"mainMenu";
    [backButton addChild:backButtonLabel];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode* node = [self nodeAtPoint:location];
    
    // Back to main menu
    if ([node.name isEqual:@"mainMenu"]) {
        [self playButtonNoise:self];
        SKScene* startScene = [[StartScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:startScene transition:transition];
    
    // Show Timed Mode scores
    } else if ([node.name isEqual: @"timedMode"]) {
        [self playButtonNoise:self];
        
        if (_onTimed) {
            // Do nothing
        } else {
            _onTimed = true;
            [self clearScores];
            [self setupScoreOn:_scoreBoard ForTimed:true];
            
            _title.text = @"High Scores in Timed Mode";
            
        }
    // Show Target Mode scores
    } else if ([node.name isEqual:@"targetMode"]) {
        [self playButtonNoise:self];

        if (!_onTimed) {
            // Do nothing
        } else {
            _onTimed = false;
            [self clearScores];
            [self setupScoreOn:_scoreBoard ForTimed:false];
            
            _title.text = @"High Scores in Target Mode";
        }
    }

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
