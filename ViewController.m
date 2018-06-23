//
//  ViewController.m
//  MersenneTwister
//
//  Created by Wojciech on 14.06.2018.
//  Copyright © 2018 Wojciech. All rights reserved.
//

#import "ViewController.h"
#import "MersenneTwister.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)generateButtonPressed:(id)sender {
    int seed = [[self.seedTextField text] intValue];
    [self generateAndSaveToFile:seed];
    [self showToastNotification:@"The file is ready!" howLong:3];
}

- (void)generateAndSaveToFile:(int)seed {
    MersenneTwister *mersenneTwister = [[MersenneTwister alloc] initWithSeed:seed];
    
    NSString* filePath = @"output.bin";
    
    // generate first number and save it into new file
    int generatedInteger = [mersenneTwister random];
    NSData* data = [NSData dataWithBytes:&generatedInteger length:sizeof(generatedInteger)];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    
    // create NSFileHandle object that will append new data to the file
    NSFileHandle* handle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [handle seekToEndOfFile];
    
    for (int i = 0; i < 2500000; i++) {
        int generatedInteger = [mersenneTwister random];
        NSData* data = [NSData dataWithBytes:&generatedInteger length:sizeof(generatedInteger)];
        [handle writeData:data];
        
        int bytesGenerated = (i + 1) * 4;
        if (bytesGenerated % 1000000 == 0) {
            NSLog(@"%d bytes generated", bytesGenerated);
        }
    }
    [handle closeFile];
}

- (void) showToastNotification:(NSString*)message howLong:(int)durationInSeconds {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, durationInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{[alert dismissViewControllerAnimated:YES completion:nil];});
}

@end
