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

#import "Three20/TTGlobalUI.h"

#import "Three20/TTTableItem.h"
#import "Three20/TTImageView.h"
#import "Three20/TTStyledTextLabel.h"
#import "Three20/TTTextEditor.h"
#import "Three20/TTURLMap.h"
#import "Three20/TTNavigator.h"
#import "Three20/TTTableStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static const CGFloat kSmallMargin = 6;
static const CGFloat kSpacing = 8;
static const CGFloat kControlPadding = 8;
static const CGFloat kDefaultTextViewLines = 5;

static const CGFloat kMaxLabelHeight = 2000;


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
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: self.styleSheet.padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableLinkedItem class]]);

    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    TTTableLinkedItem* item = object;
    if (![item isKindOfClass:[TTTableLinkedItem class]]) {
      self.accessoryType = UITableViewCellAccessoryNone;
      self.selectionStyle = UITableViewCellSelectionStyleNone;
      return;
    }

    // accessoryURLPath takes priority over URL when setting the accessory type because
    // you can still access URL by tapping the row if there is an accessory button.
    if (nil != item.accessoryURLPath) {
      self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    } else if (nil != item.urlPath) {
      TTNavigationMode navigationMode = [[TTNavigator navigator].URLMap
        navigationModeForURL:item.urlPath];

      if (navigationMode == TTNavigationModeCreate ||
          navigationMode == TTNavigationModeShare) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      } else {
        self.accessoryType = UITableViewCellAccessoryNone;
      }
    }

    // Any URL can be tapped and accessed.
    if (nil != item.urlPath) {
      self.selectionStyle = self.styleSheet.selectionStyle;
    } else {
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (nil == item.urlPath && nil == item.accessoryURLPath) {
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
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  BOOL isImageRightAligned = ((TTTableImageLinkedItem*)_item).imageRightAligned;

  UIEdgeInsets cellPadding = self.styleSheet.padding;
  UIEdgeInsets imagePadding = self.styleSheet.imagePadding;
  CGFloat imageWidthWithPadding =
    imagePadding.left
    + self.styleSheet.imageSize.width
    + imagePadding.right;

  UIEdgeInsets padding = UIEdgeInsetsMake(
    cellPadding.top,
    (isImageRightAligned || nil == _styledImageView) ? cellPadding.left : imageWidthWithPadding,
    cellPadding.bottom,
    (isImageRightAligned && nil != _styledImageView) ? imageWidthWithPadding : cellPadding.right);
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)calculateContentWidthWithImageSize: (CGSize*)pImageSize
                                 imagePadding: (UIEdgeInsets*)pImagePadding {
  UIEdgeInsets padding = self.styleSheet.padding;
  CGFloat contentWidth = self.contentView.width;

  CGSize imageSize;
  UIEdgeInsets imagePadding;

  if (nil != _styledImageView) {
    imageSize     = self.styleSheet.imageSize;
    imagePadding  = self.styleSheet.imagePadding;
    contentWidth -= imageSize.width + imagePadding.left + imagePadding.right;

    TTTableImageLinkedItem* imageItem = (TTTableImageLinkedItem*)_item;
    if (imageItem.imageRightAligned) {
      contentWidth -= self.styleSheet.padding.left;
    } else {
      contentWidth -= self.styleSheet.padding.right;
    }

    CGFloat imageHeight = imageSize.height + imagePadding.top + imagePadding.bottom;

    // Is the image too tall for this cell?
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
    contentWidth -= (padding.left + padding.right);
    imageSize     = CGSizeZero;
    imagePadding  = UIEdgeInsetsZero;
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
    imageSize     = self.styleSheet.imageSize;
    imagePadding  = self.styleSheet.imagePadding;

  } else {
    imageSize     = CGSizeZero;
    imagePadding  = UIEdgeInsetsZero;
  }

  *pImageSize = imageSize;
  *pImagePadding = imagePadding;

  return contentWidth;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableImageLinkedItem class]]);

    // We've just ensured that _item != object, so a release/retain is fine here.
    [super setObject:object];

    [_styledImageView removeFromSuperview];
    TT_RELEASE_SAFELY(_styledImageView);

    TTTableImageLinkedItem* item = object;

    if (nil != item.image || TTIsStringWithAnyText(item.imageURLPath)) {
      _styledImageView = [[TTImageView alloc] init];
      _styledImageView.defaultImage = item.image;
      _styledImageView.URL          = item.imageURLPath;
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
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:self.styleSheet.padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  UIEdgeInsets padding = self.styleSheet.padding;

  CGSize imageSize;
  UIEdgeInsets imagePadding;
  CGFloat contentWidth = [self
    calculateContentWidthWithImageSize: &imageSize
                          imagePadding: &imagePadding];
  CGFloat imageWidth = imageSize.width + imagePadding.left + imagePadding.right;

  CGFloat titleHeight = [self.textLabel heightWithWidth:contentWidth];

  NSArray* labels = [[NSArray alloc] initWithObjects:
    self.textLabel,
    nil];
  NSMutableArray* labelHeights = [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithFloat:titleHeight],
    nil];
  [self optimizeLabels:labels heights:labelHeights];
  TT_RELEASE_SAFELY(labels);

  titleHeight = [[labelHeights objectAtIndex:0] floatValue];

  TT_RELEASE_SAFELY(labelHeights);

  BOOL isImageRightAligned = ((TTTableImageLinkedItem*)_item).imageRightAligned;

  // Centered images.
  // floor(self.contentView.height
  //          - MIN(self.contentView.height, imageSize.height)) / 2

  _styledImageView.frame =
    CGRectMake((isImageRightAligned
        ? (self.contentView.width - imagePadding.right - imageSize.width)
        : imagePadding.left),
      imagePadding.top,
      imageSize.width, imageSize.height);

  self.textLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top, contentWidth, titleHeight);
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
             height + self.styleSheet.padding.top + self.styleSheet.padding.bottom)
         + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableTitleItem class]]);

    [super setObject:object];

    TTTableTitleItem* item = object;

    self.textLabel.text = item.title;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.titleFont);

    self.textLabel.font                 = [self.styleSheet titleFont];
    self.textLabel.textColor            = [self.styleSheet titleColor];
    self.textLabel.highlightedTextColor = [self.styleSheet titleHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet titleLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet titleNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet titleTextAlignment];
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
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:self.styleSheet.padding];
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

  BOOL isImageRightAligned = ((TTTableImageLinkedItem*)_item).imageRightAligned;

  _styledImageView.frame =
    CGRectMake((isImageRightAligned
        ? (self.contentView.width - imagePadding.right - imageSize.width)
        : imagePadding.left),
      imagePadding.top,
      imageSize.width, imageSize.height);

  UIEdgeInsets padding = self.styleSheet.padding;

  self.textLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top, contentWidth, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top + titleHeight,
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
             titleHeight + subtitleHeight
             + self.styleSheet.padding.top + self.styleSheet.padding.bottom) +
         [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableSubtitleItem class]]);

    [super setObject:object];

    TTTableSubtitleItem* item = object;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.titleFont);

    self.textLabel.font                 = [self.styleSheet titleFont];
    self.textLabel.textColor            = [self.styleSheet titleColor];
    self.textLabel.highlightedTextColor = [self.styleSheet titleHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet titleLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet titleNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet titleTextAlignment];

    TTDASSERT(nil != self.styleSheet.subtitleFont);

    self.detailTextLabel.font                 = [self.styleSheet subtitleFont];
    self.detailTextLabel.textColor            = [self.styleSheet subtitleColor];
    self.detailTextLabel.highlightedTextColor = [self.styleSheet subtitleHighlightedColor];
    self.detailTextLabel.lineBreakMode        = [self.styleSheet subtitleLineBreakMode];
    self.detailTextLabel.numberOfLines        = [self.styleSheet subtitleNumberOfLines];
    self.detailTextLabel.textAlignment        = [self.styleSheet subtitleTextAlignment];
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
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:self.styleSheet.padding];
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

  timestampSize.width += self.styleSheet.timestampSpacing;

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

  if (titleHeight > 0) {
    titleHeight = MAX(titleHeight, timestampSize.height);
  } else if (subtitleHeight > 0) {
    subtitleHeight = MAX(subtitleHeight, timestampSize.height);
  } else if (messageHeight > 0) {
    messageHeight = MAX(messageHeight, timestampSize.height);
  }

  TT_RELEASE_SAFELY(labelHeights);

  BOOL isImageRightAligned = ((TTTableImageLinkedItem*)_item).imageRightAligned;

  _styledImageView.frame =
    CGRectMake((isImageRightAligned
        ? (self.contentView.width - imagePadding.right - imageSize.width)
        : imagePadding.left),
      imagePadding.top,
      imageSize.width, imageSize.height);

  UIEdgeInsets padding = self.styleSheet.padding;

  self.textLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top, contentWidth - timestampSize.width, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top + titleHeight,
               contentWidth - ((titleHeight > 0) ? 0 : timestampSize.width), subtitleHeight);

  self.messageLabel.frame =
    CGRectMake(((isImageRightAligned || nil == _styledImageView) ? padding.left : imageWidth),
               padding.top + titleHeight + subtitleHeight,
               contentWidth - ((titleHeight > 0 || subtitleHeight > 0) ? 0 : timestampSize.width),
               messageHeight);

  CGFloat entireContentWidth = ((isImageRightAligned || nil == _styledImageView)
    ? padding.left
    : imageWidth) + contentWidth;
  self.timestampLabel.frame =
    CGRectMake(entireContentWidth - timestampSize.width,
               self.styleSheet.padding.top,
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

  timestampSize.width += self.styleSheet.timestampSpacing;

  CGFloat titleHeight     = [self.textLabel heightWithWidth:contentWidth - timestampSize.width];
  CGFloat subtitleHeight  = [self.detailTextLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0) ? 0 : timestampSize.width)];
  CGFloat messageHeight   = [self.messageLabel heightWithWidth:contentWidth -
                              ((titleHeight > 0 || subtitleHeight > 0) ? 0 : timestampSize.width)];

  if (titleHeight > 0) {
    titleHeight = MAX(titleHeight, timestampSize.height);
  } else if (subtitleHeight > 0) {
    subtitleHeight = MAX(subtitleHeight, timestampSize.height);
  } else if (messageHeight > 0) {
    messageHeight = MAX(messageHeight, timestampSize.height);
  }

  return
    MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
        titleHeight + subtitleHeight + messageHeight
        + (self.styleSheet.padding.top + self.styleSheet.padding.bottom))
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableMessageItem class]]);

    [super setObject:object];

    TTTableMessageItem* item = object;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    self.messageLabel.text = item.message;
    self.timestampLabel.text = [item.timestamp formatShortTime];

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.titleFont);

    self.textLabel.font                 = [self.styleSheet titleFont];
    self.textLabel.textColor            = [self.styleSheet titleColor];
    self.textLabel.highlightedTextColor = [self.styleSheet titleHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet titleLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet titleNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet titleTextAlignment];

    TTDASSERT(nil != self.styleSheet.subtitleFont);

    self.detailTextLabel.font                 = [self.styleSheet subtitleFont];
    self.detailTextLabel.textColor            = [self.styleSheet messageSubtitleColor];
    self.detailTextLabel.highlightedTextColor =
      [self.styleSheet messageSubtitleHighlightedColor];
    self.detailTextLabel.lineBreakMode        = [self.styleSheet subtitleLineBreakMode];
    self.detailTextLabel.numberOfLines        = [self.styleSheet subtitleNumberOfLines];
    self.detailTextLabel.textAlignment        = [self.styleSheet subtitleTextAlignment];

    TTDASSERT(nil != self.styleSheet.messageFont);

    self.messageLabel.font                 = [self.styleSheet messageFont];
    self.messageLabel.textColor            = [self.styleSheet messageColor];
    self.messageLabel.highlightedTextColor = [self.styleSheet messageHighlightedColor];
    self.messageLabel.lineBreakMode        = [self.styleSheet messageLineBreakMode];
    self.messageLabel.numberOfLines        = [self.styleSheet messageNumberOfLines];
    self.messageLabel.textAlignment        = [self.styleSheet messageTextAlignment];

    TTDASSERT(nil != self.styleSheet.timestampFont);

    self.timestampLabel.font                 = [self.styleSheet timestampFont];
    self.timestampLabel.textColor            = [self.styleSheet timestampColor];
    self.timestampLabel.highlightedTextColor = [self.styleSheet timestampHighlightedColor];
    self.timestampLabel.textAlignment        = [self.styleSheet timestampTextAlignment];
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

  CGFloat captionWidth = self.styleSheet.captionWidth;
  CGFloat captionHeight = MIN(
    self.contentView.height - (self.styleSheet.padding.top + self.styleSheet.padding.bottom),
    [self.textLabel heightWithWidth:captionWidth]);

  CGFloat titleWidth = self.contentView.width
    - (self.styleSheet.captionWidth + self.styleSheet.captionSpacing
       + self.styleSheet.padding.left + self.styleSheet.padding.right);
  CGFloat titleHeight = MIN(
    self.contentView.height - (self.styleSheet.padding.top + self.styleSheet.padding.bottom),
    [self.detailTextLabel heightWithWidth:titleWidth]);

  // We want to align the baseline of the caption and the title, so we calculate
  // the difference in ascender heights and offset one or the other such that they align.
  CGFloat fontCapHeightDifference =
    self.detailTextLabel.font.ascender - self.textLabel.font.ascender;

  self.textLabel.frame = CGRectMake(
    self.styleSheet.padding.left,         // Without the 0.5, this tends to be one pixel off.
    round(self.styleSheet.padding.top + MAX(0, fontCapHeightDifference - 0.5)),
    captionWidth, captionHeight);

  self.detailTextLabel.frame = CGRectMake(
    self.styleSheet.padding.left + self.styleSheet.captionWidth + self.styleSheet.captionSpacing,
    round(self.styleSheet.padding.top + MAX(0, -fontCapHeightDifference + 0.5)),
    titleWidth, titleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];

  CGFloat captionWidth = self.styleSheet.captionWidth;
  CGFloat captionHeight = [self.textLabel heightWithWidth:captionWidth];

  CGFloat titleWidth = contentWidth
    - (self.styleSheet.captionWidth + self.styleSheet.captionSpacing);
  CGFloat titleHeight = [self.detailTextLabel heightWithWidth:titleWidth];

  return MAX(captionHeight, titleHeight)
    + (self.styleSheet.padding.top + self.styleSheet.padding.bottom)
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableCaptionItem class]]);

    [super setObject:object];

    TTTableCaptionItem* item = object;
    self.textLabel.text = item.caption;
    self.detailTextLabel.text = item.title;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.captionFont);

    self.textLabel.font                      = [self.styleSheet captionFont];
    self.textLabel.textColor                 = [self.styleSheet captionColor];
    self.textLabel.highlightedTextColor      = [self.styleSheet captionHighlightedColor];
    self.textLabel.lineBreakMode             = [self.styleSheet captionLineBreakMode];
    self.textLabel.numberOfLines             = [self.styleSheet captionNumberOfLines];
    self.textLabel.textAlignment             = [self.styleSheet captionTextAlignment];
    self.textLabel.adjustsFontSizeToFitWidth =
      [self.styleSheet captionAdjustsFontSizeToFitWidth];
    self.textLabel.minimumFontSize           = [self.styleSheet captionMinimumFontSize];

    TTDASSERT(nil != self.styleSheet.captionTitleFont);

    self.detailTextLabel.font                 = [self.styleSheet captionTitleFont];
    self.detailTextLabel.textColor            = [self.styleSheet captionTitleColor];
    self.detailTextLabel.highlightedTextColor = [self.styleSheet captionTitleHighlightedColor];
    self.detailTextLabel.lineBreakMode        = [self.styleSheet captionTitleLineBreakMode];
    self.detailTextLabel.numberOfLines        = [self.styleSheet captionTitleNumberOfLines];
    self.detailTextLabel.textAlignment        = [self.styleSheet captionTitleTextAlignment];
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

  const CGFloat paddedCellHeight = self.contentView.height
    - (self.styleSheet.padding.top + self.styleSheet.padding.bottom);

  CGFloat contentWidth = self.contentView.width
    - self.styleSheet.padding.left - self.styleSheet.padding.right;

  self.textLabel.frame =
    CGRectMake(self.styleSheet.padding.left, self.styleSheet.padding.top,
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = self.styleSheet.padding.left;
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return height + (self.styleSheet.padding.top + self.styleSheet.padding.bottom)
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableSummaryItem class]]);

    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    TTTableSummaryItem* item = object;
    self.textLabel.text = item.title;

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.summaryFont);

    self.textLabel.font                      = [self.styleSheet summaryFont];
    self.textLabel.textColor                 = [self.styleSheet summaryColor];
    self.textLabel.highlightedTextColor      = [self.styleSheet summaryHighlightedColor];
    self.textLabel.lineBreakMode             = [self.styleSheet summaryLineBreakMode];
    self.textLabel.numberOfLines             = [self.styleSheet summaryNumberOfLines];
    self.textLabel.textAlignment             = [self.styleSheet summaryTextAlignment];
    self.textLabel.adjustsFontSizeToFitWidth =
      [self.styleSheet summaryAdjustsFontSizeToFitWidth];
    self.textLabel.minimumFontSize           = [self.styleSheet summaryMinimumFontSize];
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

  const CGFloat paddedCellHeight = self.contentView.height
    - (self.styleSheet.padding.top + self.styleSheet.padding.bottom);

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
    CGRectMake(imageWidth + self.styleSheet.padding.left,
               self.styleSheet.padding.top,
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
             height + (self.styleSheet.padding.top + self.styleSheet.padding.bottom))
         + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableTitleItem class]]);

    [super setObject:object];

    TTTableTitleItem* item = object;
    self.textLabel.text = item.title;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.linkFont);

    self.textLabel.font                 = [self.styleSheet linkFont];
    self.textLabel.textColor            = [self.styleSheet linkColor];
    self.textLabel.highlightedTextColor = [self.styleSheet linkHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet linkLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet linkNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet linkTextAlignment];
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

  const CGFloat paddedCellHeight = self.contentView.height
    - (self.styleSheet.padding.top + self.styleSheet.padding.bottom);
  CGFloat contentWidth = self.contentView.width
    - self.styleSheet.padding.left - self.styleSheet.padding.right;

  self.textLabel.frame =
    CGRectMake(self.styleSheet.padding.left, self.styleSheet.padding.top,
               contentWidth, paddedCellHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat height = [self.textLabel heightWithWidth:contentWidth];
  return height + (self.styleSheet.padding.top + self.styleSheet.padding.bottom)
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableButtonItem class]]);

    [super setObject:object];

    TTTableButtonItem* item = object;
    self.textLabel.text = item.title;

    self.accessoryType = UITableViewCellAccessoryNone;
    if (TTIsStringWithAnyText(item.urlPath)) {
      self.selectionStyle = [self.styleSheet selectionStyle];
    } else {
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.buttonFont);

    self.textLabel.font                      = [self.styleSheet buttonFont];
    self.textLabel.textColor                 = [self.styleSheet buttonColor];
    self.textLabel.highlightedTextColor      = [self.styleSheet buttonHighlightedColor];
    self.textLabel.lineBreakMode             = [self.styleSheet buttonLineBreakMode];
    self.textLabel.numberOfLines             = [self.styleSheet buttonNumberOfLines];
    self.textLabel.textAlignment             = [self.styleSheet buttonTextAlignment];
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
    self.styleSheet.padding.top,
    self.styleSheet.padding.left,
    self.styleSheet.padding.top,
    self.styleSheet.padding.left);
  [self optimizeLabels:labels heights:calculatedLabelHeights padding:padding];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat contentWidth = self.contentView.width
    - self.styleSheet.padding.left - self.styleSheet.padding.right;
  CGFloat textContentWidth =
    contentWidth - self.activityIndicatorView.width - self.styleSheet.padding.left;

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

  self.activityIndicatorView.left = self.styleSheet.padding.left;
  self.activityIndicatorView.top =
    floor((self.contentView.height - self.activityIndicatorView.height) / 2);

  CGFloat centeredYOffset = floor((self.contentView.height - (titleHeight + subtitleHeight)) / 2);

  self.textLabel.frame =
    CGRectMake(self.activityIndicatorView.right + self.styleSheet.padding.left,
               centeredYOffset,
               textContentWidth, titleHeight);

  self.detailTextLabel.frame =
    CGRectMake(self.activityIndicatorView.right + self.styleSheet.padding.left,
               centeredYOffset + titleHeight,
               textContentWidth, subtitleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = self.styleSheet.padding.left;
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat textContentWidth =
    contentWidth - self.activityIndicatorView.width - self.styleSheet.padding.left;

  CGFloat titleHeight = [self.textLabel heightWithWidth:textContentWidth];
  CGFloat subtitleHeight = [self.detailTextLabel heightWithWidth:textContentWidth];
  return MAX(self.activityIndicatorView.height,
             MAX(TT_ROW_HEIGHT * 3/2, titleHeight + subtitleHeight)) +
         (self.styleSheet.padding.top + self.styleSheet.padding.bottom) +
         [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableMoreButtonItem class]]);

    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    TTTableMoreButtonItem* item = object;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    self.animating = item.isLoading;

    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = [self.styleSheet selectionStyle];

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.moreButtonFont);

    self.textLabel.font                 = [self.styleSheet moreButtonFont];
    self.textLabel.textColor            = [self.styleSheet moreButtonColor];
    self.textLabel.highlightedTextColor = [self.styleSheet moreButtonHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet moreButtonLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet moreButtonNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet moreButtonTextAlignment];

    TTDASSERT(nil != self.styleSheet.moreButtonSubtitleFont);

    self.detailTextLabel.font                 = [self.styleSheet moreButtonSubtitleFont];
    self.detailTextLabel.textColor            = [self.styleSheet moreButtonSubtitleColor];
    self.detailTextLabel.highlightedTextColor =
      [self.styleSheet moreButtonSubtitleHighlightedColor];
    self.detailTextLabel.lineBreakMode        =
      [self.styleSheet moreButtonSubtitleLineBreakMode];
    self.detailTextLabel.numberOfLines        =
      [self.styleSheet moreButtonSubtitleNumberOfLines];
    self.detailTextLabel.textAlignment        =
      [self.styleSheet moreButtonSubtitleTextAlignment];
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
    (self.styleSheet.padding.top + self.styleSheet.padding.bottom)
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableActivityItem class]]);

    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    TTTableActivityItem* item = object;

    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    TTDASSERT(nil != self.styleSheet);

    [_activityLabel removeFromSuperview];
    TT_RELEASE_SAFELY(_activityLabel);
    _activityLabel = [[TTActivityLabel alloc]
      initWithStyle:[self.styleSheet activityLabelStyle]];
    [self.contentView addSubview:_activityLabel];

    self.activityLabel.text = item.title;
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
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableStyledTextItem class]]);

    [super setObject:object];

    TTTableStyledTextItem* item = object;
    if ([item isKindOfClass:[TTTableStyledTextItem class]]) {
      _label.text = item.styledText;
      _label.contentInset = item.padding;
    } else if ([item isKindOfClass:[TTStyledText class]]) {
      _label.text = (TTStyledText*)item;
      _label.contentInset = UIEdgeInsetsZero;
    } else {
      _label.text = nil;
      _label.contentInset = UIEdgeInsetsZero;    
    }

    if (!_label.text.font) {
      _label.text.font = [self.styleSheet styledTextFont];
    }
  }  
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableControlItemCell

