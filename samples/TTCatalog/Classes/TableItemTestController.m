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

#import "TableItemTestController.h"

#import "LongLinesTableStyleSheet.h"
#import "SectionedSortableDataSource.h"

static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
 eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\
 pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\
 mollit anim id est laborum.

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TableItemTestController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if (self = [super init]) {
    self.title = @"Table Items";
    self.variableHeightRows = YES;

    // Uncomment this to test fixed-height rows.
    //self.tableView.rowHeight = 44;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Uncomment this to see how the table looks with the grouped style
    self.tableViewStyle = UITableViewStyleGrouped;

    //self.tableViewSeparatorStyle = UITableViewCellSeparatorStyleNone;

    // Uncomment this to see how the table cells look against a custom background color 
    //self.tableView.backgroundColor = [UIColor yellowColor];

    //NSString* localImage = @"bundle://tableIcon.png";
    NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";
    UIImage* defaultPerson = TTIMAGE(@"bundle://defaultPerson.png");
    TTStyle* imageStyle = 
      [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
      [TTSolidBorderStyle styleWithColor:[UIColor lightGrayColor] width:1 next:
      [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(3, 3, 3, 3) next:
      [TTContentStyle styleWithNext:nil]]]]];
    
    // This demonstrates how to create a table with standard table "fields".  Many of these
    // fields with URLs that will be visited when the row is selected.

    // This block of code shows the new Table Cell Item creation pattern of chaining apply*
    // methods on a table item object. This allows us to specify any number of properties, safely
    // leave defaults as is, and avoid the complexities of managing ever growing method names.
    //
    // The basic form is this:
    // [TableItem item]  <-- create an autoreleased table item
    // [[TableItem item] applyTitle:@"title"]  <-- Apply a title to the object.
    //
    // And so on. You can chain any of the available inherited methods.

    // You can now also apply stylesheets to individual tables. This makes it possible to customize
    // tables individually. This also benefits from a better-defined TTTableStyleSheet object.
    // Go ahead, check it out.
    TTTableStyleSheet* styleSheet = [[LongLinesTableStyleSheet alloc] init];

    TTSectionedDataSource* dataSource = [SectionedSortableDataSource dataSourceWithObjects:
      @"TTTableTitleItem",
      [[TTTableTitleItem item]
        applyTitle:@"No URLs"],
      [[[TTTableTitleItem item]
        applyTitle:@"URL"]
        applyURLPath:@"tt://tableItemTest"],
      [[[TTTableTitleItem item]
        applyTitle:@"accessoryURL"]
        applyAccessoryURLPath:@"http://www.google.com"],
      [[[[TTTableTitleItem item]
        applyTitle:@"Both URLs"]
        applyURLPath:@"tt://tableItemTest"]
        applyAccessoryURLPath:@"http://www.google.com"],
      [[[[[TTTableTitleItem item]
        applyTitle:@"No URLs"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle],
      [[[[[[TTTableTitleItem item]
        applyTitle:@"URL"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyURLPath:@"tt://tableItemTest"],
      [[[[[[TTTableTitleItem item]
        applyTitle:@"accessoryURL"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyAccessoryURLPath:@"http://www.google.com"],
      [[[[[[[TTTableTitleItem item]
        applyTitle:@"Both URLs"]
        applyImage:defaultPerson]
        applyImageURLPath:remoteImage]
        applyImageStyle:imageStyle]
        applyURLPath:@"tt://tableItemTest"]
        applyAccessoryURLPath:@"http://www.google.com"],
      [[[[[[TTTableTitleItem item]
        applyTitle:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle]
        applyURLPath:@"tt://tableItemTest"]
        applyAccessoryURLPath:@"http://www.google.com"],
      [[[[[[[TTTableTitleItem item]
        applyTitle:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES]
        applyURLPath:@"tt://tableItemTest"]
        applyAccessoryURLPath:@"http://www.google.com"],

      @"TTTableSubtitleItem",
      [[TTTableSubtitleItem item]
        applyTitle:@"No URLs"],
      [[[TTTableSubtitleItem item]
        applySubtitle:@"Subtitle"]
        applyTitle:@"No URLs"],
      [[TTTableSubtitleItem item]
        applySubtitle:@"Subtitle"],
      [[[[TTTableSubtitleItem item]
        applyTitle:@"No URLs"]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle],
      [[[[[TTTableSubtitleItem item]
        applySubtitle:@"Subtitle"]
        applyTitle:@"No URLs"]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle],
      [[[[TTTableSubtitleItem item]
        applySubtitle:@"Subtitle"]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle],
      [[[[[TTTableSubtitleItem item]
        applySubtitle:kLoremIpsum]
        applyTitle:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle],
      [[[[[[[[TTTableSubtitleItem item]
        applySubtitle:kLoremIpsum]
        applyTitle:kLoremIpsum]
        applyImage:defaultPerson]
        applyImageStyle:imageStyle]
        applyImageRightAligned:YES]
        applyURLPath:@"tt://tableItemTest"]
        applyAccessoryURLPath:@"http://www.google.com"],

      @"TTTableMessageItem",
      [[[[[TTTableMessageItem item]
        applyTimestamp:[NSDate date]]
        applyMessage:@"Message"]
        applySubtitle:@"Subtitle"]
        applyTitle:@"Title"],

      @"TTTableCaptionItem",
      [[[TTTableCaptionItem item]
        applyCaption:@"Caption"]
        applyTitle:@"Title"],

      @"TTTableSummaryItem",
      [[TTTableSummaryItem item]
        applyTitle:kLoremIpsum],

      @"TTTableLinkItem",
      [[TTTableLinkItem item]
        applyTitle:@"Title"],

      @"TTTableButtonItem",
      [[TTTableButtonItem item]
        applyTitle:@"Title"],

      @"TTTableMoreButtonItem",
      [[TTTableMoreButtonItem item]
        applyTitle:@"Title"],

      @"TTTableActivityItem",
      [[TTTableActivityItem item]
        applyTitle:@"Title"],

      @"TTTableStyledTextItem",
      [[TTTableStyledTextItem item]
        applyStyledText:[TTStyledText textFromXHTML:@"This is a whole bunch of text made from \
characters and followed by this URL http://bit.ly/1234"]],

      @"TTTableControlItem",
      [[[TTTableControlItem item]
        applyControl:[[[UISwitch alloc] init] autorelease]]
        applyCaption:@"Title"],

      nil];

    dataSource.styleSheet = styleSheet;
    TT_RELEASE_SAFELY(styleSheet);
    self.dataSource = dataSource;
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  // For testing items at the end of the table view quickly.
  //[self.tableView scrollToLastRow:animated];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return TTIsSupportedOrientation(interfaceOrientation);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  // This forces the table view to recalculate its cell heights on rotation.
  //[self.tableView reloadData];
}

// Enable this block to play with the table delegate.
#if 0

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
  return [[[TableViewVarHeightDelegate alloc] initWithController:self] autorelease];
}

#endif


@end
