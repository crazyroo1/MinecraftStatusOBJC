//
//  ServerDelegateProtocol.h
//  MinecraftStatusOBJC
//
//  Created by Turner Eison on 3/30/20.
//  Copyright © 2020 Turner Eison. All rights reserved.
//

#ifndef ServerDelegateProtocol_h
#define ServerDelegateProtocol_h
@protocol ServerDelegate

-(void) serverReceivedUpdate :(NSDictionary *) object;

@end

#endif /* ServerDelegateProtocol_h */
