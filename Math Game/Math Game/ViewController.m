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
#import "DataModel.h"

@interface ViewController ()
{
    DragonView *dragonView;
    SheepController *sheepController;
    DataModel *dataModel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize SheepController ----------------------------------------------
    sheepController = [[SheepController alloc] init];
    
    // Initialize DragonView ---------------------------------------------------
    CGRect dragonFrame = [self makeDragonFrame];
    dragonView = [[DragonView alloc] initWithFrame:dragonFrame];
    
    [self.view addSubview:dragonView];
    
    // Initialize DataModel ----------------------------------------------------
    
    // Initialize DataView -----------------------------------------------------
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

@end
