//
//  SongViewController.h
//  TestWork
//
//  Created by Stepan Chegrenev on 17.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//
//@protocol AudioProtocol;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SongViewController : UIViewController

@property (strong, nonatomic) NSString* artistName;
@property (strong, nonatomic) NSString* creator;
@property (strong, nonatomic) UIImage* imageArtwork;
@property (strong, nonatomic) NSString* albumName;
@property (strong, nonatomic) NSString* songName;
@property (strong ,nonatomic) NSURL* fileURL;

@end
