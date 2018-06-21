//
//  MersenneTwister.h
//  MersenneTwister
//
//  Created by Wojciech on 20.06.2018.
//  Copyright © 2018 Wojciech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MersenneTwister : NSObject

// Fields:
@property uint32_t* mt;
@property uint32_t index;

// Methods:
- (id)initWithSeed:(uint32_t)seed;
- (uint32_t)random;
- (void)twist;

@end
