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

#import "TableImageItemCatalogController.h"


static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
 eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TableImageItemCatalogController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if (self = [super init]) {
    self.title = @"Table Item Catalog";

    self.variableHeightRows = YES;

    NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";
    UIImage* defaultPerson = TTIMAGE(@"bundle://defaultPerson.png");
    TTStyle* imageStyle = 
      [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
      [TTSolidBorderStyle styleWithColor:[UIColor lightGrayColor] width:1 next:
      [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(3, 3, 3, 3) next:
      [TTContentStyle styleWithNext:nil]]]]];

    TTSectionedDataSource* dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Left aligned",
      [[[[[TTTableTitleItem item]
        applyTitle:@"TTTableTitleItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle],
      [[[[[[TTTableSubtitleItem item]
        applySubtitle:@"TTTableSubtitleItems are TTTableTitleItems with a subtitle"]
        applyTitle:@"TTTableSubtitleItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle],
      [[[[[[[[TTTableMessageItem item]
        applyTimestamp:[NSDate date]]
        applyMessage:@"TTTableMessageItems are TTTableSubtitleItems with a message/time"]
        applySubtitle:@"This message will generally span multiple lines"]
        applyTitle:@"TTTableMessageItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle],
      [[[TTTableCaptionItem item]
        applyCaption:@"Caption"]
        applyTitle:@"TTTableCaptionItem"],
      [[TTTableSummaryItem item]
        applyTitle:@"TTTableSummaryItem"],
      [[TTTableLinkItem item]
        applyTitle:@"TTTableLinkItem"],
      [[TTTableButtonItem item]
        applyTitle:@"TTTableButtonItem"],
      [[[TTTableMoreButtonItem item]
        applySubtitle:@"With subtitle text"]
        applyTitle:@"TTTableMoreButtonItem"],
      [[TTTableActivityItem item]
        applyTitle:@"TTTableActivityItem"],
      [[TTTableStyledTextItem item]
        applyStyledText:[TTStyledText textFromXHTML:@"This is a whole bunch of text made from \
characters and followed by this URL http://bit.ly/1234"]],
      [[[TTTableControlItem item]
        applyControl:[[[UISwitch alloc] init] autorelease]]
        applyCaption:@"TTTableControlItem"],
      [[[TTTableControlItem item]
        applyControl:[[[UISlider alloc] init] autorelease]]
        applyCaption:@"TTTableControlItem"],
      [[[[[TTTableLongTextItem item]
        applyText:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle],

      @"Right aligned",
      [[[[[[TTTableTitleItem item]
        applyTitle:@"TTTableTitleItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES],
      [[[[[[[TTTableSubtitleItem item]
        applySubtitle:@"TTTableSubtitleItems are TTTableTitleItems with a subtitle"]
        applyTitle:@"TTTableSubtitleItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES],
      [[[[[[[[[TTTableMessageItem item]
        applyTimestamp:[NSDate date]]
        applyMessage:@"TTTableMessageItems are TTTableSubtitleItems with a message/time"]
        applySubtitle:@"This message will generally span multiple lines"]
        applyTitle:@"TTTableMessageItem"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES],
      [[[TTTableCaptionItem item]
        applyCaption:@"Caption"]
        applyTitle:@"TTTableCaptionItem"],
      [[TTTableSummaryItem item]
        applyTitle:@"TTTableSummaryItem"],
      [[TTTableLinkItem item]
        applyTitle:@"TTTableLinkItem"],
      [[TTTableButtonItem item]
        applyTitle:@"TTTableButtonItem"],
      [[[TTTableMoreButtonItem item]
        applySubtitle:@"With subtitle text"]
        applyTitle:@"TTTableMoreButtonItem"],
      [[TTTableActivityItem item]
        applyTitle:@"TTTableActivityItem"],
      [[TTTableStyledTextItem item]
        applyStyledText:[TTStyledText textFromXHTML:@"This is a whole bunch of text made from \
characters and followed by this URL http://bit.ly/1234"]],
      [[[TTTableControlItem item]
        applyControl:[[[UISwitch alloc] init] autorelease]]
        applyCaption:@"TTTableControlItem"],
      [[[TTTableControlItem item]
        applyControl:[[[UISlider alloc] init] autorelease]]
        applyCaption:@"TTTableControlItem"],
      [[[[[[TTTableLongTextItem item]
        applyText:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES],

      nil];

    self.dataSource = dataSource;
  }

  return self;
}


@end
