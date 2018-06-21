//
//  ViewController.h
//  MersenneTwister
//
//  Created by Wojciech on 14.06.2018.
//  Copyright © 2018 Wojciech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *seedTextField;

- (IBAction)generateButtonPressed:(id)sender;

@end

