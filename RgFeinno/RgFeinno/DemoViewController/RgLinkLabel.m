//
//  RgLinkLabel.m
//  KILabelDemo
//
//  Created by rogue on 16/10/19.
//  Copyright © 2016年 Matthew Styles. All rights reserved.
//

#import "RgLinkLabel.h"

NSString * const RgLabelLinkTypeKey = @"rg_linkType";
NSString * const RgLabelRangeKey = @"rg_range";
NSString * const RgLabelLinkKey = @"rg_link";

// 记录 <a> 标签
NSString * const RgDeleteBeginKey = @"<a>";
NSString * const RgDeleteEndKey = @"</a>";

#pragma mark - Private Interface

@interface RgLinkLabel()

// Used to control layout of glyphs and rendering
@property (nonatomic, strong) NSLayoutManager *layoutManager;

// Specifies the space in which to render text
@property (nonatomic, strong) NSTextContainer *textContainer;

// Backing storage for text that is rendered by the layout manager
@property (nonatomic, strong) NSTextStorage *textStorage;

// Dictionary of detected links and their ranges in the text
@property (nonatomic, copy) NSArray *linkRanges;

// State used to trag if the user has dragged during a touch
@property (nonatomic, assign) BOOL isTouchMoved;

// During a touch, range of text that is displayed as selected
@property (nonatomic, assign) NSRange selectedRange;

// 标签的属性

@property (nonatomic, strong) NSMutableArray *rg_linkAttributes;

@end

#pragma mark - Implementation

@implementation RgLinkLabel
{
    NSMutableDictionary *_linkTypeAttributes;
}

#pragma mark - Construction

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupTextSystem];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupTextSystem];
    }
    
    return self;
}


- (void)setupTextSystem
{
    
    _textContainer = [[NSTextContainer alloc] init];
    _textContainer.lineFragmentPadding = 0;
    _textContainer.maximumNumberOfLines = self.numberOfLines;
    _textContainer.lineBreakMode = self.lineBreakMode;
    _textContainer.size = self.frame.size;
    
    // Create a layout manager for rendering
    _layoutManager = [[NSLayoutManager alloc] init];
    _layoutManager.delegate = self;
    [_layoutManager addTextContainer:_textContainer];
    
    // Attach the layou manager to the container and storage
    [_textContainer setLayoutManager:_layoutManager];
    
    // Make sure user interaction is enabled so we can accept touches
    self.userInteractionEnabled = YES;
    
    // Don't go via public setter as this will have undesired side effect
    _automaticLinkDetectionEnabled = YES;
    
    // All links are detectable by default
    _linkDetectionTypes = RgLinkTypeOptionAll;
    
    // Link Type Attributes. Default is empty (no attributes).
    _linkTypeAttributes = [NSMutableDictionary dictionary];
    
    // Don't underline URL links by default.
    _systemURLStyle = NO;
    
    // By default we hilight the selected link during a touch to give feedback that we are
    // responding to touch.
    _selectedLinkBackgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    // Establish the text store with our current text
    [self updateTextStoreWithText];
}

#pragma mark - Text and Style management

- (void)setAutomaticLinkDetectionEnabled:(BOOL)decorating
{
    _automaticLinkDetectionEnabled = decorating;
    
    // Make sure the text is updated properly
    [self updateTextStoreWithText];
}

- (void)setLinkDetectionTypes:(RgLinkTypeOption)linkDetectionTypes
{
    _linkDetectionTypes = linkDetectionTypes;
    
    // Make sure the text is updated properly
    [self updateTextStoreWithText];
}

- (NSDictionary *)linkAtPoint:(CGPoint)location
{
    // Do nothing if we have no text
    if (_textStorage.string.length == 0)
    {
        return nil;
    }
    
    // Work out the offset of the text in the view
    CGPoint textOffset = [self calcGlyphsPositionInView];
    
    // Get the touch location and use text offset to convert to text cotainer coords
    location.x -= textOffset.x;
    location.y -= textOffset.y;
    
    NSUInteger touchedChar = [_layoutManager glyphIndexForPoint:location inTextContainer:_textContainer];
    
    // If the touch is in white space after the last glyph on the line we don't
    // count it as a hit on the text
    NSRange lineRange;
    CGRect lineRect = [_layoutManager lineFragmentUsedRectForGlyphAtIndex:touchedChar effectiveRange:&lineRange];
    if (CGRectContainsPoint(lineRect, location) == NO)
        return nil;
    
    // Find the word that was touched and call the detection block
    for (NSDictionary *dictionary in self.linkRanges)
    {
        NSRange range = [[dictionary objectForKey:RgLabelRangeKey] rangeValue];
        
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length))
        {
            return dictionary;
        }
    }
    
    return nil;
}

