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

#import "Three20/TTTableItemCell.h"

#import "Three20/TTGlobalCore.h"
#import "Three20/TTGlobalUI.h"

#import "Three20/TTTableItem.h"
#import "Three20/TTImageView.h"
#import "Three20/TTStyledTextLabel.h"
#import "Three20/TTActivityLabel.h"
#import "Three20/TTTextEditor.h"
#import "Three20/TTURLMap.h"
#import "Three20/TTNavigator.h"
#import "Three20/TTURLCache.h"
#import "Three20/TTTableStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static const CGFloat kMargin = 10;
static const CGFloat kCellBorderSize = 1;
static const CGFloat kSmallMargin = 6;
static const CGFloat kSpacing = 8;
static const CGFloat kControlPadding = 8;
static const CGFloat kDefaultTextViewLines = 5;
static const CGFloat kMoreButtonMargin = 40;

static const CGFloat kKeySpacing = 12;

static const CGFloat kKeyWidth = 75;
static const CGFloat kMaxLabelHeight = 2000;

static const NSInteger kMessageTextLineCount = 2;

static const CGFloat kDefaultImageSize = 50;
static const CGFloat kDefaultMessageImageWidth = 34;
static const CGFloat kDefaultMessageImageHeight = 34;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkedItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_item);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = [_item.styleSheet paddingH];
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    TTTableLinkedItem* item = object;
    if (![item isKindOfClass:[TTTableLinkedItem class]]) {
      self.accessoryType = UITableViewCellAccessoryNone;
      self.selectionStyle = UITableViewCellSelectionStyleNone;
      return;
    }

    // accessoryURL takes priority over URL when setting the accessory type because
    // you can still access URL by tapping the row if there is an accessory button.
    if (nil != item.accessoryURL) {
      self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    } else if (nil != item.URL) {
      TTNavigationMode navigationMode = [[TTNavigator navigator].URLMap
        navigationModeForURL:item.URL];

      if (navigationMode == TTNavigationModeCreate ||
          navigationMode == TTNavigationModeShare) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      } else {
        self.accessoryType = UITableViewCellAccessoryNone;
      }
    }

    // Any URL can be tapped and accessed.
    if (nil != item.URL) {
      self.selectionStyle = [_item.styleSheet selectionStyle];
    } else {
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (nil == item.URL && nil == item.accessoryURL) {
      self.accessoryType = UITableViewCellAccessoryNone;
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
  }
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableImageLinkedItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_styledImageView);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  if (self.superview) {
    _styledImageView.backgroundColor = self.backgroundColor;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)calculateContentWidthWithImageSize: (CGSize*)pImageSize
                                 imagePadding: (UIEdgeInsets*)pImagePadding {
  CGFloat contentWidth = self.contentView.width - [_item.styleSheet paddingH] * 2;

  CGSize imageSize;
  UIEdgeInsets imagePadding;

  if (nil != _styledImageView) {
    imageSize = [_item.styleSheet imageSize];
    imagePadding = [_item.styleSheet imagePadding];
    contentWidth -= imageSize.width + imagePadding.left + imagePadding.right;

    CGFloat imageHeight = imageSize.height + imagePadding.top + imagePadding.bottom;

    if (imageHeight > self.contentView.height) {
      CGFloat percScale = self.contentView.height / imageHeight;
      CGSize originalSize = imageSize;
      imageSize.width = floor(percScale * originalSize.width);
      imageSize.height = floor(percScale * originalSize.height);
      imagePadding.top = floor(percScale * imagePadding.top);
      imagePadding.bottom = floor(percScale * imagePadding.bottom);

      // Center the new, smaller image
      CGFloat xDelta = (originalSize.width - imageSize.width) / 2;
      imagePadding.left += floor(xDelta);
      imagePadding.right += ceil(xDelta);
    }
  } else {
    imageSize = CGSizeZero;
    imagePadding = UIEdgeInsetsZero;
  }

  *pImageSize = imageSize;
  *pImagePadding = imagePadding;

  return contentWidth;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)calculateContentWidthWithTableView: (UITableView*)tableView
                                    indexPath: (NSIndexPath*)indexPath
                                    imageSize: (CGSize*)pImageSize
                                 imagePadding: (UIEdgeInsets*)pImagePadding {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];

  CGSize imageSize;
  UIEdgeInsets imagePadding;

  if (nil != _styledImageView) {
    imageSize = [_item.styleSheet imageSize];
    imagePadding = [_item.styleSheet imagePadding];
    contentWidth -= imageSize.width + imagePadding.left + imagePadding.right;
  } else {
    imageSize = CGSizeZero;
    imagePadding = UIEdgeInsetsZero;
  }

  *pImageSize = imageSize;
  *pImagePadding = imagePadding;

  return contentWidth;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    // We've just ensured that _item != object, so a release/retain is fine here.
    [super setObject:object];

    [_styledImageView removeFromSuperview];
    TT_RELEASE_SAFELY(_styledImageView);

    TTTableImageLinkedItem* item = object;

    if (nil != item.image || TTIsStringWithAnyText(item.imageURL)) {
      _styledImageView = [[TTImageView alloc] init];
      _styledImageView.defaultImage = item.image;
      _styledImageView.URL          = item.imageURL;
      _styledImageView.style        = item.imageStyle;
      [self.contentView addSubview:_styledImageView];
    }
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableTitleItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)optimizeLabels: (NSArray*)labels
               heights: (NSMutableArray*)calculatedLabelHeights {
  UIEdgeInsets padding = UIEdgeInsetsMake(
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH],
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH]);
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  const CGFloat paddedCellHeight = self.contentView.height - [_item.styleSheet paddingV] * 2;

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  BOOL isImageRightAligned = ((TTTableImageLinkedItem*)_item).imageRightAligned;

  _styledImageView.frame =
    CGRectMake((isImageRightAligned ?
        (self.contentView.width - imagePadding.right - imageSize.width) :
        imagePadding.left),
      floor(self.contentView.height -
            MIN(self.contentView.height, imageSize.height)) / 2,
      imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake((isImageRightAligned ? 0 : imageWidth) + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV],
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithTableView: tableView
                             indexPath: indexPath
                             imageSize: &imageSize
                          imagePadding: &imagePadding];

  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
             height + [_item.styleSheet paddingV] * 2) + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableTitleItem* item = object;

      self.textLabel.text = item.title;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.titleFont);

      self.textLabel.font                 = [_item.styleSheet titleFont];
      self.textLabel.textColor            = [_item.styleSheet titleColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet titleHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet titleLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet titleNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet titleTextAlignment];
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSubtitleItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  // Override the given style to ensure we have the detailTextLabel
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)optimizeLabels: (NSArray*)labels
               heights: (NSMutableArray*)calculatedLabelHeights {
  UIEdgeInsets padding = UIEdgeInsetsMake(
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH],
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH]);
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  CGFloat titleHeight     = [self.textLabel heightWithWidth:contentWidth];
  CGFloat subtitleHeight  = [self.detailTextLabel heightWithWidth:contentWidth];

  NSArray* labels = [[NSArray alloc] initWithObjects:
    self.textLabel,
    self.detailTextLabel,
    nil];
  NSMutableArray* labelHeights = [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithFloat:titleHeight],
    [NSNumber numberWithFloat:subtitleHeight],
    nil];
  [self optimizeLabels:labels heights:labelHeights];
  TT_RELEASE_SAFELY(labels);

  titleHeight = [[labelHeights objectAtIndex:0] floatValue];
  subtitleHeight = [[labelHeights objectAtIndex:1] floatValue];

  TT_RELEASE_SAFELY(labelHeights);

  _styledImageView.frame =
    CGRectMake(imagePadding.left, imagePadding.top,
               imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH], [_item.styleSheet paddingV],
               contentWidth, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH], [_item.styleSheet paddingV] + titleHeight,
               contentWidth, subtitleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithTableView: tableView
                             indexPath: indexPath
                             imageSize: &imageSize
                          imagePadding: &imagePadding];

  CGFloat titleHeight = [self.textLabel heightWithWidth:contentWidth];
  CGFloat subtitleHeight = [self.detailTextLabel heightWithWidth:contentWidth];
  return MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
             titleHeight + subtitleHeight + [_item.styleSheet paddingV] * 2) +
         [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableSubtitleItem* item = object;
      self.textLabel.text = item.title;
      self.detailTextLabel.text = item.subtitle;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.titleFont);

      self.textLabel.font                 = [_item.styleSheet titleFont];
      self.textLabel.textColor            = [_item.styleSheet titleColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet titleHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet titleLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet titleNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet titleTextAlignment];

      TTDASSERT(nil != _item.styleSheet.subtitleFont);

      self.detailTextLabel.font                 = [_item.styleSheet subtitleFont];
      self.detailTextLabel.textColor            = [_item.styleSheet subtitleColor];
      self.detailTextLabel.highlightedTextColor = [_item.styleSheet subtitleHighlightedColor];
      self.detailTextLabel.lineBreakMode        = [_item.styleSheet subtitleLineBreakMode];
      self.detailTextLabel.numberOfLines        = [_item.styleSheet subtitleNumberOfLines];
      self.detailTextLabel.textAlignment        = [_item.styleSheet subtitleTextAlignment];
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMessageItemCell

