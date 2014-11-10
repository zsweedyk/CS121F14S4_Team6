//
//  GameViewController.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "GameViewController.h"
#import "MainScene.h"
#import "StartScene.h"


@implementation SKScene (Unarchive)

+ (instancetype) unarchiveFromFile:(NSString *)file
{
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController
{
    
    SKView* _skView;
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _skView = (SKView *)self.view;
    
    if (!_skView.scene) {
        
        SKScene* StartPage = [[StartScene alloc] initWithSize:_skView.frame.size andSKView:_skView];
        StartPage.scaleMode = SKSceneScaleModeAspectFit;
        
        [_skView presentScene:StartPage];

    }
    
}


- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
        
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
