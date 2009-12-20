//
// Copyright 2009 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20/TTTableStyleSheet.h"

#import "Three20/TTGlobalUI.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableStyleSheet

// Private common colors

// The standard highlighted color
- (UIColor*)highlightedColor {
  return [UIColor whiteColor];
}

// A lighter gray used for subtitles
- (UIColor*)secondaryColor {
  return RGBCOLOR(79, 89, 105);
}

// Captions and timestamps
- (UIColor*)blueCaptionColor {
  return RGBCOLOR(36, 112, 216);
}

// Link and buttons
- (UIColor*)blueLinkColor {
  return RGBCOLOR(87, 107, 149);
}


// Public colors
- (UIColor*)titleColor {
  return [UIColor blackColor];
}

- (UIColor*)titleHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)subtitleColor {
  return [self secondaryColor];
}

- (UIColor*)subtitleHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)messageColor {
  return [self secondaryColor];
}

- (UIColor*)messageHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)messageSubtitleColor {
  return [UIColor blackColor];
}

- (UIColor*)messageSubtitleHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)captionColor {
  return [self blueCaptionColor];
}

- (UIColor*)captionHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)captionTitleColor {
  return [UIColor blackColor];
}

- (UIColor*)captionTitleHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)timestampColor {
  return [self blueCaptionColor];
}

- (UIColor*)timestampHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)summaryColor {
  return [self secondaryColor];
}

- (UIColor*)summaryHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)linkColor {
  return [self blueLinkColor];
}

- (UIColor*)linkHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)buttonColor {
  return [self blueLinkColor];
}

- (UIColor*)buttonHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)moreButtonColor {
  return [self blueCaptionColor];
}

- (UIColor*)moreButtonHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)moreButtonSubtitleColor {
  return [self secondaryColor];
}

- (UIColor*)moreButtonSubtitleHighlightedColor {
  return [self highlightedColor];
}

- (UIColor*)longTextColor {
  return [UIColor blackColor];
}

- (UIColor*)longTextHighlightedColor {
  return [self highlightedColor];
}

- (UIFont*)titleFont {
  return [UIFont boldSystemFontOfSize:17];
}

- (UIFont*)subtitleFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)messageFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)captionFont {
  return [UIFont boldSystemFontOfSize:13];
}

- (UIFont*)captionTitleFont {
  return [UIFont boldSystemFontOfSize:15];
}

- (UIFont*)timestampFont {
  return [UIFont systemFontOfSize:13];
}

- (UIFont*)summaryFont {
  return [UIFont systemFontOfSize:17];
}

- (UIFont*)linkFont {
  return [UIFont boldSystemFontOfSize:17];
}

- (UIFont*)buttonFont {
  return [UIFont boldSystemFontOfSize:13];
}

- (UIFont*)moreButtonFont {
  return [UIFont boldSystemFontOfSize:15];
}

- (UIFont*)moreButtonSubtitleFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)longTextFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)styledTextFont {
  return [UIFont systemFontOfSize:14];
}

- (UITableViewCellSelectionStyle)selectionStyle {
  return UITableViewCellSelectionStyleBlue;
}

- (CGFloat)captionWidth {
  return 75;
}

- (CGFloat)captionSpacing {
  return 12;
}

- (UILineBreakMode)titleLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)titleNumberOfLines {
  return 1;
}

- (UITextAlignment)titleTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)subtitleLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)subtitleNumberOfLines {
  return 2;
}

- (UITextAlignment)subtitleTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)messageLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)messageNumberOfLines {
  return 2;
}

- (UITextAlignment)messageTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)captionLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)captionNumberOfLines {
  return 1;
}

- (UITextAlignment)captionTextAlignment {
  return UITextAlignmentLeft;
}

- (BOOL)captionAdjustsFontSizeToFitWidth {
  return YES;
}

- (CGFloat)captionMinimumFontSize {
  return 8;
}

- (UILineBreakMode)captionTitleLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)captionTitleNumberOfLines {
  return 1;
}

- (UITextAlignment)captionTitleTextAlignment {
  return UITextAlignmentLeft;
}

- (UITextAlignment)timestampTextAlignment {
  return UITextAlignmentRight;
}

- (UILineBreakMode)summaryLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)summaryNumberOfLines {
  return 1;
}

- (UITextAlignment)summaryTextAlignment {
  return UITextAlignmentCenter;
}

- (BOOL)summaryAdjustsFontSizeToFitWidth {
  return NO;
}

- (CGFloat)summaryMinimumFontSize {
  return 14;
}

- (UILineBreakMode)linkLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)linkNumberOfLines {
  return 1;
}

- (UITextAlignment)linkTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)buttonLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)buttonNumberOfLines {
  return 1;
}

- (UITextAlignment)buttonTextAlignment {
  return UITextAlignmentCenter;
}

- (UILineBreakMode)moreButtonLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)moreButtonNumberOfLines {
  return 1;
}

- (UITextAlignment)moreButtonTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)moreButtonSubtitleLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)moreButtonSubtitleNumberOfLines {
  return 1;
}

- (UITextAlignment)moreButtonSubtitleTextAlignment {
  return UITextAlignmentLeft;
}

- (UILineBreakMode)longTextLineBreakMode {
  return UILineBreakModeTailTruncation;
}

- (NSInteger)longTextNumberOfLines {
  return 0;
}

- (UITextAlignment)longTextTextAlignment {
  return UITextAlignmentLeft;
}

- (TTActivityLabelStyle)activityLabelStyle {
  return TTActivityLabelStyleGray;
}

- (UIEdgeInsets)padding {
  return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)imageSize {
  return CGSizeMake(50, 50);
}

- (UIEdgeInsets)imagePadding {
  return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
