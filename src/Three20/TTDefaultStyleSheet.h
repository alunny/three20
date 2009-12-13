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

#import "Three20/TTStyleSheet.h"

// For TTActivityLabelStyle
#import "Three20/TTActivityLabel.h"

@class TTShape;

@interface TTDefaultStyleSheet : TTStyleSheet

@property(nonatomic,readonly) UIColor* textColor;
@property(nonatomic,readonly) UIColor* highlightedTextColor;
@property(nonatomic,readonly) UIColor* placeholderTextColor;
@property(nonatomic,readonly) UIColor* timestampTextColor;
@property(nonatomic,readonly) UIColor* linkTextColor;
@property(nonatomic,readonly) UIColor* moreLinkTextColor;
@property(nonatomic,readonly) UIColor* selectedTextColor;
@property(nonatomic,readonly) UIColor* photoCaptionTextColor;

@property(nonatomic,readonly) UIColor* navigationBarTintColor;
@property(nonatomic,readonly) UIColor* toolbarTintColor;
@property(nonatomic,readonly) UIColor* searchBarTintColor;
@property(nonatomic,readonly) UIColor* screenBackgroundColor;
@property(nonatomic,readonly) UIColor* backgroundColor;

@property(nonatomic,readonly) UIColor* tableTitleColor;
@property(nonatomic,readonly) UIColor* tableTitleHighlightedColor;
@property(nonatomic,readonly) UIColor* tableSubtitleColor;
@property(nonatomic,readonly) UIColor* tableSubtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* tableMessageColor;
@property(nonatomic,readonly) UIColor* tableMessageHighlightedColor;
@property(nonatomic,readonly) UIColor* tableMessageSubtitleColor;
@property(nonatomic,readonly) UIColor* tableMessageSubtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* tableCaptionColor;
@property(nonatomic,readonly) UIColor* tableCaptionHighlightedColor;
@property(nonatomic,readonly) UIColor* tableCaptionTitleColor;
@property(nonatomic,readonly) UIColor* tableCaptionTitleHighlightedColor;
@property(nonatomic,readonly) UIColor* tableTimestampColor;
@property(nonatomic,readonly) UIColor* tableTimestampHighlightedColor;
@property(nonatomic,readonly) UIColor* tableSummaryColor;
@property(nonatomic,readonly) UIColor* tableSummaryHighlightedColor;
@property(nonatomic,readonly) UIColor* tableLinkColor;
@property(nonatomic,readonly) UIColor* tableLinkHighlightedColor;
@property(nonatomic,readonly) UIColor* tableButtonColor;
@property(nonatomic,readonly) UIColor* tableButtonHighlightedColor;
@property(nonatomic,readonly) UIColor* tableMoreButtonColor;
@property(nonatomic,readonly) UIColor* tableMoreButtonHighlightedColor;
@property(nonatomic,readonly) UIColor* tableMoreButtonSubtitleColor;
@property(nonatomic,readonly) UIColor* tableMoreButtonSubtitleHighlightedColor;
@property(nonatomic,readonly) UIColor* tableLongTextColor;
@property(nonatomic,readonly) UIColor* tableLongTextHighlightedColor;

@property(nonatomic,readonly) UIColor* tableActivityTextColor;
@property(nonatomic,readonly) UIColor* tableErrorTextColor;
@property(nonatomic,readonly) UIColor* tableSubTextColor;
@property(nonatomic,readonly) UIColor* tableHeaderTextColor;
@property(nonatomic,readonly) UIColor* tableHeaderShadowColor;
@property(nonatomic,readonly) UIColor* tableHeaderTintColor;
@property(nonatomic,readonly) UIColor* tableSeparatorColor;
@property(nonatomic,readonly) UIColor* tablePlainBackgroundColor;
@property(nonatomic,readonly) UIColor* tableGroupedBackgroundColor;
@property(nonatomic,readonly) UIColor* searchTableBackgroundColor;
@property(nonatomic,readonly) UIColor* searchTableSeparatorColor;

@property(nonatomic,readonly) UIColor* tabTintColor;
@property(nonatomic,readonly) UIColor* tabBarTintColor;

@property(nonatomic,readonly) UIColor* messageFieldTextColor;
@property(nonatomic,readonly) UIColor* messageFieldSeparatorColor;

