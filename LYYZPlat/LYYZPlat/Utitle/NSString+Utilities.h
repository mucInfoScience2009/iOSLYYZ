//
//  StringUtil.h
//  Peter Steinberger
//

@interface NSString (NSStringUtils)

- (NSString *)stringWithMaxLength:(NSUInteger)maxLen;
- (NSString *)urlWithoutParameters;
- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString;
- (NSString *)trimmedString;
- (NSString *)htmlDecodedString;
- (NSString *)htmlEncodedString;

+ (NSString *)firstNonNsNullStringWithString:(NSString*)string, ...;

// e.g. QueryString: param1=value1&param2=value2 , innerGlue:"=" , outterGlue:"&"
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue outterGlue:(NSString *)outterGlue;
- (NSMutableDictionary *)explodeToDictionaryInnerGlueUTF8Decode:(NSString *)innerGlue outterGlue:(NSString *)outterGlue isCompatibleMode:(BOOL) isCompatibleMode;

@end

@interface NSString (IndempotentPercentEscapes)
//uses UTF8 encoding, behavior is undefined if for other encodings.
- (NSString*) stringByAddingPercentEscapesOnce;
- (NSString*) stringByReplacingPercentEscapesOnce;
@end

@interface NSString (UUID)
//returns a new string built from a new UUID.
+ (NSString*) stringWithUUID;
@end

@interface NSString  (RangeAvoidance)
- (BOOL) hasSubstring:(NSString*)substring;
- (NSString*) substringAfterSubstring:(NSString*)substring;

//Note: -isCaseInsensitiveLike is probably a better alternitive if it's avalible.
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;


#pragma mark long_add 2015.9.28
- (CGRect)txtFrameWith:(UIFont *)font andMaxWidth:(CGFloat)maxW;
- (CGRect)txtFrameWith:(UIFont *)font lineSpacing:(CGFloat)spacing andMaxWidth:(CGFloat)maxW;
- (NSString *)getCapitalString;
- (NSString *)getAllString;
- (NSString *)md5;
- (BOOL) validateMobile;
- (NSString *)htmlConDelete;

#pragma mark long_end


-(CGRect)getTextFrame:(UIFont *)font andMaxWidth:(CGFloat)maxW;

@end

@interface NSString (OpenAccountCheck)

- (BOOL)isValidRealName;
- (BOOL)isValidPinyin;
- (NSString *)stringByRemovingHtmlTag;

@end


