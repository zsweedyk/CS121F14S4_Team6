//
//  ViewController.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "ViewController.h"
#import "DataView.h"
#import "DataModel.h"

@interface ViewController ()
{
    int _currentScore;
    DataView* _dataView;
    DataModel* _dataModel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] initWithFrame:frame andScore:_currentScore];
    _dataView.customDelegate = self;
    [self.view addSubview:_dataView];
    
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
// DataModel's applySheep and DataView's updateScore


// Delegate Function: Shows result when game is over
- (void)showGameResults:(DataView *)controller
{
    //Show UIAlert with _currentScore
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

@end
