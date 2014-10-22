//
//  DataView.h
//  Math Game
//
//  Created by Shannon on 10/21/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataView : UIView
{
    int _initialTime;
    UILabel* _currentTime;
    UILabel* _currentScore;
    NSTimer* _gameTimer;
}

- (id)initWithFrame:(CGRect)frame andScore:(int)currentScore;
- (void)updateScore: (int)newScore;
@end
