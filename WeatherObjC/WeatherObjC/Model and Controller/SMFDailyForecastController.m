//
//  SMFDailyForecastController.m
//  WeatherObjC
//
//  Created by Samantha Gatt on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "SMFDailyForecastController.h"
#import "SMFDailyForecast.h"


@interface SMFDailyForecastController ()

@property NSMutableArray *internalArray;

@end



#pragma mark -

@implementation SMFDailyForecastController

static NSString * const baseURLString = @"api.openweathermap.org/data/2.5/forecast/daily";
static NSString * const apiKey = @"b0af1af927bf7128f57f01707c1f1459";

#pragma mark Initializer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark External properties

- (NSArray *)dailyForecasts
{
    return [self internalArray];
}
- (void)setDailyForecasts:(NSArray *)dailyForecasts
{
    return;
}

#pragma mark Network fetching

- (void)fetchDailyForecastsByZipCode:(NSString *)zipCode completionHandler:(void (^)(NSArray *people, NSError *))completionHandler
{
    #pragma mark url construction
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *zipCodeQuery = [NSURLQueryItem queryItemWithName:@"zip" value:zipCode];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"APPID" value:apiKey];
    
    [urlComponents setQueryItems:@[zipCodeQuery, apiQuery]];
    NSURL *url = [urlComponents URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    #pragma mark NSURLSession
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
        
        #pragma mark Error handling
        
        if (error) {
            NSLog(@"Error fetching data %@", error);
            completionHandler(nil, error);
            return;
        }
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary");
            completionHandler(nil, [[NSError alloc] init]);
            return;
        }
        
        #pragma mark JSON parsing
        
        NSString *cityName = [dictionary[@"city"] objectForKey:@"name"];
        NSArray *dailyForecastsArray = dictionary[@"list"];
        NSMutableArray *dailyForecasts = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in dailyForecastsArray) {
            SMFDailyForecast *dailyForecast = [[SMFDailyForecast alloc] initWithDictionary:dictionary cityName:cityName];
            [dailyForecasts addObject:dailyForecast];
        }
        
    }] resume];
}

@end
