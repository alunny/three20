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

#import "TableItemCatalogController.h"

#import "ScalableTableStyleSheet.h"

static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
 eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TableItemCatalogController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
  if (self = [super init]) {
    self.title = @"Table Item Catalog";

    self.variableHeightRows = YES;

    UISwitch* groupedSwitch = [[UISwitch alloc] init];
    [groupedSwitch addTarget:self
                      action:@selector(didSwitchGroup:)
            forControlEvents:UIControlEventValueChanged];

    groupedSwitch.on = (self.tableViewStyle == UITableViewStyleGrouped) ? YES : NO;

    UISwitch* editingSwitch = [[UISwitch alloc] init];
    [editingSwitch addTarget:self
                      action:@selector(didSwitchEditing:)
            forControlEvents:UIControlEventValueChanged];

    editingSwitch.on = self.editing;

    UISlider* fontMultiplierSlider = [[UISlider alloc] init];
    fontMultiplierSlider.minimumValue = 0.1;
    fontMultiplierSlider.maximumValue = 10;
    fontMultiplierSlider.value = 1.0;
    fontMultiplierSlider.continuous = NO;
    [fontMultiplierSlider addTarget:self
                             action:@selector(didChangeFontMultiplier:)
                   forControlEvents:UIControlEventValueChanged];

    TTSectionedDataSource* dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"The items",
      [[TTTableTitleItem item]
        applyTitle:@"TTTableTitleItem"],
      [[[TTTableSubtitleItem item]
        applySubtitle:@"TTTableSubtitleItems are TTTableTitleItems with a subtitle"]
        applyTitle:@"TTTableSubtitleItem"],
      [[[[[TTTableMessageItem item]
        applyTimestamp:[NSDate date]]
        applyMessage:@"TTTableMessageItems are TTTableSubtitleItems with a message/time"]
        applySubtitle:@"This message will generally span multiple lines"]
        applyTitle:@"TTTableMessageItem"],
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
      [[TTTableLongTextItem item]
        applyText:kLoremIpsum],

      @"Configuration",
      [[[TTTableControlItem item]
        applyControl:groupedSwitch]
        applyCaption:@"Grouped"],
      [[[TTTableControlItem item]
        applyControl:editingSwitch]
        applyCaption:@"Editing"],

      @"Font scale",
      [[[TTTableControlItem item]
        applyControl:fontMultiplierSlider]
        applyCaption:@"Font scale"],

      nil];

    _styleSheet = [[ScalableTableStyleSheet alloc] init];
    dataSource.styleSheet = _styleSheet;
    self.dataSource = dataSource;

    TT_RELEASE_SAFELY(groupedSwitch);
    TT_RELEASE_SAFELY(editingSwitch);
    TT_RELEASE_SAFELY(fontMultiplierSlider);
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_styleSheet);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return TTIsSupportedOrientation(interfaceOrientation);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSwitchGroup:(UISwitch*)theSwitch {
  BOOL wasEditing = self.editing;

  if (theSwitch.on) {
    self.tableViewStyle = UITableViewStyleGrouped;
  } else {
    self.tableViewStyle = UITableViewStylePlain;
  }

  // Force the old table view out of existence.
  [self setTableView:nil];

  self.variableHeightRows = YES;

  // And then create a new one.
  [self showModel:YES];

  self.editing = wasEditing;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSwitchEditing:(UISwitch*)theSwitch {
  [self setEditing:theSwitch.on animated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didChangeFontMultiplier:(UISlider*)slider {
  _styleSheet.scale = slider.value;
  [self.tableView reloadData];
  [self.tableView scrollToLastRow:NO];
}


@end
