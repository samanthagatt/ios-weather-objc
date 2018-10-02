//
//  SMFDailyForecast.m
//  WeatherObjC
//
//  Created by Samantha Gatt on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "SMFDailyForecast.h"

@implementation SMFDailyForecast

-(instancetype)initWithImageName:(NSString *)imageName temp:(float)temp cityName:(NSString *)cityName
{
    self = [super init];
    
    if (self) {
        _weatherImage = [UIImage imageNamed:imageName];
        _temp = ((temp-273.0)*1.8)+32.0;
        _cityName = cityName;
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary cityName:(NSString *)cityName
{
    NSArray *imgNameArray = dictionary[@"weather"];
    NSDictionary *imgNameDict = imgNameArray[0];
    NSString *imageName = imgNameDict[@"icon"];
    
    NSDictionary *tempDict = dictionary[@"temp"];
    NSNumber *tempNumber = tempDict[@"day"];
    float temp = [tempNumber floatValue];
    
    return  [self initWithImageName:imageName temp:temp cityName:cityName];
}

@end
