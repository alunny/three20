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
-(UIColor*) titleColor;
-(UIColor*) titleHighlightedColor;
-(UIColor*) subtitleColor;
-(UIColor*) subtitleHighlightedColor;
-(UIColor*) messageColor;
-(UIColor*) messageHighlightedColor;
-(UIColor*) messageSubtitleColor;
-(UIColor*) messageSubtitleHighlightedColor;
-(UIColor*) captionColor;
-(UIColor*) captionHighlightedColor;
-(UIColor*) captionTitleColor;
-(UIColor*) captionTitleHighlightedColor;
-(UIColor*) timestampColor;
-(UIColor*) timestampHighlightedColor;
-(UIColor*) summaryColor;
-(UIColor*) summaryHighlightedColor;
-(UIColor*) linkColor;
-(UIColor*) linkHighlightedColor;
-(UIColor*) buttonColor;
-(UIColor*) buttonHighlightedColor;
-(UIColor*) moreButtonColor;
-(UIColor*) moreButtonHighlightedColor;
-(UIColor*) moreButtonSubtitleColor;
-(UIColor*) moreButtonSubtitleHighlightedColor;
-(UIColor*) controlCaptionColor;
-(UIColor*) controlCaptionHighlightedColor;
-(UIColor*) longTextColor;
-(UIColor*) longTextHighlightedColor;

// Fonts
-(UIFont*) titleFont;
-(UIFont*) subtitleFont;
-(UIFont*) messageFont;
-(UIFont*) captionFont;
-(UIFont*) captionTitleFont;
-(UIFont*) timestampFont;
-(UIFont*) summaryFont;
-(UIFont*) linkFont;
-(UIFont*) buttonFont;
-(UIFont*) moreButtonFont;
-(UIFont*) moreButtonSubtitleFont;
-(UIFont*) controlCaptionFont;
-(UIFont*) longTextFont;
-(UIFont*) styledTextFont;

// Table cell padding
-(UIEdgeInsets) padding;

-(CGSize         ) imageSize;
-(UIEdgeInsets   ) imagePadding;

-(TTActivityLabelStyle) activityLabelStyle;

-(UITableViewCellSelectionStyle) selectionStyle;

-(CGFloat        ) captionWidth;
-(CGFloat        ) captionSpacing;

-(CGFloat        ) timestampSpacing;

// Formatting
-(UILineBreakMode) titleLineBreakMode;
-(NSInteger      ) titleNumberOfLines;
-(UITextAlignment) titleTextAlignment;

-(UILineBreakMode) subtitleLineBreakMode;
-(NSInteger      ) subtitleNumberOfLines;
-(UITextAlignment) subtitleTextAlignment;

-(UILineBreakMode) messageLineBreakMode;
-(NSInteger      ) messageNumberOfLines;
-(UITextAlignment) messageTextAlignment;

-(UILineBreakMode) captionLineBreakMode;
-(NSInteger      ) captionNumberOfLines;
-(UITextAlignment) captionTextAlignment;
-(BOOL           ) captionAdjustsFontSizeToFitWidth;
-(CGFloat        ) captionMinimumFontSize;

-(UILineBreakMode) captionTitleLineBreakMode;
-(NSInteger      ) captionTitleNumberOfLines;
-(UITextAlignment) captionTitleTextAlignment;

-(UITextAlignment) timestampTextAlignment;

-(UILineBreakMode) summaryLineBreakMode;
-(NSInteger      ) summaryNumberOfLines;
-(UITextAlignment) summaryTextAlignment;
-(BOOL           ) summaryAdjustsFontSizeToFitWidth;
-(CGFloat        ) summaryMinimumFontSize;

-(UILineBreakMode) linkLineBreakMode;
-(NSInteger      ) linkNumberOfLines;
-(UITextAlignment) linkTextAlignment;

-(UILineBreakMode) buttonLineBreakMode;
-(NSInteger      ) buttonNumberOfLines;
-(UITextAlignment) buttonTextAlignment;

-(UILineBreakMode) moreButtonLineBreakMode;
-(NSInteger      ) moreButtonNumberOfLines;
-(UITextAlignment) moreButtonTextAlignment;

-(UILineBreakMode) moreButtonSubtitleLineBreakMode;
-(NSInteger      ) moreButtonSubtitleNumberOfLines;
-(UITextAlignment) moreButtonSubtitleTextAlignment;

-(UILineBreakMode) controlCaptionLineBreakMode;
-(NSInteger      ) controlCaptionNumberOfLines;
-(UITextAlignment) controlCaptionTextAlignment;

-(UILineBreakMode) longTextLineBreakMode;
-(NSInteger      ) longTextNumberOfLines;
-(UITextAlignment) longTextTextAlignment;

@end
