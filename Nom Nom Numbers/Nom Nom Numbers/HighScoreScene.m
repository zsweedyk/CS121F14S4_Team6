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
    HighScoreModel * _model;
}


- (id) initWithSize:(CGSize)size
{
    
    _arrOfSounds = [NSMutableArray new];
    _model = [[HighScoreModel alloc] init];

    self = [super initWithSize:size];
    [self setup];
    
    return self;
}

- (void) setup
{
    [self setupBackground];
    //[self setupDragon];
    [self setupButtons];
}

- (void) setupBackground
{
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
    
    SKSpriteNode* scoreBoard = [SKSpriteNode spriteNodeWithImageNamed:@"popup"];
    scoreBoard.size = CGSizeMake(self.size.width*0.7, self.size.height*0.73);
    scoreBoard.position = CGPointMake(self.size.width*0.42, self.size.height*0.4);
    [self addChild:scoreBoard];
    
    SKLabelNode* title = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    title.fontColor = [UIColor whiteColor];
    title.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    title.position = CGPointMake(scoreBoard.size.width*-0.45, scoreBoard.size.height*0.38);
    title.text = @"High Scores";
    title.fontSize = 40;
    [scoreBoard addChild:title];
    
    [self setupScoreOn:scoreBoard];
    [self setupButtonsOn:scoreBoard];
}

- (void) setupButtonsOn: (SKSpriteNode *)scoreBoard
{
    SKLabelNode* timedMode = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    timedMode.fontColor = [UIColor lightTextColor];
    timedMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    timedMode.position = CGPointMake(scoreBoard.size.width*0.45, scoreBoard.size.height*0.3 - 360);
    timedMode.text = @"Timed Mode";
    [scoreBoard addChild:timedMode];
    
    SKLabelNode* targetMode = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    targetMode.fontColor = [UIColor lightTextColor];
    targetMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    targetMode.position = CGPointMake(scoreBoard.size.width*0.45, scoreBoard.size.height*0.3 - 405);
    targetMode.text = @"Target Mode";
    [scoreBoard addChild:targetMode];
}

- (void) setupScoreOn: (SKSpriteNode *)scoreBoard
{
    NSMutableArray* topTenScores = [_model getTopTen];
    
    for (int i = 0; i < [topTenScores count]; i++) {
        SKLabelNode* number = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        number.fontColor = [UIColor whiteColor];
        number.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        number.position = CGPointMake(scoreBoard.size.width*-0.43, scoreBoard.size.height*0.3 - (45*i));
        number.text = [NSString stringWithFormat:@"%i.", i+1];
        [scoreBoard addChild:number];
        
        SKLabelNode* scoreText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        scoreText.fontColor = [UIColor whiteColor];
        scoreText.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreText.position = CGPointMake(scoreBoard.size.width*-0.35, scoreBoard.size.height*0.3 - (45*i));
        scoreText.text = [NSString stringWithFormat:@"%@", [topTenScores objectAtIndex:i]];
        [scoreBoard addChild:scoreText];
    }
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
