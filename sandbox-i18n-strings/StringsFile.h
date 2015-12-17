//
//  StringsFile.h
//  sandbox-i18n-strings
//
//  Created by Ivan Burlakov on 14/12/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringsFile : NSObject {
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
