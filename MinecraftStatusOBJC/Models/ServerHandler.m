//
//  ServerHandler.m
//  MinecraftStatusOBJC
//
//  Created by Turner Eison on 3/29/20.
//  Copyright © 2020 Turner Eison. All rights reserved.
//

#import "ServerHandler.h"

@implementation ServerHandler


- (void)refreshServer {
    NSURL *url = [NSURL URLWithString:_address];
    NSURLSessionDataTask *session = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:NULL];
        
        NSString *motd = [NSString stringWithFormat:@"%@", json[@"motd"][@"clean"][0]];
        NSNumber *playersOnline = [NSNumber numberWithInteger:[json[@"players"][@"online"] integerValue]];
        NSNumber *maxPlayers = [NSNumber numberWithInteger: [json[@"players"][@"max"] integerValue]];
        
        NSDictionary *capturedValues = @{
            @"motd": motd,
            @"playersOnline": playersOnline,
            @"maxPlayers": maxPlayers
        };
        
        [self->_handler serverReceivedUpdate:capturedValues];
        
    }];
    [session resume];
}

@end
