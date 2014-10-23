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

@interface ViewController ()
{
    DragonView *_dragonView;
    SheepController *_sheepController;
    int _currentScore;
    DataView* _dataView;
    DataModel* _dataModel;
    SheepView* _sheepView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize SheepController ----------------------------------------------
    _sheepController = [[SheepController alloc] init];
    
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
    
    // Initialize SheepView-----------------------------------------------------
    CGRect sheepFrame = [self makeSheepFrame];
    _sheepView = [[SheepView alloc] initWithFrame:sheepFrame];
   // _sheepView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_sheepView];
    [self.view bringSubviewToFront:_sheepView];
    
    [_sheepView moveSheepFrom: CGPointMake(800,500) to:CGPointMake(0.0,0.0)];
    //[_sheepView displayOperator:@"+"];
    //[_sheepView displayValue:50];
    
    
    
    
    // Create Quit button
    CGFloat quitX = CGRectGetWidth(frame) * .88;
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


// Delegate Function: Shows result when game is over
- (void)showGameResults:(DataView *)controller
{
    NSString* alertTitle = @"Time's up!";
    NSString* gameResult = [NSString stringWithFormat:@"Your score was %d", _currentScore];
    
    UIAlertView *finishedGameResult = [[UIAlertView alloc]
                                       initWithTitle: alertTitle
                                       message: gameResult
                                       delegate: self
                                       cancelButtonTitle: @"OK"
                                       otherButtonTitles: nil];
    [finishedGameResult show];
}

// Quits the game when 'Quit' button is clicked
- (void)quitGame
{
    NSLog(@"Quit the game!");
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)makeDragonFrame {
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
    NSLog(@"in here");
    CGRect screen = self.view.frame;
    
    CGSize backgroundSize = [UIImage imageNamed:@"mathGameBG"].size;
    
    
    return CGRectMake(screen.origin.x, screen.origin.y, backgroundSize.width, backgroundSize.height);
}

@end