@synthesize item = _item;


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)shouldConsiderControlIntrinsicSize:(UIView*)view {
  return [view isKindOfClass:[UISwitch class]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)shouldSizeControlToFit:(UIView*)view {
  return [view isKindOfClass:[UITextView class]]
         || [view isKindOfClass:[TTTextEditor class]]
         || [view isKindOfClass:[UISlider class]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)shouldRespectControlPadding:(UIView*)view {
  return [view isKindOfClass:[UITextField class]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _item = nil;
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_item);

	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  if ([TTTableControlItemCell shouldSizeControlToFit:_item.control]) {
    if ([_item.control isKindOfClass:[UISlider class]]) {
      _item.control.frame = CGRectInset(self.contentView.bounds, kControlPadding, 0);
    } else {
      _item.control.frame = CGRectInset(self.contentView.bounds, 2, kSpacing/2);
    }
  } else {
    CGFloat minX = kControlPadding;
    CGFloat contentWidth = self.contentView.width - kControlPadding;
    if (![TTTableControlItemCell shouldRespectControlPadding:_item.control]) {
      contentWidth -= kControlPadding;
    }
    if (self.textLabel.text.length) {
      CGSize textSize = [self.textLabel sizeThatFits:self.contentView.bounds.size];
      contentWidth -= textSize.width + kSpacing;
      minX += textSize.width + kSpacing;
    }

    if (!_item.control.height) {
      [_item.control sizeToFit];
    }
    
    if ([TTTableControlItemCell shouldConsiderControlIntrinsicSize:_item.control]) {
      minX += contentWidth - _item.control.width;
    }
    
    // XXXjoe For some reason I need to re-add the control as a subview or else
    // the re-use of the cell will cause the control to fail to paint itself on occasion
    [self.contentView addSubview:_item.control];
    _item.control.frame = CGRectMake(minX, floor((self.contentView.height - _item.control.height) / 2),
                                contentWidth, _item.control.height);
  }

  CGFloat contentWidth = self.contentView.width
    - self.styleSheet.padding.left - self.styleSheet.padding.right;
  CGFloat textContentWidth = contentWidth - _item.control.width;

  if (![TTTableControlItemCell shouldRespectControlPadding:_item.control]) {
    textContentWidth += kControlPadding;
  }

  CGFloat titleHeight;
  if ([TTTableControlItemCell shouldSizeControlToFit:_item.control]) {
    titleHeight = 0;
  } else {
    titleHeight = [self.textLabel heightWithWidth:textContentWidth];
  }

  self.textLabel.frame =
    CGRectMake(self.styleSheet.padding.left, floor((self.contentView.height - titleHeight) / 2),
               textContentWidth, titleHeight);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  if (self.superview) {
    _item.control.backgroundColor = self.backgroundColor;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat padding = self.styleSheet.padding.left;
  return [self contentWidthWithTableView: tableView
                               indexPath: indexPath
                                 padding: UIEdgeInsetsMake(padding, padding, padding, padding)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  UIView* view = _item.control;

  [view sizeToFit];
  CGFloat height = view.height;
  if (0 == height) {
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
      height = view.height;
    }
  }

  CGFloat contentWidth = [self contentWidthWithTableView:tableView indexPath:indexPath];
  CGFloat textContentWidth = contentWidth - _item.control.width;

  CGFloat titleHeight;

  if ([TTTableControlItemCell shouldSizeControlToFit:_item.control]) {
    titleHeight = 0;
  } else {
    titleHeight = [self.textLabel heightWithWidth:textContentWidth];
  }

  return
    MAX(TT_ROW_HEIGHT, MAX(titleHeight, height)
    + (self.styleSheet.padding.top + self.styleSheet.padding.bottom))
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (object != _item) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableControlItem class]]);

    [_item.control removeFromSuperview];

    // We've just ensured that _item != object, so a release/retain is fine here.
    [_item release];
    _item = [object retain];

    if (nil != _item.control) {
      [self.contentView addSubview:_item.control];
    }
    self.textLabel.text = _item.caption;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.controlCaptionFont);

    self.textLabel.font                 = [self.styleSheet controlCaptionFont];
    self.textLabel.textColor            = [self.styleSheet controlCaptionColor];
    self.textLabel.highlightedTextColor = [self.styleSheet controlCaptionHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet controlCaptionLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet controlCaptionNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet controlCaptionTextAlignment];

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

  const CGFloat paddedCellHeight = self.contentView.height
    - (self.styleSheet.padding.top + self.styleSheet.padding.bottom);

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
    CGRectMake(imageWidth + self.styleSheet.padding.left,
               self.styleSheet.padding.top,
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
  return
    MAX(imageSize.height + imagePadding.top + imagePadding.bottom,
        height + (self.styleSheet.padding.top + self.styleSheet.padding.bottom))
    + [tableView tableCellExtraHeight];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
  if (_item != object) {
    TTDASSERT(nil == object || [object isKindOfClass:[TTTableLongTextItem class]]);

    [super setObject:object];

    TTTableLongTextItem* item = object;
    self.textLabel.text = item.text;

    TTDASSERT(nil != self.styleSheet);
    TTDASSERT(nil != self.styleSheet.longTextFont);

    self.textLabel.font                 = [self.styleSheet longTextFont];
    self.textLabel.textColor            = [self.styleSheet longTextColor];
    self.textLabel.highlightedTextColor = [self.styleSheet longTextHighlightedColor];
    self.textLabel.lineBreakMode        = [self.styleSheet longTextLineBreakMode];
    self.textLabel.numberOfLines        = [self.styleSheet longTextNumberOfLines];
    self.textLabel.textAlignment        = [self.styleSheet longTextTextAlignment];
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