@synthesize messageLabel    = _messageLabel;
@synthesize timestampLabel  = _timestampLabel;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
    _messageLabel = [[UILabel alloc] init];
    _timestampLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_messageLabel];
    [self.contentView addSubview:_timestampLabel];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_messageLabel);
  TT_RELEASE_SAFELY(_timestampLabel);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)optimizeLabels: (NSArray*)labels
               heights: (NSMutableArray*)calculatedLabelHeights {
  UIEdgeInsets padding = UIEdgeInsetsMake(
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH],
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH]);
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  CGSize timestampSize = [self.timestampLabel.text
         sizeWithFont: self.timestampLabel.font
    constrainedToSize: CGSizeMake(contentWidth, CGFLOAT_MAX)
        lineBreakMode: self.timestampLabel.lineBreakMode];

  CGFloat titleHeight     = [self.textLabel heightWithWidth:contentWidth - timestampSize.width];
  CGFloat subtitleHeight  = [self.detailTextLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0) ? 0 : timestampSize.width)];
  CGFloat messageHeight   = [self.messageLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0 || subtitleHeight > 0) ? 0 : timestampSize.width)];

  NSArray* labels = [[NSArray alloc] initWithObjects:
    self.textLabel,
    self.detailTextLabel,
    self.messageLabel,
    nil];
  NSMutableArray* labelHeights = [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithFloat:titleHeight],
    [NSNumber numberWithFloat:subtitleHeight],
    [NSNumber numberWithFloat:messageHeight],
    nil];
  [self optimizeLabels:labels heights:labelHeights];
  TT_RELEASE_SAFELY(labels);

  titleHeight = [[labelHeights objectAtIndex:0] floatValue];
  subtitleHeight = [[labelHeights objectAtIndex:1] floatValue];
  messageHeight = [[labelHeights objectAtIndex:2] floatValue];

  TT_RELEASE_SAFELY(labelHeights);

  _styledImageView.frame =
    CGRectMake(imagePadding.left, imagePadding.top,
               imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV],
               contentWidth - timestampSize.width, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV] + titleHeight,
               contentWidth - ((titleHeight > 0) ? 0 : timestampSize.width), subtitleHeight);

  self.messageLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV] + titleHeight + subtitleHeight,
               contentWidth - ((titleHeight > 0 || subtitleHeight > 0) ? 0 : timestampSize.width),
               messageHeight);

  CGFloat entireContentWidth = imageWidth + [_item.styleSheet paddingH] + contentWidth;
  self.timestampLabel.frame =
    CGRectMake(entireContentWidth - timestampSize.width,
               [_item.styleSheet paddingV],
               timestampSize.width, timestampSize.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  if (self.superview) {
    _messageLabel.backgroundColor = self.backgroundColor;
    _timestampLabel.backgroundColor = self.backgroundColor;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithTableView: tableView
                             indexPath: indexPath
                             imageSize: &imageSize
                          imagePadding: &imagePadding];

  CGSize timestampSize = [self.timestampLabel.text
         sizeWithFont: self.timestampLabel.font
    constrainedToSize: CGSizeMake(contentWidth, CGFLOAT_MAX)
        lineBreakMode: self.timestampLabel.lineBreakMode];

  CGFloat titleHeight     = [self.textLabel heightWithWidth:contentWidth - timestampSize.width];
  CGFloat subtitleHeight  = [self.detailTextLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0) ? 0 : timestampSize.width)];
  CGFloat messageHeight   = [self.messageLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0 || subtitleHeight > 0) ? 0 : timestampSize.width)];
  return MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
             titleHeight + subtitleHeight + messageHeight + [_item.styleSheet paddingV] * 2) +
    [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableMessageItem* item = object;
      self.textLabel.text = item.title;
      self.detailTextLabel.text = item.subtitle;
      self.messageLabel.text = item.text;
      self.timestampLabel.text = [item.timestamp formatShortTime];

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.titleFont);

      self.textLabel.font                 = [_item.styleSheet titleFont];
      self.textLabel.textColor            = [_item.styleSheet titleColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet titleHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet titleLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet titleNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet titleTextAlignment];

      TTDASSERT(nil != _item.styleSheet.subtitleFont);

      self.detailTextLabel.font                 = [_item.styleSheet subtitleFont];
      self.detailTextLabel.textColor            = [_item.styleSheet messageSubtitleColor];
      self.detailTextLabel.highlightedTextColor = [_item.styleSheet messageSubtitleHighlightedColor];
      self.detailTextLabel.lineBreakMode        = [_item.styleSheet subtitleLineBreakMode];
      self.detailTextLabel.numberOfLines        = [_item.styleSheet subtitleNumberOfLines];
      self.detailTextLabel.textAlignment        = [_item.styleSheet subtitleTextAlignment];

      TTDASSERT(nil != _item.styleSheet.messageFont);

      self.messageLabel.font                 = [_item.styleSheet messageFont];
      self.messageLabel.textColor            = [_item.styleSheet messageColor];
      self.messageLabel.highlightedTextColor = [_item.styleSheet messageHighlightedColor];
      self.messageLabel.lineBreakMode        = [_item.styleSheet messageLineBreakMode];
      self.messageLabel.numberOfLines        = [_item.styleSheet messageNumberOfLines];
      self.messageLabel.textAlignment        = [_item.styleSheet messageTextAlignment];

      TTDASSERT(nil != _item.styleSheet.timestampFont);

      self.timestampLabel.font                 = [_item.styleSheet timestampFont];
      self.timestampLabel.textColor            = [_item.styleSheet timestampColor];
      self.timestampLabel.highlightedTextColor = [_item.styleSheet timestampHighlightedColor];
      self.timestampLabel.textAlignment        = [_item.styleSheet timestampTextAlignment];
    }
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableCaptionItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  // Override the given style to ensure we have the detailTextLabel
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat captionWidth = kKeyWidth;
  CGFloat captionHeight = MIN(
    self.contentView.height - [_item.styleSheet paddingV] * 2,
    [self.textLabel heightWithWidth:captionWidth]);

  CGFloat titleWidth = self.contentView.width - (kKeyWidth + kKeySpacing + [_item.styleSheet paddingH] * 2);
  CGFloat titleHeight = MIN(
    self.contentView.height - [_item.styleSheet paddingV] * 2,
    [self.detailTextLabel heightWithWidth:titleWidth]);

  self.textLabel.frame = CGRectMake([_item.styleSheet paddingH], [_item.styleSheet paddingV],
                                    captionWidth, captionHeight);

  self.detailTextLabel.frame = CGRectMake([_item.styleSheet paddingH] + kKeyWidth + kKeySpacing, [_item.styleSheet paddingV],
                                          titleWidth, titleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];

  CGFloat captionWidth = kKeyWidth;
  CGFloat captionHeight = [self.textLabel heightWithWidth:captionWidth];

  CGFloat titleWidth = contentWidth - (kKeyWidth + kKeySpacing);
  CGFloat titleHeight = [self.detailTextLabel heightWithWidth:titleWidth];

  return MAX(captionHeight, titleHeight) + [_item.styleSheet paddingV] * 2 +
    [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableCaptionItem* item = object;
      self.textLabel.text = item.caption;
      self.detailTextLabel.text = item.title;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.captionFont);

      self.textLabel.font                      = [_item.styleSheet captionFont];
      self.textLabel.textColor                 = [_item.styleSheet captionColor];
      self.textLabel.highlightedTextColor      = [_item.styleSheet captionHighlightedColor];
      self.textLabel.lineBreakMode             = [_item.styleSheet captionLineBreakMode];
      self.textLabel.numberOfLines             = [_item.styleSheet captionNumberOfLines];
      self.textLabel.textAlignment             = [_item.styleSheet captionTextAlignment];
      self.textLabel.adjustsFontSizeToFitWidth = [_item.styleSheet captionAdjustsFontSizeToFitWidth];
      self.textLabel.minimumFontSize           = [_item.styleSheet captionMinimumFontSize];

      TTDASSERT(nil != _item.styleSheet.captionTitleFont);

      self.detailTextLabel.font                 = [_item.styleSheet captionTitleFont];
      self.detailTextLabel.textColor            = [_item.styleSheet captionTitleColor];
      self.detailTextLabel.highlightedTextColor = [_item.styleSheet captionTitleHighlightedColor];
      self.detailTextLabel.lineBreakMode        = [_item.styleSheet captionTitleLineBreakMode];
      self.detailTextLabel.numberOfLines        = [_item.styleSheet captionTitleNumberOfLines];
      self.detailTextLabel.textAlignment        = [_item.styleSheet captionTitleTextAlignment];
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSummaryItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  const CGFloat paddedCellHeight = self.contentView.height - [_item.styleSheet paddingV] * 2;

  CGFloat contentWidth = self.contentView.width - [_item.styleSheet paddingH] * 2;

  self.textLabel.frame =
    CGRectMake([_item.styleSheet paddingH], [_item.styleSheet paddingV],
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = [_item.styleSheet paddingH];
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return height + [_item.styleSheet paddingV] * 2 + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    if (nil != object) {
      TTTableSummaryItem* item = object;
      self.textLabel.text = item.title;

      self.selectionStyle = UITableViewCellSelectionStyleNone;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.summaryFont);

      self.textLabel.font                      = [_item.styleSheet summaryFont];
      self.textLabel.textColor                 = [_item.styleSheet summaryColor];
      self.textLabel.highlightedTextColor      = [_item.styleSheet summaryHighlightedColor];
      self.textLabel.lineBreakMode             = [_item.styleSheet summaryLineBreakMode];
      self.textLabel.numberOfLines             = [_item.styleSheet summaryNumberOfLines];
      self.textLabel.textAlignment             = [_item.styleSheet summaryTextAlignment];
      self.textLabel.adjustsFontSizeToFitWidth = [_item.styleSheet summaryAdjustsFontSizeToFitWidth];
      self.textLabel.minimumFontSize           = [_item.styleSheet summaryMinimumFontSize];
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  const CGFloat paddedCellHeight = self.contentView.height - [_item.styleSheet paddingV] * 2;

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  _styledImageView.frame =
    CGRectMake(imagePadding.left,
               floor(self.contentView.height -
                     MIN(self.contentView.height, imageSize.height)) / 2,
               imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV],
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithTableView: tableView
                             indexPath: indexPath
                             imageSize: &imageSize
                          imagePadding: &imagePadding];

  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
             height + [_item.styleSheet paddingV] * 2) + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableTitleItem* item = object;
      self.textLabel.text = item.title;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.linkFont);

      self.textLabel.font                 = [_item.styleSheet linkFont];
      self.textLabel.textColor            = [_item.styleSheet linkColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet linkHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet linkLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet linkNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet linkTextAlignment];
    }
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableButtonItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  const CGFloat paddedCellHeight = self.contentView.height - [_item.styleSheet paddingV] * 2;
  CGFloat contentWidth = self.contentView.width - [_item.styleSheet paddingH] * 2;

  self.textLabel.frame =
    CGRectMake([_item.styleSheet paddingH], [_item.styleSheet paddingV],
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return height + [_item.styleSheet paddingV] * 2 + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableButtonItem* item = object;
      self.textLabel.text = item.title;

      self.accessoryType = UITableViewCellAccessoryNone;
      if (TTIsStringWithAnyText(item.URL)) {
        self.selectionStyle = [_item.styleSheet selectionStyle];
      } else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
      }

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.buttonFont);

      self.textLabel.font                      = [_item.styleSheet buttonFont];
      self.textLabel.textColor                 = [_item.styleSheet buttonColor];
      self.textLabel.highlightedTextColor      = [_item.styleSheet buttonHighlightedColor];
      self.textLabel.lineBreakMode             = [_item.styleSheet buttonLineBreakMode];
      self.textLabel.numberOfLines             = [_item.styleSheet buttonNumberOfLines];
      self.textLabel.textAlignment             = [_item.styleSheet buttonTextAlignment];
    }
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMoreButtonItemCell

