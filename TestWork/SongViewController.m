//
//  SongViewController.m
//  TestWork
//
//  Created by Stepan Chegrenev on 17.01.16.
//  Copyright © 2016 Stepan Chegrenev. All rights reserved.
//

#import "SongViewController.h"
#import "ViewController.h"

@import AVFoundation;

@interface SongViewController ()

@property(strong, nonatomic) AVAudioPlayer* audioPlayer;    // объявление плеера как свойство

@end

@implementation SongViewController

{
    UIButton* playButton;   // Объявляю кнопку проигрывания
    UIButton* pauseButton;  // Объявляю кнопку паузы
    UIButton* stopButton;   // Объявляю кнопку остановки
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect myView = self.view.frame;    // Подготовка размера обложки
    myView.origin.y = 65;
    myView.origin.x = (CGRectGetWidth(myView)-280) / 2;
    myView.size = CGSizeMake(280, 280);
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:myView];  // Инициализация imgView для обложки
    imgView.image = self.imageArtwork;  // присваивание imgView
    [self.view addSubview:imgView]; // Добавление обложки
    
    UILabel* artistName = [[UILabel alloc] initWithFrame:CGRectMake(10, 355, ((CGRectGetWidth(self.view.frame)/2)-20), 20)];  // Инициализация UILabel для имени исполнителя
    artistName.text = self.artistName;
    [self.view addSubview:artistName]; // Добавление имени исполнителя
    
    UILabel* songName = [[UILabel alloc] initWithFrame:CGRectMake(((CGRectGetWidth(self.view.frame)/2)+ 10), 355, ((CGRectGetWidth(self.view.frame)/2)-20), 20)];  // Инициализация UILabel для названия композиции
    songName.text = self.songName;
    [self.view addSubview:songName]; // Добавление названия композиции
    
    UILabel* albumName = [[UILabel alloc] initWithFrame:CGRectMake(10, 385, ((CGRectGetWidth(self.view.frame)/2)-20), 20)];  // Инициализация UILabel для названия альбома
    albumName.text = self.albumName;
    [self.view addSubview:albumName]; // Добавление названия альбома
    
    UILabel* creator = [[UILabel alloc] initWithFrame:CGRectMake(((CGRectGetWidth(self.view.frame)/2)+ 10), 385, ((CGRectGetWidth(self.view.frame)/2)-20), 20)];  // Инициализация UILabel для имени композитора
    creator.text = self.creator;
    [self.view addSubview:creator]; // Добавление имени композитора
    
    pauseButton = [UIButton buttonWithType:UIButtonTypeCustom]; // Инициализация кнопки паузы
    pauseButton.frame = CGRectMake(((CGRectGetWidth(self.view.frame)/2)-25), (CGRectGetHeight(self.view.frame)-80), 50, 50);    // Подготовка размера кнопки
    UIImage* imageOfPauseButton = [UIImage imageNamed:@"PauseButton.png"];      // Выбор изображения кнопки
    [pauseButton setImage:imageOfPauseButton forState:UIControlStateNormal];    // Установка изображения кнопки
    [self.view addSubview:pauseButton];     // Добавление кнопки
    [pauseButton addTarget:self action:@selector(pauseButtonPressed) forControlEvents:UIControlEventTouchUpInside];     // Добавление действия для кнопки
    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];  // Инициализация кнопки проигрывания
    playButton.frame = CGRectMake(((CGRectGetWidth(self.view.frame)/2)+55), (CGRectGetHeight(self.view.frame)-80), 50, 50); // Подготовка размера кнопки
    UIImage* imageOfPlayButton = [UIImage imageNamed:@"playButton.png"];    // Выбор изображения кнопки
    [playButton setImage:imageOfPlayButton forState:UIControlStateNormal];  // Установка изображения кнопки
    [self.view addSubview:playButton];      // Добавление кнопки
    [playButton addTarget:self action:@selector(playButtonPressed) forControlEvents:UIControlEventTouchUpInside];       // Добавление действия для кнопки
    
    stopButton = [UIButton buttonWithType:UIButtonTypeCustom];  // Инициализация кнопки остановки
    stopButton.frame = CGRectMake(((CGRectGetWidth(self.view.frame)/2)-105), (CGRectGetHeight(self.view.frame)-80), 50, 50);    // Подготовка размера кнопки
    UIImage* imageOfstopButton = [UIImage imageNamed:@"stopButton.png"];    // Выбор изображения кнопки
    [stopButton setImage:imageOfstopButton forState:UIControlStateNormal];  // Установка изображения кнопки
    [self.view addSubview:stopButton];      // Добавление кнопки
    [stopButton addTarget:self action:@selector(stopButtonPressed) forControlEvents:UIControlEventTouchUpInside];       // Добавление действия для кнопки
    
    [self setupAudio];  // Вызов метода setupAudio
    
}

-(void) setupAudio {    // Настройка воспроизведения
    NSError* err;
    [[AVAudioSession sharedInstance] setActive:YES error:&err];     // Активировать аудиосессию
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&err];    // Перевожу в беззвучный режим любое аудио, воспроизводимое в других приложениях
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.fileURL error: &err];  // инициализация плеера с аудиофайлом
    
    [self.audioPlayer prepareToPlay];   // Подготовка аудио к воспроизведению
}

-(void) playButtonPressed {     // Нажатие кнопки воспроизведения
    [self.audioPlayer play];    // Вызвать метод восроизведения
}

-(void) pauseButtonPressed {            // Нажатие кнопки паузы
    if ([self.audioPlayer play]) {      // Если вызван метод воспроизведения,
        [self.audioPlayer pause];       // то, вызвать метод паузы
    }
}

-(void) stopButtonPressed {                 // Нажатие кнопки остановки
    if ([self.audioPlayer play]) {          // Если вызван метод воспроизведения,
        [self.audioPlayer stop];            // то, вызвать метод остановки
        self.audioPlayer.currentTime = 0;   // и обнулить текущее время
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