@property(nonatomic,readonly) UIColor* thumbnailBackgroundColor;

@property(nonatomic,readonly) UIColor* postButtonColor;

@property(nonatomic,readonly) UIFont* font;
@property(nonatomic,readonly) UIFont* buttonFont;

@property(nonatomic,readonly) UIFont* tableTitleFont;
@property(nonatomic,readonly) UIFont* tableSubtitleFont;
@property(nonatomic,readonly) UIFont* tableMessageFont;
@property(nonatomic,readonly) UIFont* tableCaptionFont;
@property(nonatomic,readonly) UIFont* tableCaptionTitleFont;
@property(nonatomic,readonly) UIFont* tableTimestampFont;
@property(nonatomic,readonly) UIFont* tableSummaryFont;
@property(nonatomic,readonly) UIFont* tableLinkFont;
@property(nonatomic,readonly) UIFont* tableButtonFont;
@property(nonatomic,readonly) UIFont* tableMoreButtonFont;
@property(nonatomic,readonly) UIFont* tableMoreButtonSubtitleFont;
@property(nonatomic,readonly) UIFont* tableLongTextFont;

@property(nonatomic,readonly) UIFont* tableFont;
@property(nonatomic,readonly) UIFont* tableSmallFont;
@property(nonatomic,readonly) UIFont* tableHeaderPlainFont;
@property(nonatomic,readonly) UIFont* tableHeaderGroupedFont;
@property(nonatomic,readonly) UIFont* photoCaptionFont;
@property(nonatomic,readonly) UIFont* messageFont;
@property(nonatomic,readonly) UIFont* errorTitleFont;
@property(nonatomic,readonly) UIFont* errorSubtitleFont;
@property(nonatomic,readonly) UIFont* activityLabelFont;
@property(nonatomic,readonly) UIFont* activityBannerFont;

@property(nonatomic,readonly) UITableViewCellSelectionStyle tableSelectionStyle;

@property(nonatomic,readonly) UILineBreakMode tableTitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableTitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableTitleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableSubtitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableSubtitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableSubtitleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableMessageLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableMessageNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableMessageTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableCaptionLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableCaptionNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableCaptionTextAlignment;
@property(nonatomic,readonly) BOOL            tableCaptionAdjustsFontSizeToFitWidth;
@property(nonatomic,readonly) CGFloat         tableCaptionMinimumFontSize;

@property(nonatomic,readonly) UILineBreakMode tableCaptionTitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableCaptionTitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableCaptionTitleTextAlignment;

@property(nonatomic,readonly) UITextAlignment tableTimestampTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableSummaryLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableSummaryNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableSummaryTextAlignment;
@property(nonatomic,readonly) BOOL            tableSummaryAdjustsFontSizeToFitWidth;
@property(nonatomic,readonly) CGFloat         tableSummaryMinimumFontSize;

@property(nonatomic,readonly) UILineBreakMode tableLinkLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableLinkNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableLinkTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableButtonLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableButtonNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableButtonTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableMoreButtonLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableMoreButtonNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableMoreButtonTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableMoreButtonSubtitleLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableMoreButtonSubtitleNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableMoreButtonSubtitleTextAlignment;

@property(nonatomic,readonly) UILineBreakMode tableLongTextLineBreakMode;
@property(nonatomic,readonly) NSInteger       tableLongTextNumberOfLines;
@property(nonatomic,readonly) UITextAlignment tableLongTextTextAlignment;

@property(nonatomic,readonly) TTActivityLabelStyle tableActivityLabelStyle;

@property(nonatomic,readonly) CGFloat         tableHPadding;
@property(nonatomic,readonly) CGFloat         tableVPadding;

@property(nonatomic,readonly) CGSize          tableImageSize;
@property(nonatomic,readonly) UIEdgeInsets    tableImagePadding;

- (TTStyle*)selectionFillStyle:(TTStyle*)next;

- (TTStyle*)toolbarButtonForState:(UIControlState)state shape:(TTShape*)shape
            tintColor:(UIColor*)tintColor font:(UIFont*)font;

- (TTStyle*)pageDotWithColor:(UIColor*)color;

@end
