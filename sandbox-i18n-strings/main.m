//
//  main.m
//  sandbox-i18n-strings
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringsFile.h"

NSString *statsCommand = @"stats";
NSString *pseudoCommand = @"pseudo";

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        if (argc < 3) {
            NSLog(@"Usage: sandbox-i18n-strings <command> <strings-file-path> [--force]"
                  "\nCommands:"
                  "\n\tstats   Shows basic stats for given strings file: number of string and number of words"
                  "\n\tpseudo  Created a pseudolocalization strings files based on gived strigns file with following format: $$<original-string>$$"
                  "\nOptions:"
                  "\n\t--force  When pseudo is used, this option forces to rewrite origin file");
            
            return 0;
        }
        
        NSString *command = [NSString stringWithUTF8String:argv[1]];
        NSString *path = [NSString stringWithUTF8String:argv[2]];
        
        NSMutableArray *options = nil;
        if (argc > 3) {
            options = [NSMutableArray arrayWithCapacity:argc - 3];
            for (int i = 0; i < argc - 3; i++) {
                [options addObject:[NSString stringWithUTF8String:argv[i + 3]]];
            }
        }
        
        StringsFile *stringsFile = [[StringsFile alloc] initWithFile:path];
        if (NSOrderedSame == [command compare:statsCommand]) {
            [stringsFile calc];
            
            NSLog(@"Stats for %@\n\t\tStrings: %i\n\t\tWords: %i",
                  [path lastPathComponent],
                  stringsFile.strings,
                  stringsFile.words);
        } else if (NSOrderedSame == [command compare:pseudoCommand]) {
            
            BOOL rewrite = NO;
            if (nil != options) {
                rewrite = [options containsObject:@"--force"];
            }

            [stringsFile generatePseudo:rewrite];
        } else {
            NSLog(@"Unknown command");
        }
    }
    return 0;
}
