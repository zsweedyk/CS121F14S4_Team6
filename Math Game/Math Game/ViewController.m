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
    double _currentScore;
    DataView* _dataView;
    DataModel* _dataModel;
    SheepView* _sheepView;
    SheepModel* _sheepModel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize SheepController ----------------------------------------------
    _sheepController = [[SheepController alloc] init];
//    [_sheepController setSheepOnScreen:false];
    CGRect sheepFrame = [self makeSheepFrame];
    [_sheepController generateSheep:self.view withSheepFrame:sheepFrame];
    //[self.view addSubview:_sheepController.view];
    
    
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
    
    // Initialize SheepModel----------------------------------------------------
    _sheepModel = [[SheepModel alloc]init];
    [_sheepModel makeSheep];
    
    // Initialize SheepView-----------------------------------------------------
    //CGRect sheepFrame = [self makeSheepFrame];
    _sheepView = [[SheepView alloc] initWithFrame:sheepFrame];
    
//    [_sheepView moveSheepFrom: CGPointMake(800,400) to:CGPointMake(0,0)];
//    [_sheepView displayOperator:[_sheepModel getOperator]];
//    [_sheepView displayValue:[_sheepModel getValue]];
//    
//    [self.view addSubview:_sheepView];
//    [self.view bringSubviewToFront:_sheepView];
    

    
    
    // Create Quit button
    CGFloat quitX = CGRectGetWidth(frame) * .75;
    CGFloat quitY = CGRectGetHeight(frame) * .04;
    CGRect quitDisplay = CGRectMake(quitX, quitY, 100, 50);
    UIButton* quitButton = [[UIButton alloc] initWithFrame:quitDisplay];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:50]];
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(quitGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
    
}

// When a sheep is selected, two functions must be called:
// DataModel's applySheepChar:andValue: & getScore and DataView's updateScore

// Delegate Function: Shows result when game is over
- (void)showGameResults:(DataView *)controller
{
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
- (void)quitGame
{
    NSString* alertTitle = @"You quit the game!";
    NSString* subtitle = [NSString stringWithFormat:@"(Not really, this is just a placeholder)"];
    
    UIAlertView *quitGameAlert = [[UIAlertView alloc]
                                       initWithTitle: alertTitle
                                       message: subtitle
                                       delegate: self
                                       cancelButtonTitle: @"OK"
                                       otherButtonTitles: nil];
    [quitGameAlert show];
    
    [_sheepController endGame];
    [_dataView stopTimer];
}

//- (void)onSheepSelection:(id)sheep
//{
//    NSString value = [sheep getValue];
//    char operator = [sheep getOperator];
//    [_dataModel applySheepToScore:value, operator];
//    
//    [_dataView updateScore:[_dataModel getScore]];
//}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    CGFloat x = screenWidth - dragonWidth + 10;
    CGFloat y = screenHeight/2.0 - 330;
    
    return CGRectMake(x, y, dragonWidth, dragonHeight);
}

- (CGRect)makeSheepFrame {
    
    CGRect screen = self.view.frame;
    
    CGSize backgroundSize = [UIImage imageNamed:@"mathGameBG"].size;
    
    
    return CGRectMake(screen.origin.x, screen.origin.y, backgroundSize.width, backgroundSize.height);
}

@end
