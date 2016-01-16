//
//  ViewController.m
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (strong ,nonatomic) NSArray* arrayOfSongs;    // Объявляю массив как свойство, чтобы иметь доступ к нему в любом методе

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView* listOfSongs = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 375, 467) style:UITableViewStylePlain];    // инициализирую таблицу
    
    listOfSongs.delegate = self;    // Присваиваю текущий объект табличному виду в качестве делегата
    
    listOfSongs.dataSource = self;  // Присваиваю контроллер в качестве источника данных
    
    [self.view addSubview:listOfSongs]; // Добавляю таблицу
    
    self.arrayOfSongs = @[@"Song1", @"Song2", @"Song3"]; // Наполняю массив треками(название файла композиции без расширения файла)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
