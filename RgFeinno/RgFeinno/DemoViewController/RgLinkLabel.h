//
//  RgLinkLabel.h
//  KILabelDemo
//
//  Created by rogue on 16/10/19.
//  Copyright © 2016年 Matthew Styles. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Constants for identifying link types we can detect
 */
typedef NS_ENUM(NSUInteger, RgLinkType)
{
    /**
     *  Usernames starting with "@" token
     */
    RgLinkTypeUserHandle,

};

/**
 *  Flags for specifying combinations of link types as a bitmask
 */
typedef NS_OPTIONS(NSUInteger, RgLinkTypeOption)
{
    /**
     *  No links
     */
    RgLinkTypeOptionNone = 0,
    
    /**
     *  Specifies to include KILinkTypeUserHandle links
     */
    RgLinkTypeOptionUserHandle = 1 << RgLinkTypeUserHandle,
    
    /**
     *  Convenience contstant to include all link types
     */
    RgLinkTypeOptionAll = NSUIntegerMax,
};


@class RgLinkLabel;

/**
 *  Type for block that is called when a link is tapped
 *
 *  @param label  The KILabel in which the tap took place
 *  @param string Content of the link that was tapped, includes @ or # tokens
 *  @param range  The range of the string within the label's text
 */
typedef void (^RgLinkTapHandler)(RgLinkLabel * label, NSString * string, NSRange range);

extern NSString * const RgLabelLinkTypeKey;
extern NSString * const RgLabelRangeKey;
extern NSString * const RgLabelLinkKey;

/**
 * A UILabel subclass that highlights links, hashtags and usernames and enables response to user
 * interactions with those links.
 **/
IB_DESIGNABLE
@interface RgLinkLabel : UILabel <NSLayoutManagerDelegate>

/** ****************************************************************************************** **
 * @name Setting the link detector
 ** ****************************************************************************************** **/

/**
 * Enable/disable automatic detection of links, hashtags and usernames.
 */
@property (nonatomic, assign, getter = isAutomaticLinkDetectionEnabled) IBInspectable BOOL automaticLinkDetectionEnabled;

/**
 * Specifies the combination of link types to detect. Default value is KILinkTypeAll.
 */
@property (nonatomic, assign) IBInspectable RgLinkTypeOption linkDetectionTypes;

/**
 * Set containing words to be ignored as links, hashtags or usernames.
 *
 * @discussion The comparison between the matches and the ignored words is case insensitive.
 */
@property (nullable, nonatomic, strong) NSSet *ignoredKeywords;

/** ****************************************************************************************** **
 * @name Format & Appearance
 ** ****************************************************************************************** **/

/**
 * The color used to highlight selected link background.
 *
 * @discussion The default value is (0.95, 0.95, 0.95, 1.0).
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *selectedLinkBackgroundColor;

/**
 * Flag sets if the sytem appearance for URLs should be used (underlined + blue color). Default value is NO.
 */
@property (nonatomic, assign) IBInspectable BOOL systemURLStyle;

/**
 * Get the current attributes for the given link type.
 *
 * @param linkType The link type to get the attributes.
 * @return A dictionary of text attributes.
 * @discussion Default attributes contain colored font using the tintColor color property.
 */
- (nullable NSDictionary*)attributesForLinkType:(RgLinkType)linkType;

/**
 * Set the text attributes for each link type.
 *
 * @param attributes The text attributes.
 * @param linkType The link type.
 * @discussion Default attributes contain colored font using the tintColor color property.
 */
- (void)setAttributes:(nullable NSDictionary*)attributes forLinkType:(RgLinkType)linkType;

/** ****************************************************************************************** **
 * @name Callbacks
 ** ****************************************************************************************** **/

/**
 * Callback block for KILinkTypeUserHandle link tap.
 **/
@property (nullable, nonatomic, copy) RgLinkTapHandler userHandleLinkTapHandler;

/**
 * Callback block for KILinkTypeHashtag link tap.
 */
@property (nullable, nonatomic, copy) RgLinkTapHandler hashtagLinkTapHandler;

/**
 * Callback block for KILinkTypeURL link tap.
 */
@property (nullable, nonatomic, copy) RgLinkTapHandler urlLinkTapHandler;

- (nullable NSDictionary*)linkAtPoint:(CGPoint)point;

// 给每个标签设置对应的字体属性

- (void)setLinkAttributes:(nullable NSArray *)attributes;

@end
