//
//  StringsFileStats.m
//  sandbox-get-i18n-stats
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import "StringsFileStats.h"

@implementation StringsFileStats

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
    NSError *err;
    NSString *content = [NSString stringWithContentsOfFile:filepath
                                                  encoding:NSUTF8StringEncoding
                                                     error:&err];
    // get strings that should be localized
    NSArray *matches = [regex matchesInString:content
                                      options:0
                                        range:NSMakeRange(0,content.length)];
    
    // iterage over each string
    for (NSTextCheckingResult *match in  matches) {
        if (match) {
            NSString *str = [content substringWithRange:[match rangeAtIndex:1]];

            stringsCount++;
            wordsCount += [str componentsSeparatedByString:@" "].count;
        }
    }
}

- (int)strings {
    return stringsCount;
}

- (int)words {
    return wordsCount;
}

@end
