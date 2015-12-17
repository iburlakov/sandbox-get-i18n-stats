//
//  StringsFileStats.h
//  sandbox-get-i18n-stats
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringsFileStats : NSObject {
    NSString *filepath;
    NSRegularExpression *regex;
    
    int stringsCount;
    int wordsCount;
}

- (id)initWithFile:(NSString *)path;

- (void)calc;

- (void)generatePseudo;

- (int)strings;
- (int)words;

@end
