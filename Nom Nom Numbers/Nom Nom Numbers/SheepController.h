//
//  UIViewController+SheepController.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheepSprite.h"
#import "SheepModel.h"
//#import "DataModel.h"

@interface SheepController : UIViewController //<tagetScoreDelegate>


- (void) setupSheep:(SKScene*)mainScene;
- (void) generateNewSheep:(SKNode*)node;
- (int) getTagetScore;

@end