// Applies background color to selected range. Used to hilight touched links
- (void)setSelectedRange:(NSRange)range
{
    // Remove the current selection if the selection is changing
    if (self.selectedRange.length && !NSEqualRanges(self.selectedRange, range))
    {
        [_textStorage removeAttribute:NSBackgroundColorAttributeName range:self.selectedRange];
    }
    
    // Apply the new selection to the text
    if (range.length && _selectedLinkBackgroundColor != nil)
    {
        [_textStorage addAttribute:NSBackgroundColorAttributeName value:_selectedLinkBackgroundColor range:range];
    }
    
    // Save the new range
    _selectedRange = range;
    
    [self setNeedsDisplay];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    [super setNumberOfLines:numberOfLines];
    
    _textContainer.maximumNumberOfLines = numberOfLines;
}

- (void)setText:(NSString *)text
{
    // Pass the text to the super class first
    [super setText:text];
    
    // Update our text store with an attributed string based on the original
    // label text properties.
    if (!text)
    {
        text = @"";
    }
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]}];//[self attributesFromProperties]
    [self updateTextStoreWithAttributedString:attributedText];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    // Pass the text to the super class first
    [super setAttributedText:attributedText];
    
    [self updateTextStoreWithAttributedString:attributedText];
}

- (void)setSystemURLStyle:(BOOL)systemURLStyle
{
    _systemURLStyle = systemURLStyle;
    
    // Force refresh
    self.text = self.text;
}

- (NSDictionary*)attributesForLinkType:(RgLinkType)linkType
{
    NSDictionary *attributes = _linkTypeAttributes[@(linkType)];
    
    if (!attributes)
    {
        attributes = @{NSForegroundColorAttributeName : self.tintColor};
    }
    
    return attributes;
}

- (void)setAttributes:(NSDictionary*)attributes forLinkType:(RgLinkType)linkType
{
    if (attributes)
    {
        _linkTypeAttributes[@(linkType)] = attributes;
    }
    else
    {
        [_linkTypeAttributes removeObjectForKey:@(linkType)];
    }
    
    // Force refresh text
    self.text = self.text;
}

#pragma mark - Text Storage Management

- (void)updateTextStoreWithText
{
    // Now update our storage from either the attributedString or the plain text
    if (self.attributedText)
    {
        [self updateTextStoreWithAttributedString:self.attributedText];
    }
    else if (self.text)
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:self.text attributes:[self attributesFromProperties]]];
    }
    else
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:@"" attributes:[self attributesFromProperties]]];
    }
    
    [self setNeedsDisplay];
}

- (void)updateTextStoreWithAttributedString:(NSAttributedString *)attributedString
{
    NSString *current = [attributedString.string stringByReplacingOccurrencesOfString:RgDeleteBeginKey withString:@""];
    current = [current stringByReplacingOccurrencesOfString:RgDeleteEndKey withString:@""];
    NSMutableAttributedString *currentAtt = [[NSMutableAttributedString alloc] initWithString:current];
    [currentAtt addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, currentAtt.length)];
    [currentAtt addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, currentAtt.length)];
    
    if (attributedString.length != 0)
    {
        attributedString = [RgLinkLabel sanitizeAttributedString:attributedString];
    }
    
    if (self.isAutomaticLinkDetectionEnabled && (attributedString.length != 0))
    {
        self.linkRanges = [self getRangesForLinks:attributedString];
        attributedString = [self addLinkAttributesToAttributedString:currentAtt linkRanges:self.linkRanges];
    }
    else
    {
        self.linkRanges = nil;
    }
    
    if (_textStorage)
    {
        // Set the string on the storage
        [_textStorage setAttributedString:attributedString];
    }
    else
    {
        // Create a new text storage and attach it correctly to the layout manager
        _textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
        [_textStorage addLayoutManager:_layoutManager];
        [_layoutManager setTextStorage:_textStorage];
    }
}

// Returns attributed string attributes based on the text properties set on the label.
// These are styles that are only applied when NOT using the attributedText directly.
- (NSDictionary *)attributesFromProperties
{
    // Setup shadow attributes
    NSShadow *shadow = shadow = [[NSShadow alloc] init];
    if (self.shadowColor)
    {
        shadow.shadowColor = self.shadowColor;
        shadow.shadowOffset = self.shadowOffset;
    }
    else
    {
        shadow.shadowOffset = CGSizeMake(0, -1);
        shadow.shadowColor = nil;
    }

    UIFont *currentFont = self.font;
    UIColor *currentColor = self.textColor;
    
    // Setup paragraph attributes
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = self.textAlignment;
    
    // Create the dictionary
    NSDictionary *attributes = @{NSFontAttributeName : currentFont,
                                 NSForegroundColorAttributeName : currentColor,
                                 NSShadowAttributeName : shadow,
                                 NSParagraphStyleAttributeName : paragraph,
                                 };
    return attributes;
}

