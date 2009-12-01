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

@class TTStyledText, TTStyle;

/**
 * TTTableItems define the data used to create TTTableItemCells. Each item has a
 * corresponding cell in TTTableItemCell.h/m.
 *
 * Here's a quick overview of the inheritance tree.
 *
 * TTTableItem
 *   \_ TTTableLinkedItem
 *   |   \_ TTTableTitleItem
 *   |   |   \_ TTTableCaptionItem
 *   |   |   |   \_ TTTableRightCaptionItem
 *   |   |   \_ TTTableSubtitleItem
 *   |   |   |   \_ TTTableMessageItem
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

// /-----------------------------\
// | Title title title title ... |
// | Subtitle subtitle subtit... |
// | Text text text text text te |
// | xt text text text text text |
// \-----------------------------/
extern NSString* kTableItemTitleKey;
extern NSString* kTableItemSubtitleKey;
extern NSString* kTableItemTextKey;

// /-----------------------------\
// | Caption:                    |
// \-----------------------------/
extern NSString* kTableItemCaptionKey;

// The URL to navigate to upon tapping the row
extern NSString* kTableItemURLKey;

// The URL to navigate to upon tapping the accessory
extern NSString* kTableItemAccessoryURLKey;

// Where to download the image from
extern NSString* kTableItemImageURLKey;

// A default image that is replaced by URL image if/when it is downloaded.
extern NSString* kTableItemDefaultImageKey;

// Styling applied to the image (here's where you can set borders, padding, size, etc...)
extern NSString* kTableItemImageStyleKey;

// /-----------------------------\
// |                   timestamp |
// | Text text text text text te |
// | xt text text text text text |
// \-----------------------------/
extern NSString* kTableItemTimestampKey;

// A control as seen in the Preferences app
extern NSString* kTableItemControlKey;

// Anything, really
extern NSString* kTableItemViewKey;

///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableItem : NSObject <NSCoding> {
@private
  id _userInfo;
}

@property(nonatomic,retain) id userInfo;

// Used to instantiate the cell object
// By default returns [TTTableTextItemCell class]
-(Class)cellClass;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkedItem : TTTableItem {
@private
  NSString* _URL;
  NSString* _accessoryURL;
}

@property(nonatomic,copy) NSString* URL;
@property(nonatomic,copy) NSString* accessoryURL;

+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableTitleItem : TTTableLinkedItem {
@private
  NSString* _title;
}

@property(nonatomic,copy) NSString* title;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableCaptionItem : TTTableTitleItem {
@private
  NSString* _caption;
}

@property(nonatomic,copy) NSString* caption;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemCaptionKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableRightCaptionItem : TTTableCaptionItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemCaptionKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtitleItem : TTTableTitleItem {
@private
  NSString* _subtitle;
}

@property(nonatomic,copy) NSString* subtitle;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemSubtitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMessageItem : TTTableSubtitleItem {
@private
  NSString* _text;
  NSDate*   _timestamp;
}

@property(nonatomic,copy) NSString* text;
@property(nonatomic,retain) NSDate* timestamp;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemSubtitleKey
 * * kTableItemTextKey
 * * kTableItemTimestampKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


/* TODO: CLEANUP
*/
#if 0
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtextItem : TTTableTitleItem {
@private
  NSString* _text;
}

@property(nonatomic,copy) NSString* text;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemTextKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSummaryItem : TTTableTitleItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLink : TTTableTitleItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableButton : TTTableTitleItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMoreButton : TTTableButton {
@private
  BOOL _isLoading;
}

@property(nonatomic) BOOL isLoading;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableImageItem : TTTableTitleItem {
@private
  NSString* _imageURL;
  UIImage*  _defaultImage;
  TTStyle*  _imageStyle;
}

@property(nonatomic,copy) NSString* imageURL;
@property(nonatomic,retain) UIImage* defaultImage;
@property(nonatomic,retain) TTStyle* imageStyle;

/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableRightImageItem : TTTableImageItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableActivityItem : TTTableTitleItem
/**
 * Properties:
 *
 * * kTableItemTitleKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableTextItem : TTTableLinkedItem {
@private
  NSString* _text;
}

@property(nonatomic,copy) NSString* text;

/**
 * Properties:
 *
 * * kTableItemTextKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableGrayTextItem : TTTableTextItem
/**
 * Properties:
 *
 * * kTableItemTextKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableStyledTextItem : TTTableLinkedItem {
@private
  TTStyledText* _text;
  UIEdgeInsets  _margin;
  UIEdgeInsets  _padding;
}

@property(nonatomic,retain) TTStyledText* text;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIEdgeInsets padding;

/**
 * Properties:
 *
 * * kTableItemTextKey
 * * kTableItemURLKey
 * * kTableItemAccessoryURLKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableControlItem : TTTableItem {
@private
  NSString*   _caption;
  UIControl*  _control;
}

@property(nonatomic,copy) NSString* caption;
@property(nonatomic,retain) UIControl* control;

/**
 * Properties:
 *
 * * kTableItemCaptionKey
 * * kTableItemControlKey
 */
+ (id)itemWithProperties:(NSDictionary*)properties;

- (id)initWithProperties:(NSDictionary*)properties;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableViewItem : TTTableItem {
@private
  NSString* _caption;
  UIView*   _view;
}

@property(nonatomic,copy) NSString* caption;
@property(nonatomic,retain) UIView* view;

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
