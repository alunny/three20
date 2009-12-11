#import "TableItemTestController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
 eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\
 pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\
 mollit anim id est laborum.

@interface TableViewVarHeightDelegate : TTTableViewVarHeightDelegate {
}

@end

@implementation TableViewVarHeightDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row % 2) {
    return UITableViewCellEditingStyleDelete;
  } else {
    return UITableViewCellEditingStyleNone;
  }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

@end


@interface SectionedSortableDataSource : TTSectionedDataSource {
}

@end

@implementation SectionedSortableDataSource

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

@end



///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TableItemTestController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

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
      
    NSString* localImage = @"bundle://tableIcon.png";
    NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";
    UIImage* defaultPerson = TTIMAGE(@"bundle://defaultPerson.png");
    TTStyle* imageStyle = 
      [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
      [TTSolidBorderStyle styleWithColor:[UIColor lightGrayColor] width:1 next:
      [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
      [TTInsetStyle styleWithInset:UIEdgeInsetsMake(3, 3, 3, 3) next:
      [TTContentStyle styleWithNext:nil]]]]];
    
    // This demonstrates how to create a table with standard table "fields".  Many of these
    // fields with URLs that will be visited when the row is selected
    self.dataSource = [SectionedSortableDataSource dataSourceWithObjects:
      @"TTTableTitleItem",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        defaultPerson, kTableItemImageKey,
        localImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
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
        kLoremIpsum, kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

      @"TTTableSubtitleItem",
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableSubtitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Subtitle", kTableItemSubtitleKey,
        nil]],
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
        defaultPerson, kTableItemImageKey,
        imageStyle, kTableItemImageStyleKey,
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

      @"TTTableMessageItem",
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Title", kTableItemTitleKey,
        [NSDate date], kTableItemTimestampKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemSubtitleKey,
        [NSDate date], kTableItemTimestampKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTextKey,
        [NSDate date], kTableItemTimestampKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Title", kTableItemTitleKey,
        @"Subtitle", kTableItemSubtitleKey,
        [NSDate date], kTableItemTimestampKey,
        defaultPerson, kTableItemImageKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Title", kTableItemTitleKey,
        @"Text", kTableItemTextKey,
        remoteImage, kTableItemImageURLKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Subtitle", kTableItemSubtitleKey,
        @"Text", kTableItemTextKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        kLoremIpsum, kTableItemSubtitleKey,
        kLoremIpsum, kTableItemTextKey,
        [NSDate date], kTableItemTimestampKey,
        @"tt://tableItemTest", kTableItemURLKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        @"Subtitle", kTableItemSubtitleKey,
        kLoremIpsum, kTableItemTextKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No subtitle", kTableItemTitleKey,
        kLoremIpsum, kTableItemTextKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableMessageItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Bob Jones", kTableItemTitleKey,
        @"TTTableMessageItem", kTableItemSubtitleKey,
        [NSDate date], kTableItemTimestampKey,
        kLoremIpsum, kTableItemTextKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

      @"TTTableCaptionItem",
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableCaptionItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Caption", kTableItemCaptionKey,
        nil]],
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

      @"TTTableSummaryItem",
      [TTTableSummaryItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"TTTableSummaryItem", kTableItemTitleKey,
        nil]],
      [TTTableSummaryItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        nil]],

      @"TTTableLinkItem",
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        defaultPerson, kTableItemImageKey,
        localImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"accessoryURL", kTableItemTitleKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Both URLs", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableLinkItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],

      @"TTTableButtonItem",
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        remoteImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"URL", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        defaultPerson, kTableItemImageKey,
        localImage, kTableItemImageURLKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"accessoryURL", kTableItemTitleKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Both URLs", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        @"http://www.google.com", kTableItemAccessoryURLKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        defaultPerson, kTableItemImageKey,
        imageStyle, kTableItemImageStyleKey,
        nil]],
      [TTTableButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        nil]],

      @"TTTableMoreButtonItem",
      [TTTableMoreButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableMoreButtonItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
        kLoremIpsum, kTableItemSubtitleKey,
        nil]],

      @"TTTableActivityItem",
      [TTTableActivityItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"No URLs", kTableItemTitleKey,
        nil]],
      [TTTableActivityItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        kLoremIpsum, kTableItemTitleKey,
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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self.tableView scrollToLastRow:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return TTIsSupportedOrientation(interfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  //[self.tableView reloadData];
}
/*
- (id<UITableViewDelegate>)createDelegate {
  return [[[TableViewVarHeightDelegate alloc] initWithController:self] autorelease];
}*/

@end
