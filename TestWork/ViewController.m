//
//  ViewController.m
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView* listOfSongs = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 375, 467) style:UITableViewStylePlain];    // инициализирую таблицу
    
    listOfSongs.delegate = self;    // Присваиваю текущий объект табличному виду в качестве делегата
    
    listOfSongs.dataSource = self;  // Присваиваю контроллер в качестве источника данных
    
    [self.view addSubview:listOfSongs]; // Добавляю таблицу
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
