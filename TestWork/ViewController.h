//
//  ViewController.h
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SongViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(void)play;
-(void)pause;
-(void)stop;

@end

