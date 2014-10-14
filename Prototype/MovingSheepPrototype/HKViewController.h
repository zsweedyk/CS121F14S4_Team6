//
//  HKViewController.h
//  MovingSheepPrototype
//
//  Created by HMC on 10/13/14.
//  Copyright (c) 2014 Hana Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKViewController : UIViewController{
    IBOutlet UIImageView * myImage1;
    IBOutlet UIImageView * myImage2;
    IBOutlet UIImageView * myImage3;
    IBOutlet UIImageView * myImage4;
    
    CGPoint pos;
}
- (IBAction)doSomething:(id)sender;

@end