/**
 *  Returns array of ranges for all special words, user handles, hashtags and urls in the specfied
 *  text.
 *
 *  @param text Text to parse for links
 *
 *  @return Array of dictionaries describing the links.
 */
- (NSArray *)getRangesForLinks:(NSAttributedString *)text
{
    NSMutableArray *rangesForLinks = [[NSMutableArray alloc] init];
    
    if (self.linkDetectionTypes & RgLinkTypeOptionUserHandle)
    {
        [rangesForLinks addObjectsFromArray:[self getRangesForUserHandles:text.string]];
    }

    return rangesForLinks;
}

- (NSArray *)getRangesForUserHandles:(NSString *)text
{
    NSMutableArray *rangesForUserHandles = [[NSMutableArray alloc] init];
    
    // Setup a regular expression for user handles and hashtags
    static NSRegularExpression *regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        regex = [[NSRegularExpression alloc] initWithPattern:@"<a>([\\w\\_]+)?</a>" options:0 error:&error];
    });
    
    // Run the expression and get matches
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    // Add all our ranges to the result
    NSInteger i = 0;
    NSInteger beginLen = 3;
    NSInteger endLen = 4;
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        if (![self ignoreMatch:matchString])
        {
            [rangesForUserHandles addObject:@{RgLabelLinkTypeKey : @(RgLinkTypeUserHandle),
                                              RgLabelRangeKey : [NSValue valueWithRange:NSMakeRange(matchRange.location - i * (beginLen + endLen), matchRange.length - (beginLen + endLen))],
                                              RgLabelLinkKey : [matchString substringWithRange:NSMakeRange(3, matchString.length - (beginLen + endLen))]
                                              }];
        }
        
        i++;
    }
    
    return rangesForUserHandles;
}

- (BOOL)ignoreMatch:(NSString*)string
{
    return [_ignoredKeywords containsObject:[string lowercaseString]];
}

- (NSAttributedString *)addLinkAttributesToAttributedString:(NSAttributedString *)string linkRanges:(NSArray *)linkRanges
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    NSInteger i = 0;
    for (NSDictionary *dictionary in linkRanges)
    {
        NSRange range = [[dictionary objectForKey:RgLabelRangeKey] rangeValue];

        [attributedString addAttributes:self.rg_linkAttributes[i] range:range];
        
        // Add an URL attribute if this is a URL
        if (_systemURLStyle)
        {
            // Add a link attribute using the stored link
            [attributedString addAttribute:NSLinkAttributeName value:dictionary[RgLabelLinkKey] range:range];
        }
        
        i++;
    }
    
    return attributedString;
}

#pragma mark - Layout and Rendering

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    // Use our text container to calculate the bounds required. First save our
    // current text container setup
    CGSize savedTextContainerSize = _textContainer.size;
    NSInteger savedTextContainerNumberOfLines = _textContainer.maximumNumberOfLines;
    
    // Apply the new potential bounds and number of lines
    _textContainer.size = bounds.size;
    _textContainer.maximumNumberOfLines = numberOfLines;
    
    // Measure the text with the new state
    CGRect textBounds = [_layoutManager usedRectForTextContainer:_textContainer];
    
    // Position the bounds and round up the size for good measure
    textBounds.origin = bounds.origin;
    textBounds.size.width = ceil(textBounds.size.width);
    textBounds.size.height = ceil(textBounds.size.height);
    
    if (textBounds.size.height < bounds.size.height)
    {
        // Take verical alignment into account
        CGFloat offsetY = (bounds.size.height - textBounds.size.height) / 2.0;
        textBounds.origin.y += offsetY;
    }
    
    // Restore the old container state before we exit under any circumstances
    _textContainer.size = savedTextContainerSize;
    _textContainer.maximumNumberOfLines = savedTextContainerNumberOfLines;
    
    return textBounds;
}

- (void)drawTextInRect:(CGRect)rect
{
    // Don't call super implementation. Might want to uncomment this out when
    // debugging layout and rendering problems.
    // [super drawTextInRect:rect];
    
    // Calculate the offset of the text in the view
    NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];
    CGPoint glyphsPosition = [self calcGlyphsPositionInView];
    
    // Drawing code
    [_layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:glyphsPosition];
    [_layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:glyphsPosition];
}

