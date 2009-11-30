#import "TableItemTestController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
 eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\
 pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\
 mollit anim id est laborum.

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TableItemTestController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
    self.title = @"Table Items";
    self.variableHeightRows = YES;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Uncomment this to see how the table looks with the grouped style
    self.tableViewStyle = UITableViewStyleGrouped;
    
    //self.tableViewSeparatorStyle = UITableViewCellSeparatorStyleNone;

    // Uncomment this to see how the table cells look against a custom background color 
    //self.tableView.backgroundColor = [UIColor yellowColor];
      
    NSString* localImage = @"bundle://tableIcon.png";
    NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";
    UIImage* defaultPerson = TTIMAGE(@"bundle://defaultPerson.png");
    
    // This demonstrates how to create a table with standard table "fields".  Many of these
    // fields with URLs that will be visited when the row is selected
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"TTTableTitleItem",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"accessoryURL", kTableItemTitleKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Both URLs", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with no urls set at all so this should truncate or wrap", kTableItemTitleKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with some urls set a", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

      @"TTTableCaptionItem",
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        @"Caption", kTableItemCaptionKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"A very long caption that realistically won't fit", kTableItemCaptionKey,
        @"tt://tableItemTest", kTableItemURLKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"accessoryURL", kTableItemTitleKey,
        @"A normal caption", kTableItemCaptionKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Both URLs", kTableItemTitleKey,
        @"Caption", kTableItemCaptionKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with no urls set at all so this should truncate or wrap", kTableItemTitleKey,
        @"A very long caption that realistically won't fit", kTableItemCaptionKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with some ii", kTableItemTitleKey,
        @"A normal caption", kTableItemCaptionKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

      @"TTTableSubtitleItem",
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        @"Subtitle", kTableItemSubtitleKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"This is a really long subtitle that should span a few lines or truncate", kTableItemSubtitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"accessoryURL", kTableItemTitleKey,
        @"Subtitle", kTableItemSubtitleKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Both URLs", kTableItemTitleKey,
        @"Subtitle", kTableItemSubtitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with no urls set at all so this should truncate or wrap", kTableItemTitleKey,
        @"This is a really long subtitle that should span a few lines or truncate", kTableItemSubtitleKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Long text with some urls set so this should truncate or wrap", kTableItemTitleKey,
        @"This is a really long subtitle that should span more than two lines which is the default max number of lines for the subtitle item", kTableItemSubtitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

/* TODO: CLEANUP      [TTTableLink itemWithText:@"TTTableLink" URL:@"tt://tableItemTest"],
      [TTTableButton itemWithText:@"TTTableButton"],
      [TTTableCaptionItem itemWithText:@"TTTableCaptionItem" caption:@"caption"
                             URL:@"tt://tableItemTest"],
      [TTTableSubtitleItem itemWithText:@"TTTableSubtitleItem" subtitle:kLoremIpsum
                            URL:@"tt://tableItemTest"],
      [TTTableMessageItem itemWithTitle:@"Bob Jones" caption:@"TTTableMessageItem"
                          text:kLoremIpsum timestamp:[NSDate date] URL:@"tt://tableItemTest"],
      [TTTableMoreButton itemWithText:@"TTTableMoreButton"],

      @"Images",
      [TTTableImageItem itemWithText:@"TTTableImageItem" imageURL:localImage
                        URL:@"tt://tableItemTest"],
      [TTTableRightImageItem itemWithText:@"TTTableRightImageItem" imageURL:localImage
                        defaultImage:nil imageStyle:TTSTYLE(rounded)
                        URL:@"tt://tableItemTest"],
      [TTTableSubtitleItem itemWithText:@"TTTableSubtitleItem" subtitle:kLoremIpsum
                            imageURL:remoteImage defaultImage:defaultPerson
                            URL:@"tt://tableItemTest" accessoryURL:nil],
      [TTTableMessageItem itemWithTitle:@"Bob Jones" caption:@"TTTableMessageItem"
                          text:kLoremIpsum timestamp:[NSDate date]
                          imageURL:remoteImage URL:@"tt://tableItemTest"],

      @"Static Text",
      [TTTableTextItem itemWithText:@"TTTableItem"],
      [TTTableCaptionItem itemWithText:@"TTTableCaptionItem which wraps to several lines"
                            caption:@"Text"],
      [TTTableSubtextItem itemWithText:@"TTTableSubtextItem"
                                 caption:kLoremIpsum],
      [TTTableLongTextItem itemWithText:[@"TTTableLongTextItem "
                                         stringByAppendingString:kLoremIpsum]],
      [TTTableGrayTextItem itemWithText:[@"TTTableGrayTextItem "
                                         stringByAppendingString:kLoremIpsum]],
      [TTTableSummaryItem itemWithText:@"TTTableSummaryItem"],

      @"",
      [TTTableActivityItem itemWithText:@"TTTableActivityItem"],
*/
      nil];
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return TTIsSupportedOrientation(interfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.tableView reloadData];
}

@end
