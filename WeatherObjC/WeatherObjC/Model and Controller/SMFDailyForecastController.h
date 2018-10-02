//
//  SMFDailyForecastController.h
//  WeatherObjC
//
//  Created by Samantha Gatt on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMFDailyForecastController : NSObject

@property NSArray *dailyForecasts;

- (void)fetchDailyForecastsByZipCode:(NSString *)zipCode completionHandler:(void (^)(NSArray *dailyForecasts, NSError *))completionHandler;

@end

NS_ASSUME_NONNULL_END