@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize animating             = _animating;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicatorView sizeToFit];
    [self.contentView addSubview:_activityIndicatorView];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_activityIndicatorView);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)optimizeLabels: (NSArray*)labels
               heights: (NSMutableArray*)calculatedLabelHeights {
  UIEdgeInsets padding = UIEdgeInsetsMake(
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH],
    [_item.styleSheet paddingV],
    [_item.styleSheet paddingH]);
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat contentWidth = self.contentView.width - [_item.styleSheet paddingH] * 2;
  CGFloat textContentWidth =
    contentWidth - self.activityIndicatorView.width - [_item.styleSheet paddingH];

  CGFloat titleHeight     = [self.textLabel heightWithWidth:textContentWidth];
  CGFloat subtitleHeight  = [self.detailTextLabel heightWithWidth:textContentWidth];

  NSArray* labels = [[NSArray alloc] initWithObjects:
    self.textLabel,
    self.detailTextLabel,
    nil];
  NSMutableArray* labelHeights = [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithFloat:titleHeight],
    [NSNumber numberWithFloat:subtitleHeight],
    nil];
  [self optimizeLabels:labels heights:labelHeights];
  TT_RELEASE_SAFELY(labels);

  titleHeight = [[labelHeights objectAtIndex:0] floatValue];
  subtitleHeight = [[labelHeights objectAtIndex:1] floatValue];

  TT_RELEASE_SAFELY(labelHeights);

  self.activityIndicatorView.left = [_item.styleSheet paddingH];
  self.activityIndicatorView.top =
    floor((self.contentView.height - self.activityIndicatorView.height) / 2);

  CGFloat centeredYOffset = floor((self.contentView.height - (titleHeight + subtitleHeight)) / 2);

  self.textLabel.frame =
    CGRectMake(self.activityIndicatorView.right + [_item.styleSheet paddingH],
               centeredYOffset,
               textContentWidth, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(self.activityIndicatorView.right + [_item.styleSheet paddingH],
               centeredYOffset + titleHeight,
               textContentWidth, subtitleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = [_item.styleSheet paddingH];
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat textContentWidth =
    contentWidth - self.activityIndicatorView.width - [_item.styleSheet paddingH];

  CGFloat titleHeight = [self.textLabel heightWithWidth:textContentWidth];
  CGFloat subtitleHeight = [self.detailTextLabel heightWithWidth:textContentWidth];
  return MAX(self.activityIndicatorView.height,
             MAX(TT_ROW_HEIGHT * 3/2, titleHeight + subtitleHeight)) +
         [_item.styleSheet paddingV] * 2 +
         [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    if (nil != object) {
      TTTableMoreButtonItem* item = object;
      self.textLabel.text = item.title;
      self.detailTextLabel.text = item.subtitle;
      self.animating = item.isLoading;

      self.accessoryType = UITableViewCellAccessoryNone;
      self.selectionStyle = [_item.styleSheet selectionStyle];

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.moreButtonFont);

      self.textLabel.font                 = [_item.styleSheet moreButtonFont];
      self.textLabel.textColor            = [_item.styleSheet moreButtonColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet moreButtonHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet moreButtonLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet moreButtonNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet moreButtonTextAlignment];

      TTDASSERT(nil != _item.styleSheet.moreButtonSubtitleFont);

      self.detailTextLabel.font                 = [_item.styleSheet moreButtonSubtitleFont];
      self.detailTextLabel.textColor            = [_item.styleSheet moreButtonSubtitleColor];
      self.detailTextLabel.highlightedTextColor = [_item.styleSheet moreButtonSubtitleHighlightedColor];
      self.detailTextLabel.lineBreakMode        = [_item.styleSheet moreButtonSubtitleLineBreakMode];
      self.detailTextLabel.numberOfLines        = [_item.styleSheet moreButtonSubtitleNumberOfLines];
      self.detailTextLabel.textAlignment        = [_item.styleSheet moreButtonSubtitleTextAlignment];
    }
  }  
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAnimating:(BOOL)animating {
  if (_animating != animating) {
    _animating = animating;

    if (_animating) {
      [self.activityIndicatorView startAnimating];
    } else {
      [_activityIndicatorView stopAnimating];
    }
    [self setNeedsLayout];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableActivityItemCell

@synthesize activityLabel = _activityLabel;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject


- (void)dealloc {
  TT_RELEASE_SAFELY(_activityLabel);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  self.activityLabel.frame = self.contentView.bounds;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  [self.activityLabel sizeToFit];
  return
    self.activityLabel.height +
    [_item.styleSheet paddingV] * 2 + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    if (nil != object) {
      TTTableActivityItem* item = object;

      self.accessoryType = UITableViewCellAccessoryNone;
      self.selectionStyle = UITableViewCellSelectionStyleNone;

      TTDASSERT(nil != _item.styleSheet);

      [_activityLabel removeFromSuperview];
      TT_RELEASE_SAFELY(_activityLabel);
      _activityLabel = [[TTActivityLabel alloc] initWithStyle:[_item.styleSheet activityLabelStyle]];
      [self.contentView addSubview:_activityLabel];

      self.activityLabel.text = item.title;
    }
  }  
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableStyledTextItemCell

@synthesize label = _label;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _label = [[TTStyledTextLabel alloc] init];
    _label.contentMode = UIViewContentModeLeft;
    [self.contentView addSubview:_label];

    // We need to clip this cell's contents because switching from the editing mode causes
    // the text to temporarily be larger than the cell.
    [self.contentView setClipsToBounds:YES];
  }
  return self;
}


- (void)dealloc {
  TT_RELEASE_SAFELY(_label);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  TTTableStyledTextItem* item = self.object;
  UIEdgeInsets margin;
  if ([item isKindOfClass:[TTTableStyledTextItem class]]) {
    margin = item.margin;
  } else {
    margin = UIEdgeInsetsZero;
  }
  _label.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, margin);

  // Necessary to force the label to redraw its new layout.
  [_label setNeedsDisplay];
}


- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  if (self.superview) {
    _label.backgroundColor = self.backgroundColor;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  TTTableStyledTextItem* item = self.object;
  UIEdgeInsets margin;
  UIEdgeInsets padding;
  if ([item isKindOfClass:[TTTableStyledTextItem class]]) {
    margin = item.margin;
    padding = item.padding;
  } else {
    margin = UIEdgeInsetsZero;
    padding = UIEdgeInsetsZero;
  }
  CGFloat contentWidth = [self contentWidthWithTableView: tableView
                                               indexPath: indexPath
                                                 padding: margin];
  _label.text.width = contentWidth;

  return
    _label.text.height +
    padding.top + padding.bottom +
    margin.top + margin.bottom +
    [tableView tableCellExtraHeight];
}


- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableStyledTextItem* item = object;
      if ([item isKindOfClass:[TTTableStyledTextItem class]]) {
        _label.text = item.text;
        _label.contentInset = item.padding;
      } else if ([item isKindOfClass:[TTStyledText class]]) {
        _label.text = (TTStyledText*)item;
        _label.contentInset = UIEdgeInsetsZero;
      } else {
        _label.text = nil;
        _label.contentInset = UIEdgeInsetsZero;    
      }

      if (!_label.text.font) {
        _label.text.font = [_item.styleSheet styledTextFont];
      }
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableControlItemCell

