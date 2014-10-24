//
//  ViewController.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "ViewController.h"
#import "SheepController.h"
#import "DragonView.h"
#import "DataView.h"
#import "DataModel.h"
#import "SheepView.h"
#import "SheepModel.h"

@interface ViewController ()
{
    DragonView *_dragonView;
    SheepController *_sheepController;
    DataView* _dataView;
    DataModel* _dataModel;
    double _currentScore;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize SheepController ----------------------------------------------
    CGRect sheepFrame = [self makeSheepFrame];
    _sheepController = [[SheepController alloc] initWithFrame:self.view withSheepFrame:sheepFrame];
    _sheepController.customSheepControllerDelegate = self;
    [_sheepController generateSheepOnScreen:YES];
    
    
    // Initialize DragonView ---------------------------------------------------
    CGRect dragonFrame = [self makeDragonFrame];
    _dragonView = [[DragonView alloc] initWithFrame:dragonFrame];
    
    [self.view addSubview:_dragonView];

    // Initialize data ---------------------------------------------------------
    CGRect frame = self.view.frame;
    
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] initWithFrame:frame andScore:_currentScore];
    _dataView.customDelegate = self;
    [self.view addSubview:_dataView];
    
    // Create Quit button
    CGFloat quitX = CGRectGetWidth(frame) * .75;
    CGFloat quitY = CGRectGetHeight(frame) * .04;
    CGRect quitDisplay = CGRectMake(quitX, quitY, 100, 50);
    UIButton* quitButton = [[UIButton alloc] initWithFrame:quitDisplay];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:40]];
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
    
}

// Delegate Function: A sheep has been clicked!
- (void)applySheepToView:(SheepController *)controller withOper:(char)oper andValue:(NSString *)value
{
    [_dataModel applySheepChar:oper andValue:value];
    _currentScore = [_dataModel getScore];
    NSLog(@"Current score is %f", _currentScore);
    [_dataView updateScore:_currentScore];
}

// Delegate Function: Shows result when game is over
- (void) showGameResults:(DataView *)controller
{
    // Stop producing more sheep
    [_sheepController generateSheepOnScreen:NO];
    
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
    [_sheepController endGame];
}

// Quits the game when 'Quit' button is clicked
- (void) quitGame
{
    // Stop producing more sheep
    NSLog(@"In quitGame");
    [_sheepController generateSheepOnScreen:NO];
    
    // Create a UIAlert to show score
    NSString* alertTitle = @"You quit the game!";
    NSString* subtitle = [NSString stringWithFormat:@"(Not really, this is just a placeholder)"];
    
    UIAlertView *quitGameAlert = [[UIAlertView alloc]
                                       initWithTitle: alertTitle
                                       message: subtitle
                                       delegate: self
                                       cancelButtonTitle: @"OK"
                                       otherButtonTitles: nil];
    [_dataView stopTimer];
    [quitGameAlert show];
    [_sheepController endGame];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Creates dimensions for dragon image
- (CGRect)makeDragonFrame
{
    CGRect screen = self.view.frame;
    
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeight = screen.size.width;
    
    CGSize dragonSize = [UIImage imageNamed:@"dragon"].size;
    CGSize backgroundSize = [UIImage imageNamed:@"mathGameBG"].size;
    CGFloat dragonBGWidthRatio = dragonSize.width/backgroundSize.width;
    CGFloat dragonBGHeightRatio = dragonSize.height/backgroundSize.height;
    
    CGFloat dragonWidth = dragonBGWidthRatio * screenWidth;
    CGFloat dragonHeight = dragonBGHeightRatio * screenHeight;
    
    CGFloat x = screenWidth - dragonWidth + 5;
    CGFloat y = screenHeight/2.0 - 340;
    
    return CGRectMake(x, y, dragonWidth, dragonHeight);
}

// Creates dimensions for sheep image
- (CGRect)makeSheepFrame {
    CGRect screen = self.view.frame;
    CGSize backgroundSize = [UIImage imageNamed:@"mathGameBG"].size;
    
    return CGRectMake(screen.origin.x, screen.origin.y, backgroundSize.width, backgroundSize.height);
}

@end
