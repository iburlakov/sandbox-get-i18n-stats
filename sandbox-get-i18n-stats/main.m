//
//  main.m
//  sandbox-get-i18n-stats
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringsFileStats.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        if (argc < 2) {
            NSLog(@"File path is missed");
            return 0;
        }
        
        NSString *path = [NSString stringWithUTF8String:argv[1]];
        
        NSLog(@"Got %@ for analysis", path);
        
        StringsFileStats *stats = [[StringsFileStats alloc] initWithFile:path];
        
        [stats calc];
        
        NSLog(@"Stats for %@\n\t\tStrings: %i\n\t\tWords: %i", [path lastPathComponent], stats.strings, stats.words);

        // TODO: go...
    }
    return 0;
}
