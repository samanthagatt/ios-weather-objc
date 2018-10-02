//
//  ViewController.h
//  WeatherObjC
//
//  Created by Spencer Curtis on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMFDailyForecastController;

@interface SMFViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>

@property SMFDailyForecastController *dailyForecastController;

@property (weak, nonatomic) IBOutlet UISearchBar *zipCodeSearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *forecastCollectionView;

@end

