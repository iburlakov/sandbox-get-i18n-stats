//
//  StringsFile.m
//  sandbox-i18n-strings
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import "StringsFile.h"

@implementation StringsFile

- (id)initWithFile:(NSString *)path {
    self = [super init];
    if (self) {
        filepath = path;
        
        stringsCount = 0;
        wordsCount = 0;
        
        NSError *err;
        regex = [[NSRegularExpression alloc] initWithPattern:@"^(\".+\")? = \"(.+)\""
                                                                          options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
                                                                            error:&err];
    }
    
    return self;
}

- (void)calc {
    NSString *content = [self readContentOf:filepath];
    
    // get strings that should be localized
    NSArray *matches = [regex matchesInString:content
                                      options:0
                                        range:NSMakeRange(0,content.length)];
    
    // iterate over each string
    for (NSTextCheckingResult *match in  matches) {
        if (match) {
            NSString *str = [content substringWithRange:[match rangeAtIndex:1]];

            stringsCount++;
            wordsCount += [str componentsSeparatedByString:@" "].count;
        }
    }
}

- (void)generatePseudo {
    NSString *content = [self readContentOf:filepath];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:content
                                                               options:0
                                                                 range:NSMakeRange(0, content.length)
                                                          withTemplate:@"$1 = \"$$$2$$\""];
    
    [self save:modifiedString];
}

- (NSString *)readContentOf:(NSString *)path {
    NSError *err;
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&err];
    
    if (err) {
        [NSException raise:@"Could not open file" format:@"Could not open file %@: %@", filepath, err];
    }
    
    return content;
}

- (void)save:(NSString *)string{
    NSString *fileName = [NSString stringWithFormat:@"%@.pseudo", filepath];

    [string writeToFile:fileName
              atomically:NO
                encoding:NSUTF8StringEncoding
                   error:nil];
    
    NSLog(@"Saved %@", fileName);
}


- (int)strings {
    return stringsCount;
}

- (int)words {
    return wordsCount;
}

@end
