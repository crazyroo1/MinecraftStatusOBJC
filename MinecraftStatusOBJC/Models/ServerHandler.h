//
//  ServerHandler.h
//  MinecraftStatusOBJC
//
//  Created by Turner Eison on 3/29/20.
//  Copyright © 2020 Turner Eison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServerHandler : NSObject

@property NSString *address;

@property (weak) id<ServerDelegate> handler;

- (void) refreshServer;

@end

NS_ASSUME_NONNULL_END
