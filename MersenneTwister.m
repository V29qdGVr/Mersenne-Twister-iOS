//
//  MersenneTwister.m
//  MersenneTwister
//
//  Created by Wojciech on 20.06.2018.
//  Copyright © 2018 Wojciech. All rights reserved.
//

#import "MersenneTwister.h"

// Constants
const int A =           0b10011001000010001011000011011111; // 2567483615 // 0x9908B0DF
const int B =           0b10011101001011000101011010000000; // 2636928640 // 0x9D2C5680
const int C =           0b11101111110001100000000000000000; // 4022730752 // 0xEFC60000
const int D =           0b11111111111111111111111111111111; // 4294967295 // 0xFFFFFFFF
const int F =           0b01101100000001111000100101100101; // 1812433253 // 0x6C078965
const int L =           0b00000000000000000000000000010010; // 0000000018 // 0x00000012
const int M =           0b00000000000000000000000110001101; // 0000000397 // 0x0000018D
const int N =           0b00000000000000000000001001110000; // 0000000624 // 0x00000270
const int R =           0b00000000000000000000000000011111; // 0000000031 // 0x0000001F
const int S =           0b00000000000000000000000000000111; // 0000000007 // 0x00000007
const int T =           0b00000000000000000000000000001111; // 0000000015 // 0x0000000F
const int U =           0b00000000000000000000000000001011; // 0000000011 // 0x0000000B
const int W =           0b00000000000000000000000000100000; // 0000000032 // 0x00000020
const int MASK_LOWER =  0b01111111111111111111111111111111; // 2147483647 // 0x7FFFFFFF
const int MASK_UPPER =  0b10000000000000000000000000000000; // 2147483648 // 0x80000000

@implementation MersenneTwister

- (id)initWithSeed:(uint32_t)seed {
    self = [super init];
    if (self) {
        uint32_t mt[N]; self.mt = mt;
        self.mt[0] = seed;
        self.index = N;

        for (uint32_t i = 1; i < N; i++) {
            self.mt[i] = (F * (self.mt[i - 1] ^ (self.mt[i - 1] >> 30)) + i);
        }
    }
    return self;
}

- (uint32_t)random {
    int i = self.index;
    if (self.index >= N) {
        [self twist];
        i = self.index;
    }
    
    uint32_t y = self.mt[i];
    self.index = i + 1;
    
    y ^= (y >> U);
    y ^= (y << S) & B;
    y ^= (y << T) & C;
    y ^= (y >> L);
    
    return y;
}

- (void)twist {
    for (uint32_t i = 0; i < N; i++) {
        uint32_t x = (self.mt[i] & MASK_UPPER) + (self.mt[(i + 1) % N] & MASK_LOWER);
        uint32_t xA = x >> 1;
        if (x & 0x1) {
            xA ^= A;
        }
        self.mt[i] = self.mt[(i + M) % N] ^ xA;
    }
    self.index = 0;
}

@end
