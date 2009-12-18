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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TTStyledText;
@class TTStyle;

/**
 * TTTableItems define the data used to create TTTableItemCells. Each item has a
 * corresponding cell in TTTableItemCell.h/m.
 *
 * Here's a quick overview of the inheritance tree.
 *
 * TTTableItem
 *   \_ TTTableLinkedItem
 *   |   \_ TTTableTitleItem
 *   |   |   \_ TTTableSubtitleItem
 *   |   |   |   \_ TTTableMessageItem
 *   |   |   \_ TTTableCaptionItem
 *   |   |   \_ TTTableSubtextItem
 *   |   |   \_ TTTableSummaryItem
 *   |   |   \_ TTTableLink
 *   |   |   \_ TTTableButton
 *   |   |   |   \_ TTTableMoreButton
 *   |   |   \_ TTTableImageItem
 *   |   |   |   \_ TTTableRightImageItem
 *   |   |   \_ TTTableActivityItem
 *   |   \_ TTTableTextItem
 *   |   |   \_ TTTableGrayTextItem
 *   |   \_ TTTableStyledTextItem
 *   \_ TTTableControlItem
 *   \_ TTTableViewItem
 *
 * All table items are initialized with the itemWithProperties: or initWithProperties methods.
 * These methods accept an NSDictionary* parameter. See each class for the accepted properties.
 * Use the list of key definitions below to ensure consistency when setting the property
 * values.
 *
 */

///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableItem : NSObject <NSCoding> {
@private
  id _userInfo;
}

@property (nonatomic, retain) id userInfo;

/**
 * @return An autoreleased instance of this object.
 */
+ (id)item;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  userInfo           An NSObject that will be retained for the lifespan of this cell.
 * @return self
 */
- (TTTableItem*)applyUserInfo:(id)userInfo;

/**
 * @return The class name used to instantiate the table view cell for this item.
 * @default nil
 */
-(Class)cellClass;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkedItem : TTTableItem {
@private
  NSString* _urlPath;
  NSString* _accessoryURLPath;
}

@property (nonatomic, copy) NSString* urlPath;
@property (nonatomic, copy) NSString* accessoryURLPath;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  userURLPath        The URL accessed when this cell is tapped.
 * @return self
 */
- (TTTableLinkedItem*)applyURLPath:(NSString*)urlPath;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  userURLPath        The URL accessed when this cell is tapped.
 * @return self
 */
- (TTTableLinkedItem*)applyAccessoryURLPath:(NSString*)accessoryURLPath;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableImageLinkedItem : TTTableLinkedItem {
@private
  UIImage*  _image;
  NSString* _imageURLPath;
  TTStyle*  _imageStyle;
  BOOL      _imageRightAligned;
}

@property (nonatomic, retain) UIImage*  image;
@property (nonatomic, copy)   NSString* imageURLPath;
@property (nonatomic, retain) TTStyle*  imageStyle;
@property (nonatomic)         BOOL      imageRightAligned;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  image              An image that is displayed immediately and replaced by any image
 *                            downloaded from imageURLPath.
 * @return self
 */
- (TTTableImageLinkedItem*)applyImage:(UIImage*)image;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  imageURLPath       Path to a URL of an image. This image will be asynchronously
 *                            downloaded.
 * @return self
 */
- (TTTableImageLinkedItem*)applyImageURLPath:(NSString*)imageURLPath;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  imageStyle         A style to apply to the image item.
 * @return self
 */
- (TTTableImageLinkedItem*)applyImageStyle:(TTStyle*)imageStyle;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  imageRightAligned  A style to apply to the image item.
 * @return self
 */
- (TTTableImageLinkedItem*)applyImageRightAligned:(BOOL)imageRightAligned;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableTitleItem : TTTableImageLinkedItem {
@private
  NSString* _title;
}

@property (nonatomic, copy) NSString* title;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  title              The title text.
 * @return self
 */
- (TTTableTitleItem*)applyTitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtitleItem : TTTableTitleItem {
@private
  NSString* _subtitle;
}

@property (nonatomic, copy) NSString* subtitle;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  subtitle           The subtitle text.
 * @return self
 */
- (TTTableSubtitleItem*)applySubtitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMessageItem : TTTableSubtitleItem {
@private
  NSString* _message;
  NSDate*   _timestamp;
}

