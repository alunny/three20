//
// copyright 2009 Facebook
//
// licensed under the apache license, Version 2.0 (the "License");
// you may not use this file except in compliance with the license.
// You may obtain a copy of the license at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the license is distributed on an "AS IS" bASIS,
// WITHOUT WARRANTIES OR cONDITIONS OF aNY KIND, either express or implied.
// see the license for the specific language governing permissions and
// limitations under the license.
//

#import "Three20/TTStyleSheet.h"

// For TTActivityLabelStyle
#import "Three20/TTActivityLabel.h"

@interface TTTableStyleSheet : TTStyleSheet

// Text colors
@property(nonatomic,readonly) UIColor* titleColor;
@property(nonatomic,readonly) UIColor* titleHighlightedColor;
@property(nonatomic,readonly) UIColor* subtitleColor;
@property(nonatomic,readonly) UIColor* subtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* messageColor;
@property(nonatomic,readonly) UIColor* messageHighlightedColor;
@property(nonatomic,readonly) UIColor* messageSubtitleColor;
@property(nonatomic,readonly) UIColor* messageSubtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* captionColor;
@property(nonatomic,readonly) UIColor* captionHighlightedColor;
@property(nonatomic,readonly) UIColor* captionTitleColor;
@property(nonatomic,readonly) UIColor* captionTitleHighlightedColor;
@property(nonatomic,readonly) UIColor* timestampColor;
@property(nonatomic,readonly) UIColor* timestampHighlightedColor;
@property(nonatomic,readonly) UIColor* summaryColor;
@property(nonatomic,readonly) UIColor* summaryHighlightedColor;
@property(nonatomic,readonly) UIColor* linkColor;
@property(nonatomic,readonly) UIColor* linkHighlightedColor;
@property(nonatomic,readonly) UIColor* buttonColor;
@property(nonatomic,readonly) UIColor* buttonHighlightedColor;
@property(nonatomic,readonly) UIColor* moreButtonColor;
@property(nonatomic,readonly) UIColor* moreButtonHighlightedColor;
@property(nonatomic,readonly) UIColor* moreButtonSubtitleColor;
@property(nonatomic,readonly) UIColor* moreButtonSubtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* longTextColor;
@property(nonatomic,readonly) UIColor* longTextHighlightedColor;

// Fonts
@property(nonatomic,readonly) UIFont* titleFont;
@property(nonatomic,readonly) UIFont* subtitleFont;
@property(nonatomic,readonly) UIFont* messageFont;
@property(nonatomic,readonly) UIFont* captionFont;
@property(nonatomic,readonly) UIFont* captionTitleFont;
@property(nonatomic,readonly) UIFont* timestampFont;
@property(nonatomic,readonly) UIFont* summaryFont;
@property(nonatomic,readonly) UIFont* linkFont;
@property(nonatomic,readonly) UIFont* buttonFont;
@property(nonatomic,readonly) UIFont* moreButtonFont;
@property(nonatomic,readonly) UIFont* moreButtonSubtitleFont;
@property(nonatomic,readonly) UIFont* longTextFont;
@property(nonatomic,readonly) UIFont* styledTextFont;

// Table cell padding
@property(nonatomic,readonly) CGFloat paddingH;
@property(nonatomic,readonly) CGFloat paddingV;

@property(nonatomic,readonly) CGSize          imageSize;
@property(nonatomic,readonly) UIEdgeInsets    imagePadding;

@property(nonatomic,readonly) TTActivityLabelStyle activityLabelStyle;

@property(nonatomic,readonly) UITableViewCellSelectionStyle selectionStyle;

// Formatting
@property(nonatomic,readonly) UILineBreakMode titleLineBreakMode;
@property(nonatomic,readonly) NSInteger       titleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment titleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode subtitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       subtitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment subtitleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode messageLineBreakMode;
@property(nonatomic,readonly) NSInteger       messageNumberOfLines;
@property(nonatomic,readonly) UITextAlignment messageTextAlignment;

@property(nonatomic,readonly) UILineBreakMode captionLineBreakMode;
@property(nonatomic,readonly) NSInteger       captionNumberOfLines;
@property(nonatomic,readonly) UITextAlignment captionTextAlignment;
@property(nonatomic,readonly) BOOL            captionAdjustsFontSizeToFitWidth;
@property(nonatomic,readonly) CGFloat         captionMinimumFontSize;

@property(nonatomic,readonly) UILineBreakMode captionTitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       captionTitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment captionTitleTextAlignment;

@property(nonatomic,readonly) UITextAlignment timestampTextAlignment;

@property(nonatomic,readonly) UILineBreakMode summaryLineBreakMode;
@property(nonatomic,readonly) NSInteger       summaryNumberOfLines;
@property(nonatomic,readonly) UITextAlignment summaryTextAlignment;
@property(nonatomic,readonly) BOOL            summaryAdjustsFontSizeToFitWidth;
@property(nonatomic,readonly) CGFloat         summaryMinimumFontSize;

@property(nonatomic,readonly) UILineBreakMode linkLineBreakMode;
@property(nonatomic,readonly) NSInteger       linkNumberOfLines;
@property(nonatomic,readonly) UITextAlignment linkTextAlignment;

@property(nonatomic,readonly) UILineBreakMode buttonLineBreakMode;
@property(nonatomic,readonly) NSInteger       buttonNumberOfLines;
@property(nonatomic,readonly) UITextAlignment buttonTextAlignment;

@property(nonatomic,readonly) UILineBreakMode moreButtonLineBreakMode;
@property(nonatomic,readonly) NSInteger       moreButtonNumberOfLines;
@property(nonatomic,readonly) UITextAlignment moreButtonTextAlignment;

@property(nonatomic,readonly) UILineBreakMode moreButtonSubtitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       moreButtonSubtitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment moreButtonSubtitleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode longTextLineBreakMode;
@property(nonatomic,readonly) NSInteger       longTextNumberOfLines;
@property(nonatomic,readonly) UITextAlignment longTextTextAlignment;

@end