@synthesize item = _item, control = _control;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class private

+ (BOOL)shouldConsiderControlIntrinsicSize:(UIView*)view {
  return [view isKindOfClass:[UISwitch class]];
}

+ (BOOL)shouldSizeControlToFit:(UIView*)view {
  return [view isKindOfClass:[UITextView class]]
         || [view isKindOfClass:[TTTextEditor class]]
         || [view isKindOfClass:[UISlider class]];
}

+ (BOOL)shouldRespectControlPadding:(UIView*)view {
  return [view isKindOfClass:[UITextField class]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _item = nil;
    _control = nil;
	}
	return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_item);
  TT_RELEASE_SAFELY(_control);
	[super dealloc];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if ([TTTableControlItemCell shouldSizeControlToFit:_control]) {
    if ([_control isKindOfClass:[UISlider class]]) {
      _control.frame = CGRectInset(self.contentView.bounds, kControlPadding, 0);
    } else {
      _control.frame = CGRectInset(self.contentView.bounds, 2, kSpacing/2);
    }
  } else {
    CGFloat minX = kControlPadding;
    CGFloat contentWidth = self.contentView.width - kControlPadding;
    if (![TTTableControlItemCell shouldRespectControlPadding:_control]) {
      contentWidth -= kControlPadding;
    }
    if (self.textLabel.text.length) {
      CGSize textSize = [self.textLabel sizeThatFits:self.contentView.bounds.size];
      contentWidth -= textSize.width + kSpacing;
      minX += textSize.width + kSpacing;
    }

    if (!_control.height) {
      [_control sizeToFit];
    }
    
    if ([TTTableControlItemCell shouldConsiderControlIntrinsicSize:_control]) {
      minX += contentWidth - _control.width;
    }
    
    // XXXjoe For some reason I need to re-add the control as a subview or else
    // the re-use of the cell will cause the control to fail to paint itself on occasion
    [self.contentView addSubview:_control];
    _control.frame = CGRectMake(minX, floor((self.contentView.height - _control.height) / 2),
                                contentWidth, _control.height);
  }

  CGFloat contentWidth = self.contentView.width - [_item.styleSheet paddingH] * 2;
  CGFloat textContentWidth = contentWidth - _control.width;

  if (![TTTableControlItemCell shouldRespectControlPadding:_control]) {
    textContentWidth += kControlPadding;
  }

  CGFloat titleHeight = [self.textLabel heightWithWidth:textContentWidth];

  self.textLabel.frame =
    CGRectMake([_item.styleSheet paddingH], floor((self.contentView.height - titleHeight) / 2),
               textContentWidth, titleHeight);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = [_item.styleSheet paddingH];
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  UIView* view = nil;

  if ([_item isKindOfClass:[UIView class]]) {
    view = (UIView*)_item;
  } else {
    view = _item.control;
  }
  
  CGFloat height = view.height;
  if (!height) {
    if ([view isKindOfClass:[UITextView class]]) {
      UITextView* textView = (UITextView*)view;
      CGFloat ttLineHeight = textView.font.ttLineHeight;
      height = ttLineHeight * kDefaultTextViewLines;
    } else if ([view isKindOfClass:[TTTextEditor class]]) {
      TTTextEditor* textEditor = (TTTextEditor*)view;
      CGFloat ttLineHeight = textEditor.font.ttLineHeight;
      height = ttLineHeight * kDefaultTextViewLines;
    } else if ([view isKindOfClass:[UITextField class]]) {
      UITextField* textField = (UITextField*)view;
      CGFloat ttLineHeight = textField.font.ttLineHeight;
      height = ttLineHeight + kSmallMargin*2;
    } else {
      [view sizeToFit];
      height = view.height;
    }
  }

  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat textContentWidth = contentWidth - _control.width;

  CGFloat titleHeight;

  if ([TTTableControlItemCell shouldSizeControlToFit:_control]) {
    titleHeight = 0;
  } else {
    titleHeight = [self.textLabel heightWithWidth:textContentWidth];
  }
  return MAX(TT_ROW_HEIGHT, MAX(titleHeight, height) + [_item.styleSheet paddingV] * 2) +
         [tableView tableCellExtraHeight];
}


