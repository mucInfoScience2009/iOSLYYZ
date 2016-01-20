//
//  StringUtil.m

#import "NSString+Utilities.h"
#import <CommonCrypto/CommonDigest.h>
#import "pinyin.h"
#import "ChineseSample.h"

// http://www.wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing) {
	return thing == nil ||
	([thing isEqual:[NSNull null]]) ||
	([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
	([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

@implementation NSString (NSStringUtils)

- (NSString *)stringWithMaxLength:(NSUInteger)maxLen {
  NSUInteger length = [self length];
  if (length <= maxLen || length <= 3) {
    return self;
  }else {
    return [NSString stringWithFormat:@"%@...", [self substringToIndex:maxLen - 3]];
  }
}


- (NSString *)urlWithoutParameters {
  NSRange r;
  NSString *newUrl;

  r = [self rangeOfString:@"?" options: NSBackwardsSearch];
  if (r.length > 0)
    newUrl = [self substringToIndex: NSMaxRange (r) - 1];
  else
    newUrl = self;

  return newUrl;
}

- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString {
  NSInteger bufferSize;
  NSInteger selfLen = [self length];
  NSInteger aStringLen = [aString length];
  unichar *buffer;
  NSRange localRange;
  NSString *result;

  bufferSize = selfLen + aStringLen - aRange.length;
  buffer = NSAllocateMemoryPages(bufferSize*sizeof(unichar));

  /* Get first part into buffer */
  localRange.location = 0;
  localRange.length = aRange.location;
  [self getCharacters:buffer range:localRange];

  /* Get middle part into buffer */
  localRange.location = 0;
  localRange.length = aStringLen;
  [aString getCharacters:(buffer+aRange.location) range:localRange];

  /* Get last part into buffer */
  localRange.location = aRange.location + aRange.length;
  localRange.length = selfLen - localRange.location;
  [self getCharacters:(buffer+aRange.location+aStringLen) range:localRange];

  /* Build output string */
  result = [NSString stringWithCharacters:buffer length:bufferSize];

  NSDeallocateMemoryPages(buffer, bufferSize);

  return result;
}

- (NSString *)trimmedString
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)htmlDecodedString
{
	NSMutableString *temp = [NSMutableString stringWithString:self];
	
	[temp replaceOccurrencesOfString:@"&amp;" withString:@"&" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"&gt;" withString:@">" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"&lt;" withString:@"<" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"&apos;" withString:@"'" options:0 range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&nbsp;" withString:@" " options:0 range:NSMakeRange(0, [temp length])];
	
	return [NSString stringWithString:temp];
}

- (NSString *)htmlEncodedString
{
	NSMutableString *temp = [NSMutableString stringWithString:self];
	
	[temp replaceOccurrencesOfString:@"&" withString:@"&amp;" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@">" withString:@"&gt;" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"<" withString:@"&lt;" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:0 range:NSMakeRange(0, [temp length])];
	[temp replaceOccurrencesOfString:@"'" withString:@"&apos;" options:0 range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@" " withString:@"&nbsp;" options:0 range:NSMakeRange(0, [temp length])];
	return [NSString stringWithString:temp];
}

/*
 * source: http://stackoverflow.com/questions/1967399/parse-nsurl-path-and-query-iphoneos
 */
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode = [(NSString *)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1] forKey:[secondExplode objectAtIndex:0]];
        }
    }
    
    return returnDictionary;
}

