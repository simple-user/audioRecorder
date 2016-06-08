//
//  ViewController.m
//  audioRecorder
//
//  Created by Admin on 08.06.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioRecorderDelegate>

@property(strong, nonatomic) AVAudioRecorder *audioRecorder;
@property(strong, nonatomic) NSURL *fullPath;

@end

@implementation ViewController



-(IBAction)recording
{
    AVAudioSession *audiosession = [AVAudioSession sharedInstance];
    [audiosession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audiosession setActive:YES error:nil];
    
    NSMutableDictionary *recSettings = [[NSMutableDictionary alloc] init];
    [recSettings setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [recSettings setObject:@(44100.0) forKey:AVSampleRateKey];
    [recSettings setObject:@(2) forKey:AVNumberOfChannelsKey];
    
    NSString *strName = @"qweasdzcxUnicTempName";
    NSString *strResouceDir = [[NSBundle mainBundle] resourcePath];
    NSString *strFullPath = [NSString stringWithFormat:@"%@/%@.caf", strResouceDir, strName];
    NSURL *urlFullPatth = [NSURL URLWithString:strFullPath];
    self.fullPath = urlFullPatth;
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:urlFullPatth settings:recSettings error:&error];
    if (error != nil || self.audioRecorder == nil)
    {
        NSLog(@"error - %@", error);
        return;
    }
    
    self.audioRecorder.delegate = self;
    [self.audioRecorder prepareToRecord];
    NSLog(@"Just before recording");
    [self.audioRecorder recordForDuration:0.2];
    
    
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag==NO)
    {
        NSLog(@"We have troubles during recordin, so it was finished unsuccessfully!");
    }
    else
    {
        NSLog(@"Recording was finished successfully!");
        
        BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:[self.fullPath path]];
        
        if(!exists)
        {
            NSLog(@"We didn't find file during checking");
        }
        else
        {
            NSLog(@"We found file durng checking!");
            NSLog( [self.fullPath path]  );
        }
    }
}



@end