- (id)object {
  return _item ? _item : (id)_control;
}

- (void)setObject:(id)object {
  if (object != _control && object != _item) {
    [_control removeFromSuperview];
    TT_RELEASE_SAFELY(_control);
    TT_RELEASE_SAFELY(_item);

    if ([object isKindOfClass:[UIView class]]) {
      _control = [object retain];
    } else if ([object isKindOfClass:[TTTableControlItem class]]) {
      _item = [object retain];
      _control = [_item.control retain];
    }

    _control.backgroundColor = [UIColor clearColor];
    self.textLabel.text = _item.caption;

    if (_control) {
      [self.contentView addSubview:_control];
    }

    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLongTextItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  const CGFloat paddedCellHeight = self.contentView.height - [_item.styleSheet paddingV] * 2;

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  _styledImageView.frame =
    CGRectMake(imagePadding.left,
               floor(self.contentView.height -
                     MIN(self.contentView.height, imageSize.height)) / 2,
               imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake(imageWidth + [_item.styleSheet paddingH],
               [_item.styleSheet paddingV],
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithTableView: tableView
                             indexPath: indexPath
                             imageSize: &imageSize
                          imagePadding: &imagePadding];

  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
             height + [_item.styleSheet paddingV] * 2) + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];

    if (nil != object) {
      TTTableLongTextItem* item = object;
      self.textLabel.text = item.text;

      TTDASSERT(nil != _item.styleSheet);
      TTDASSERT(nil != _item.styleSheet.longTextFont);

      self.textLabel.font                 = [_item.styleSheet longTextFont];
      self.textLabel.textColor            = [_item.styleSheet longTextColor];
      self.textLabel.highlightedTextColor = [_item.styleSheet longTextHighlightedColor];
      self.textLabel.lineBreakMode        = [_item.styleSheet longTextLineBreakMode];
      self.textLabel.numberOfLines        = [_item.styleSheet longTextNumberOfLines];
      self.textLabel.textAlignment        = [_item.styleSheet longTextTextAlignment];
    }
  }  
}

@end


/* TODO: CLEANUP


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableFlushViewCell

@synthesize item = _item, view = _view;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell class public

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
  return TT_ROW_HEIGHT;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _item = nil;
    _view = nil;

    self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_item);
  TT_RELEASE_SAFELY(_view);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIView

- (void)layoutSubviews {
  [super layoutSubviews];
  _view.frame = self.contentView.bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell

- (id)object {
  return _item ? _item : (id)_view;
}

- (void)setObject:(id)object {
  if (object != _view && object != _item) {
    [_view removeFromSuperview];
    TT_RELEASE_SAFELY(_view);
    TT_RELEASE_SAFELY(_item);
    
    if ([object isKindOfClass:[UIView class]]) {
      _view = [object retain];
    } else if ([object isKindOfClass:[TTTableViewItem class]]) {
      _item = [object retain];
      _view = [_item.view retain];
    }

    [self.contentView addSubview:_view];
  }  
}

@end
*/