- (NSMutableDictionary *)explodeToDictionaryInnerGlueUTF8Decode:(NSString *)innerGlue outterGlue:(NSString *)outterGlue isCompatibleMode:(BOOL) isCompatibleMode
{
    NSMutableDictionary *srcDictionary = [self explodeToDictionaryInnerGlue:innerGlue outterGlue:outterGlue];
    
    NSEnumerator* keyEnum = [srcDictionary keyEnumerator];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionary];
    id key = nil;
    NSString* src = nil;
    NSString* dec = nil;
    while (key = [keyEnum nextObject])
    {
        src = [srcDictionary objectForKey:key];
        if ([src isKindOfClass:[NSString class]])
        {
            if (isCompatibleMode)
            {
                src = [src stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
            }
            dec = [src stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([dec length] > 0)
            {
                src = dec;
            }
        }
        if (key && [key lowercaseString])
        {
            [returnDictionary setObject:src forKey:[key lowercaseString]];
        }
    }
    
    return returnDictionary;
}

+ (NSString *)firstNonNsNullStringWithString:(NSString*)string, ...
{
    NSString* result = nil;
    
    id arg = nil;
    va_list argList;
    
    if (string && [string isKindOfClass:[NSString class]])
    {
        return string;
    }
    
    va_start(argList, string);
    while ((arg = va_arg(argList, id)))
    {
        if (arg && [arg isKindOfClass:[NSString class]])
        {
            result = arg;
            break;
        }
    }
    va_end(argList);
    
    
    return result;
}

@end


@implementation NSString  (UUID)
+ (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *UUIDstring = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return UUIDstring;
}
@end

@implementation NSString  (RangeAvoidance)
- (BOOL) hasSubstring:(NSString*)substring;
{
	if(IsEmpty(substring))
		return NO;
	NSRange substringRange = [self rangeOfString:substring];
	return substringRange.location != NSNotFound && substringRange.length > 0;
}

- (NSString*) substringAfterSubstring:(NSString*)substring;
{
	if([self hasSubstring:substring])
		return [self substringFromIndex:NSMaxRange([self rangeOfString:substring])];
	return nil;
}

//Note: -isCaseInsensitiveLike should work when avalible!
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;
{
	if(!otherString)
		return NO;
	return NSOrderedSame == [self compare:otherString options:NSCaseInsensitiveSearch + NSWidthInsensitiveSearch];
}
@end


@implementation NSString (IndempotentPercentEscapes)
- (NSString*) stringByReplacingPercentEscapesOnce;
{
	NSString *unescaped = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//self may be a string that looks like an invalidly escaped string,
	//eg @"100%", in that case it clearly wasn't escaped,
	//so we return it as our unescaped string.
	return unescaped ? unescaped : self;
}
- (NSString*) stringByAddingPercentEscapesOnce;
{
	return [[self stringByReplacingPercentEscapesOnce] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(CGRect)txtFrameWith:(UIFont *)font andMaxWidth:(CGFloat)maxW{
    return [self boundingRectWithSize:CGSizeMake(maxW, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
}
-(CGRect)txtFrameWith:(UIFont *)font lineSpacing:(CGFloat)spacing andMaxWidth:(CGFloat)maxW{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = spacing;// 字体的行间距
    return [self boundingRectWithSize:CGSizeMake(maxW, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil] context:nil];
}

-(CGRect)getTextFrame:(UIFont *)font andMaxWidth:(CGFloat)maxW{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    return [self boundingRectWithSize:CGSizeMake(maxW, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil] context:nil];
}

-(NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//手机号码验证
- (BOOL) validateMobile
{
    //手机号以13,15,18,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (NSString *)htmlConDelete{
    if (!self) {
        return self;
    }
    NSMutableString *muString = [NSMutableString stringWithString:self];
    NSString *regexStr = @"<([^>]*)>";
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:nil];
    NSArray *matches = [regexExp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSMutableArray *arrMatchStr = [NSMutableArray array];
    NSRange range[10] ={};
    int i = 0;
    
    for (NSTextCheckingResult *result in [matches objectEnumerator]) {
        NSRange matchRange = [result range];
        range[i] = matchRange;
        NSString *matchStr = [muString substringWithRange:matchRange];
        [arrMatchStr addObject:matchStr];
        i++;
    }
    
    for (int i=0; i<arrMatchStr.count; i++) {
        [muString replaceOccurrencesOfString:arrMatchStr[i] withString:@"" options:0 range:NSMakeRange(0, [muString length])];
    }
    return muString;
}


- (NSString *)getAllString
{
    NSString *str = @"";
    NSArray *charArray = [self getCharacterArray];
    for (NSString *charStr in charArray) {
        str = [str stringByAppendingString:[ChineseSample pinyinFromChiniseString:charStr]];
    }
    return str;
}

-(NSString *)getCapitalString{
    NSMutableArray *CapitalArray = [NSMutableArray array];
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range = [self rangeOfString:@"重庆"];
    if (range.length) {
        [newStr replaceCharactersInRange:range withString:@"虫庆"];
    }
    NSArray *charArray  = [newStr getCharacterArray];
    for (NSString *charStr in charArray) {
        NSString *Capital =[NSString stringWithFormat:@"%c",[charStr getfirstCharacterPinyin]];
        [CapitalArray addObject:Capital];
    }
    return [CapitalArray componentsJoinedByString:@""];
}
//返回大写首字母
-(char)getfirstCharacterPinyin{
    NSString *firstCharStr = [self substringToIndex:1];
    char firstChar;
    if ([firstCharStr getUnicodeCode]<= 122 && [firstCharStr getUnicodeCode]>=97) {
        firstChar = *[firstCharStr UTF8String]-32;
    }else if ([firstCharStr getUnicodeCode]< 97){
        firstChar = *[firstCharStr UTF8String];
    }else{
        firstChar =   pinyinFirstLetter([self characterAtIndex:0]) -32;
    }
    return firstChar;
}
//得到汉字的Unicode编码
-(unsigned int)getUnicodeCode{
    const char *character = [self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    unsigned int *unicode = (unsigned int *)character;
    return *unicode;
}

-(NSArray *)getCharacterArray{
    NSMutableArray *characterArr = [NSMutableArray array];
    for ( int i=0; i<self.length; i++) {
        NSString *charStr = [self substringWithRange:NSMakeRange(i,1)];
        [characterArr addObject:charStr];
    }
    return characterArr;
}

@end

@implementation NSString (OpenAccountCheck)

- (BOOL)isValidRealName {
    NSString *pattern = @"[\\u4E00-\\u9FA5]{1,7}(?:\\u00B7[\\u4E00-\\u9FA5]{1,7}){0,2}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isValidPinyin {
    NSString *pattern = @"[A-Za-z]{0,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)stringByRemovingHtmlTag {
    NSString *ret = [self copy];
    NSRange range;
    while ((range = [ret rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        ret = [ret stringByReplacingCharactersInRange:range withString:@""];
    }
    return ret;
}

@end