// Returns the XY offset of the range of glyphs from the view's origin
- (CGPoint)calcGlyphsPositionInView
{
    CGPoint textOffset = CGPointZero;
    
    CGRect textBounds = [_layoutManager usedRectForTextContainer:_textContainer];
    textBounds.size.width = ceil(textBounds.size.width);
    textBounds.size.height = ceil(textBounds.size.height);
    
    if (textBounds.size.height < self.bounds.size.height)
    {
        CGFloat paddingHeight = (self.bounds.size.height - textBounds.size.height) / 2.0;
        textOffset.y = paddingHeight;
    }
    
    return textOffset;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _textContainer.size = self.bounds.size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    _textContainer.size = self.bounds.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Update our container size when the view frame changes
    _textContainer.size = self.bounds.size;
}

- (void)setIgnoredKeywords:(NSSet *)ignoredKeywords
{
    NSMutableSet *set = [NSMutableSet setWithCapacity:ignoredKeywords.count];
    
    [ignoredKeywords enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [set addObject:[obj lowercaseString]];
    }];
    
    _ignoredKeywords = [set copy];
}

#pragma mark - Interactions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isTouchMoved = NO;
    
    // Get the info for the touched link if there is one
    NSDictionary *touchedLink;
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    touchedLink = [self linkAtPoint:touchLocation];
    
    if (touchedLink)
    {
        self.selectedRange = [[touchedLink objectForKey:RgLabelRangeKey] rangeValue];
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    _isTouchMoved = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    // If the user dragged their finger we ignore the touch
    if (_isTouchMoved)
    {
        self.selectedRange = NSMakeRange(0, 0);
        
        return;
    }
    
    // Get the info for the touched link if there is one
    NSDictionary *touchedLink;
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    touchedLink = [self linkAtPoint:touchLocation];
    
    if (touchedLink)
    {
        NSRange range = [[touchedLink objectForKey:RgLabelRangeKey] rangeValue];
        NSString *touchedSubstring = [touchedLink objectForKey:RgLabelLinkKey];
        RgLinkType linkType = (RgLinkType)[[touchedLink objectForKey:RgLabelLinkTypeKey] intValue];
        
        [self receivedActionForLinkType:linkType string:touchedSubstring range:range];
    }
    else
    {
        [super touchesBegan:touches withEvent:event];
    }
    
    self.selectedRange = NSMakeRange(0, 0);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    // Make sure we don't leave a selection when the touch is cancelled
    self.selectedRange = NSMakeRange(0, 0);
}

- (void)receivedActionForLinkType:(RgLinkType)linkType string:(NSString*)string range:(NSRange)range
{
    switch (linkType)
    {
        case RgLinkTypeUserHandle:
            if (_userHandleLinkTapHandler)
            {
                _userHandleLinkTapHandler(self, string, range);
            }
            break;
    }
}

#pragma mark - Layout manager delegate

-(BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    // Don't allow line breaks inside URLs
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    
    return !(linkURL && (charIndex > range.location) && (charIndex <= NSMaxRange(range)));
}

+ (NSAttributedString *)sanitizeAttributedString:(NSAttributedString *)attributedString
{
    // Setup paragraph alignement properly. IB applies the line break style
    // to the attributed string. The problem is that the text container then
    // breaks at the first line of text. If we set the line break to wrapping
    // then the text container defines the break mode and it works.
    // NOTE: This is either an Apple bug or something I've misunderstood.
    
    // Get the current paragraph style. IB only allows a single paragraph so
    // getting the style of the first char is fine.
    NSRange range;
    NSParagraphStyle *paragraphStyle = [attributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    
    if (paragraphStyle == nil)
    {
        return attributedString;
    }
    
    // Remove the line breaks
    NSMutableParagraphStyle *mutableParagraphStyle = [paragraphStyle mutableCopy];
    mutableParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    // Apply new style
    NSMutableAttributedString *restyled = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [restyled addAttribute:NSParagraphStyleAttributeName value:mutableParagraphStyle range:NSMakeRange(0, restyled.length)];
    
    return restyled;
}

#pragma mark - 给每个标签设置对应的字体属性

- (void)setLinkAttributes:(NSArray *)attributes {

    if(!self.rg_linkAttributes) {
    
        self.rg_linkAttributes = [[NSMutableArray alloc] init];
    
    }
    
    [self.rg_linkAttributes removeAllObjects];
    [self.rg_linkAttributes addObjectsFromArray:attributes];

}

@end
