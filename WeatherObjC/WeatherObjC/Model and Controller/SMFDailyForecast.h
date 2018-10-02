//
//  SMFDailyForecast.h
//  WeatherObjC
//
//  Created by Samantha Gatt on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMFDailyForecast : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary cityName:(NSString *)cityName;

@property UIImage *weatherImage;
@property float temp;
@property NSString *cityName;

@end

NS_ASSUME_NONNULL_END
