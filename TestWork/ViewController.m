//
//  ViewController.m
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong ,nonatomic) NSArray* arrayOfSongs;    // Объявляю массив как свойство, чтобы иметь доступ к нему в любом методе
@property (strong ,nonatomic) NSURL* fileURL;
@property (strong ,nonatomic) NSString* currentSongTitle;
@property (strong ,nonatomic) NSString* currentSongArtist;
@property (strong ,nonatomic) UIImage* currentSongArtwork;

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

-(NSString*) getSongTitle:(NSString*) song {    // Получение названия композиции
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];    // Определяю путь к треку
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];  // Инициализирую ассета по url
    
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                     withKey:AVMetadataCommonKeyTitle
                                                    keySpace:AVMetadataKeySpaceCommon];   // Нахожу название трека с помощью ассета по ключу
    
    if (titles.count == 0) {
        self.currentSongTitle = @"";  // если у трека не указано названия композиции, то использовать "пустоту"
    } else {
        AVMetadataItem *title = [titles objectAtIndex:0];           // если у трека указано название композиции,
        self.currentSongTitle = [title.value copyWithZone:nil];     // то использовать его
    }
    
    return self.currentSongTitle;    // Возвращаю название трека
}

-(NSString*) getSongArtist:(NSString*) song {   // Получение имени исполнителя
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];    // Определяю путь к треку
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];  // Инициализирую ассета по url
    
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                      withKey:AVMetadataCommonKeyArtist
                                                     keySpace:AVMetadataKeySpaceCommon];   // Нахожу имя исполнителя трека с помощью ассета по ключу
    
    if (artists.count == 0) {
        self.currentSongArtist = @"";  // если у трека не указано имени исполнителя, то использовать "пустоту"
    } else {
        AVMetadataItem *artist = [artists objectAtIndex:0];         // если у трека указано имени исполнителя,
        self.currentSongArtist = [artist.value copyWithZone:nil];   //то использовать его
    }
    
    return self.currentSongArtist;    // Возвращаю имя исполнителя
}

-(UIImage*) getSongArtwork:(NSString*) song {   // Получение обложки альбома
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];    // Определяю путь к треку
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];  // Инициализирую ассета по url
    
    NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                       withKey:AVMetadataCommonKeyArtwork
                                                      keySpace:AVMetadataKeySpaceCommon];   // Нахожу обложку трека с помощью ассета по ключу
    
    if (artworks.count == 0) {
        self.currentSongArtwork = [UIImage imageNamed:@"Artwork.jpg"];  // если в треки не зашита обложка альбома, то использовать красный квадрат
    } else {
        AVMetadataItem *artwork = [artworks objectAtIndex:0];                                   // если у трека указана обложка альбома,
        self.currentSongArtwork = [UIImage imageWithData:[artwork.value copyWithZone:nil]];     // то использовать ее
    }
    
    return self.currentSongArtwork;    // Возвращаю обложку альбома
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;   // В таблице будет одна секция
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfSongs count];   // Количество строк в таблице равно клоичеству треков
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
