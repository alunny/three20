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

#import "Three20/TTTableItem.h"

#import "Three20/TTGlobalCore.h"

NSString* kTableItemTitleKey          = @"title";
NSString* kTableItemSubtitleKey       = @"subtitle";
NSString* kTableItemTextKey           = @"text";

NSString* kTableItemCaptionKey        = @"caption";

NSString* kTableItemURLKey            = @"URL";
NSString* kTableItemAccessoryURLKey   = @"accessoryURL";

NSString* kTableItemImageURLKey       = @"imageURL";
NSString* kTableItemDefaultImageKey   = @"defaultImage";
NSString* kTableItemImageStyleKey     = @"imageStyle";

NSString* kTableItemTimestampKey      = @"timestamp";
NSString* kTableItemControlKey        = @"control";
NSString* kTableItemViewKey           = @"view";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableItem

@synthesize userInfo = _userInfo;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (void)dealloc {
  TT_RELEASE_SAFELY(_userInfo);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableTitleItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  return [self init];
}

- (void)encodeWithCoder:(NSCoder*)encoder {
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkedItem

@synthesize URL = _URL;
@synthesize accessoryURL = _accessoryURL;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super init] ) {
    self.URL          = [properties objectForKey:kTableItemURLKey];
    self.accessoryURL = [properties objectForKey:kTableItemAccessoryURLKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_URL);
  TT_RELEASE_SAFELY(_accessoryURL);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.URL          = [decoder decodeObjectForKey:kTableItemURLKey];
    self.accessoryURL = [decoder decodeObjectForKey:kTableItemAccessoryURLKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (nil != self.URL) {
    [encoder encodeObject:self.URL forKey:kTableItemURLKey];
  }
  if (nil != self.accessoryURL) {
    [encoder encodeObject:self.accessoryURL forKey:kTableItemAccessoryURLKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableTitleItem

@synthesize title = _title;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.title = [properties objectForKey:kTableItemTitleKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_title);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.title = [decoder decodeObjectForKey:kTableItemTitleKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.title) {
    [encoder encodeObject:self.title forKey:kTableItemTitleKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableCaptionItem

@synthesize caption = _caption;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.caption = [properties objectForKey:kTableItemCaptionKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableCaptionItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption = [decoder decodeObjectForKey:kTableItemCaptionKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSubtitleItem

@synthesize subtitle = _subtitle;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.subtitle = [properties objectForKey:kTableItemSubtitleKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_subtitle);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableSubtitleItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.subtitle = [decoder decodeObjectForKey:kTableItemSubtitleKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.subtitle) {
    [encoder encodeObject:self.subtitle forKey:kTableItemSubtitleKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMessageItem

@synthesize text      = _text;
@synthesize timestamp = _timestamp;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.text       = [properties objectForKey:kTableItemTextKey];
    self.timestamp  = [properties objectForKey:kTableItemTimestampKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_text);
  TT_RELEASE_SAFELY(_timestamp);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableMessageItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.text       = [decoder decodeObjectForKey:kTableItemTextKey];
    self.timestamp  = [decoder decodeObjectForKey:kTableItemTimestampKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.text) {
    [encoder encodeObject:self.text forKey:kTableItemTextKey];
  }
  if (self.timestamp) {
    [encoder encodeObject:self.timestamp forKey:kTableItemTimestampKey];
  }
}

@end

/* TODO: CLEANUP
#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSubtextItem

@synthesize text = _text;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.text = [properties objectForKey:kTableItemTextKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_text);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableSubtextItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.text = [decoder decodeObjectForKey:kTableItemTextKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.text) {
    [encoder encodeObject:self.text forKey:kTableItemTextKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableSummaryItem
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLink
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableButton
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableMoreButton

@synthesize isLoading = _isLoading;

-(Class)cellClass {
  return [TTTableMoreButtonCell class];
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableImageItem

@synthesize imageURL      = _imageURL;
@synthesize defaultImage  = _defaultImage;
@synthesize imageStyle    = _imageStyle;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.imageURL     = [properties objectForKey:kTableItemImageURLKey];
    self.defaultImage = [properties objectForKey:kTableItemDefaultImageKey];
    self.imageStyle   = [properties objectForKey:kTableItemImageStyleKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_imageURL);
  TT_RELEASE_SAFELY(_defaultImage);
  TT_RELEASE_SAFELY(_imageStyle);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableImageItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.imageURL = [decoder decodeObjectForKey:kTableItemImageURLKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.imageURL) {
    [encoder encodeObject:self.imageURL forKey:kTableItemImageURLKey];
  }
}
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableRightImageItem
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableActivityItem

-(Class)cellClass {
  return [TTTableActivityItemCell class];
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableTextItem

@synthesize text = _text;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.text = [properties objectForKey:kTableItemTextKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_text);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.text = [decoder decodeObjectForKey:kTableItemTextKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.text) {
    [encoder encodeObject:self.text forKey:kTableItemTextKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableGrayTextItem
@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableStyledTextItem

@synthesize text    = _text;
@synthesize margin  = _margin;
@synthesize padding = _padding;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super initWithProperties:properties] ) {
    self.text = [properties objectForKey:kTableItemTextKey];
    _margin = UIEdgeInsetsZero;
    _padding = UIEdgeInsetsMake(6, 6, 6, 6);
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_text);
  [super dealloc];
}

-(Class)cellClass {
  return [TTStyledTextTableItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.text = [decoder decodeObjectForKey:kTableItemTextKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.text) {
    [encoder encodeObject:self.text forKey:kTableItemTextKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableControlItem

@synthesize caption = _caption;
@synthesize control = _control;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super init] ) {
    self.caption = [properties objectForKey:kTableItemCaptionKey];
    self.control = [properties objectForKey:kTableItemControlKey];
  }

  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_control);
  [super dealloc];
}

-(Class)cellClass {
  return [TTTableControlCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption = [decoder decodeObjectForKey:kTableItemCaptionKey];
    self.control = [decoder decodeObjectForKey:kTableItemControlKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
  if (self.control) {
    [encoder encodeObject:self.control forKey:kTableItemControlKey];
  }
}

@end


#pragma mark -
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableViewItem

@synthesize caption = _caption;
@synthesize view    = _view;

+ (id)itemWithProperties:(NSDictionary*)properties {
  return [[[self alloc] initWithProperties:properties] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

- (id)initWithProperties:(NSDictionary*)properties {
  if( self = [super init] ) {
    self.caption  = [properties objectForKey:kTableItemCaptionKey];
    self.view     = [properties objectForKey:kTableItemViewKey];
  }

  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_caption);
  TT_RELEASE_SAFELY(_view);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.caption = [decoder decodeObjectForKey:kTableItemCaptionKey];
    self.view = [decoder decodeObjectForKey:kTableItemViewKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.caption) {
    [encoder encodeObject:self.caption forKey:kTableItemCaptionKey];
  }
  if (self.view) {
    [encoder encodeObject:self.view forKey:kTableItemViewKey];
  }
}

@end
*/
