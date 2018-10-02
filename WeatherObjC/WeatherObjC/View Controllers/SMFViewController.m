//
//  ViewController.m
//  WeatherObjC
//
//  Created by Spencer Curtis on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "SMFViewController.h"
#import "SMFDailyForecastController.h"
#import "SMFCollectionViewCell.h"
#import "SMFDailyForecast.h"

@interface SMFViewController ()

@end

@implementation SMFViewController

#pragma mark Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dailyForecastController = [[SMFDailyForecastController alloc] init];
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dailyForecastController = [[SMFDailyForecastController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self zipCodeSearchBar] setDelegate:self];
    [[self forecastCollectionView] setDelegate:self];
    [[self forecastCollectionView] setDataSource:self];
}


#pragma mark Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[self dailyForecastController] fetchDailyForecastsByZipCode:[[self zipCodeSearchBar] text] completionHandler:^(NSArray *dailyForecasts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self forecastCollectionView] reloadData];
        });
    }];
    [[self forecastCollectionView] reloadData];
}


#pragma mark Collection view data source

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[self dailyForecastController] dailyForecasts] count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SMFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell" forIndexPath:indexPath];
    
    SMFDailyForecast *dailyForecast = [[[self dailyForecastController] dailyForecasts] objectAtIndex:[indexPath row]];
    [[cell weatherImageView] setImage:[dailyForecast weatherImage]];
    NSString *tempString = [[NSNumber numberWithFloat:[dailyForecast temp]] stringValue];
    [[cell tempLabel] setText:tempString];
    [[cell cityLabel] setText:[dailyForecast cityName]];
    
    return cell;
}

@end