@property (nonatomic, copy)   NSString* message;
@property (nonatomic, retain) NSDate*   timestamp;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  message            The message text.
 * @return self
 */
- (TTTableMessageItem*)applyMessage:(NSString*)message;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  timestamp          The timestamp of this message.
 * @return self
 */
- (TTTableMessageItem*)applyTimestamp:(NSDate*)timestamp;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableCaptionItem : TTTableLinkedItem {
@private
  NSString* _caption;
  NSString* _title;
}

@property (nonatomic, copy) NSString* caption;
@property (nonatomic, copy) NSString* title;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  caption            The caption text.
 * @return self
 */
- (TTTableCaptionItem*)applyCaption:(NSString*)caption;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  title              The title text.
 * @return self
 */
- (TTTableCaptionItem*)applyTitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSummaryItem : TTTableItem {
@private
  NSString* _title;
}

@property (nonatomic, copy) NSString* title;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  title              The title text.
 * @return self
 */
- (TTTableSummaryItem*)applyTitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkItem : TTTableTitleItem
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableButtonItem : TTTableLinkedItem {
@private
  NSString* _title;
}

@property (nonatomic, copy) NSString* title;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  title              The title text.
 * @return self
 */
- (TTTableButtonItem*)applyTitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMoreButtonItem : TTTableButtonItem {
@private
  NSString* _subtitle;
  BOOL      _isLoading;
}

@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic)       BOOL      isLoading;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  subtitle           The subtitle text.
 * @return self
 */
- (TTTableMoreButtonItem*)applySubtitle:(NSString*)subtitle;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  isLoading          Whether or not the button is loading.
 * @return self
 */
- (TTTableMoreButtonItem*)applyIsLoading:(BOOL)isLoading;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableActivityItem : TTTableItem {
@private
  NSString* _title;
}

@property (nonatomic, copy) NSString* title;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  title              The title text.
 * @return self
 */
- (TTTableActivityItem*)applyTitle:(NSString*)title;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableStyledTextItem : TTTableImageLinkedItem {
@private
  TTStyledText* _styledText;
  UIEdgeInsets  _margin;
  UIEdgeInsets  _padding;
}

@property (nonatomic, retain) TTStyledText* styledText;
@property (nonatomic)         UIEdgeInsets  margin;
@property (nonatomic)         UIEdgeInsets  padding;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  styledText         The styled text.
 * @return self
 */
- (TTTableStyledTextItem*)applyStyledText:(TTStyledText*)styledText;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  margin             The margin of the cell.
 * @return self
 */
- (TTTableStyledTextItem*)applyMargin:(UIEdgeInsets)margin;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  padding            The padding of the cell.
 * @return self
 */
- (TTTableStyledTextItem*)applyPadding:(UIEdgeInsets)padding;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableControlItem : TTTableItem {
@private
  NSString*   _caption;
  UIControl*  _control;
}

@property (nonatomic, copy)   NSString*   caption;
@property (nonatomic, retain) UIControl*  control;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  caption            The caption text.
 * @return self
 */
- (TTTableControlItem*)applyCaption:(NSString*)caption;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  control            The control.
 * @return self
 */
- (TTTableControlItem*)applyControl:(UIControl*)control;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLongTextItem : TTTableImageLinkedItem {
@private
  NSString* _text;
}

@property (nonatomic, copy) NSString* text;

/**
 * A chaining method. Designed to return self so that you can apply more properties.
 *
 * @param  text              The message text.
 * @return self
 */
- (TTTableLongTextItem*)applyText:(NSString*)text;

@end


/* TODO: CLEANUP
*/
#if 0


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableGrayTextItem : TTTableTextItem
/**
 * Properties:
 *
 * * kTableItemMessageKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 * * kTableItemImageKey
 * * kTableItemImageURLKey
 * * kTableItemImageStyleKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableViewItem : TTTableItem {
@private
  NSString* _caption;
  UIView*   _view;
}

@property (nonatomic, copy) NSString* caption;
@property (nonatomic, retain) UIView* view;

/**
 * Properties:
 *
 * * kTableItemCaptionKey
 * * kTableItemViewKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end
#endif
