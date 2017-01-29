//
//  ViewController.m
//  TestWork
//
//  Created by Stepan Chegrenev on 16.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@import AVFoundation;

@interface ViewController ()

@property (strong ,nonatomic) NSArray* arrayOfSongs;    // Объявляю массив как свойство, чтобы иметь доступ к нему в любом методе
@property (strong ,nonatomic) NSURL* fileURL;
@property (strong ,nonatomic) NSString* currentSongTitle;
@property (strong ,nonatomic) NSString* currentSongArtist;
@property (strong ,nonatomic) UIImage* currentSongArtwork;
@property (strong ,nonatomic) NSString* currentAlbumName;
@property (strong ,nonatomic) NSString* currentCreator;

@property(strong, nonatomic) AVAudioPlayer* audioPlayer;    // объявление плеера как свойство

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView* listOfSongs = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];    // инициализирую таблицу
    
    listOfSongs.delegate = self;    // Присваиваю текущий объект табличному виду в качестве делегата
    
    listOfSongs.dataSource = self;  // Присваиваю контроллер в качестве источника данных
    
    [self.view addSubview:listOfSongs]; // Добавляю таблицу
    
    self.arrayOfSongs = @[@"01 - Come Together", @"02 - I Don't Care", @"02 - The Take Over, the Breaks Over"]; // Наполняю массив треками(название файла композиции без расширения файла)
    
}

#pragma mark - Get info of song

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
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];
    
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                      withKey:AVMetadataCommonKeyArtist
                                                     keySpace:AVMetadataKeySpaceCommon];
    
    if (artists.count == 0) {
        self.currentSongArtist = @"";
    } else {
        AVMetadataItem *artist = [artists objectAtIndex:0];
        self.currentSongArtist = [artist.value copyWithZone:nil];
    }
    
    return self.currentSongArtist;
}

-(NSString*) getAlbumName:(NSString*) song {    // Получение названия альбома
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];
    
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    
    if (albumNames.count == 0) {
        self.currentAlbumName = @"";
    } else {
        AVMetadataItem *albumName = [albumNames objectAtIndex:0];
        self.currentAlbumName = [albumName.value copyWithZone:nil];
    }
    
    return self.currentAlbumName;
}

-(UIImage*) getSongArtwork:(NSString*) song {   // Получение обложки альбома
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];
    
    NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                       withKey:AVMetadataCommonKeyArtwork
                                                      keySpace:AVMetadataKeySpaceCommon];
    
    if (artworks.count == 0) {
        self.currentSongArtwork = [UIImage imageNamed:@"Artwork.jpg"];
    } else {
        AVMetadataItem *artwork = [artworks objectAtIndex:0];
        self.currentSongArtwork = [UIImage imageWithData:[artwork.value copyWithZone:nil]];
    }
    
    return self.currentSongArtwork;
}

-(NSString*) getCreator:(NSString*) song {  // Получение имени композитора
    self.fileURL = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileURL options:nil];
    
    NSArray *creators = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyCreator keySpace:AVMetadataKeySpaceCommon];
    
    if (creators.count == 0) {
        self.currentCreator = @"";
    } else {
        AVMetadataItem *creator = [creators objectAtIndex:0];
        self.currentCreator = [creator.value copyWithZone:nil];
    }
    
    return self.currentCreator;
}

#pragma mark - Change TableView

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;   // В таблице будет одна секция
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfSongs count];   // Количество строк в таблице равно клоичеству треков
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier = [[NSString alloc] initWithFormat:@"cell"];   // Иницализирую идентификатор повторного использования
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];   // Ищу ячейку в очереди таблицы
    
    if (cell==nil) {                                                                                                // Если не нашел ячейку в очереди,
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]; // то инициализировать ее
    }
    
    NSInteger index = [indexPath row];  // Здесь хранится номер строки таблицы
    
    cell.textLabel.text = [self getSongArtist:self.arrayOfSongs[index]];        //  Задаю название исполнителя для ячейки
    cell.detailTextLabel.text = [self getSongTitle:self.arrayOfSongs[index]];   //  Задаю название композиции для ячейки
    cell.imageView.image = [self getSongArtwork:self.arrayOfSongs[index]];      //  Задаю обложку альбома для ячейки
    
    return cell;    // Возвращаю ячейку
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SongViewController* vc = [[SongViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSInteger index = [indexPath row];
    
    vc.imageArtwork = [self getSongArtwork:self.arrayOfSongs[index]];   // Установка обложки альбома
    vc.artistName   = [self getSongArtist:self.arrayOfSongs[index]];
    vc.songName     = [self getSongTitle:self.arrayOfSongs[index]];
    vc.albumName    = [self getAlbumName:self.arrayOfSongs[index]];
    vc.creator      = [self getCreator:self.arrayOfSongs[index]];
    vc.fileURL      = self.fileURL;
    
    if ((self.audioPlayer.currentTime == 0) && (self.audioPlayer.isPlaying == NO)) {
        [self setupAudio];  // Вызов метода setupAudio
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setupAudio {    // Настройка воспроизведения
    NSError* err;
    [[AVAudioSession sharedInstance] setActive:YES error:&err];     // Активировать аудиосессию
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&err];    // Перевожу в беззвучный режим любое аудио, воспроизводимое в других приложениях
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.fileURL error: &err];  // инициализация плеера с аудиофайлом
    
    [self.audioPlayer prepareToPlay];   // Подготовка аудио к воспроизведению

    
}

-(void)play {
    if (![self.audioPlayer.url isEqual:self.fileURL]) {
        [self setupAudio];  // Вызов метода setupAudio
    }
    
    [self.audioPlayer play];    // Вызвать метод восроизведения
    
    NSLog(@"%@", self.audioPlayer.url);
    NSLog(@"%@", self.fileURL);
}

-(void)pause {
    if ([self.audioPlayer play]) {      // Если вызван метод воспроизведения,
        [self.audioPlayer pause];       // то, вызвать метод паузы
    }
}

-(void)stop {
    if ([self.audioPlayer play]) {          // Если вызван метод воспроизведения,
        [self.audioPlayer stop];            // то, вызвать метод остановки
        self.audioPlayer.currentTime = 0;   // и обнулить текущее время
    }
}

@end
