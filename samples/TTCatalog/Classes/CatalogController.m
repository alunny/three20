#import "CatalogController.h"
#import "Three20/developer.h"

@implementation CatalogController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
    self.title = @"Three20 Catalog";
    self.navigationItem.backBarButtonItem =
      [[[UIBarButtonItem alloc] initWithTitle:@"Catalog" style:UIBarButtonItemStyleBordered
      target:nil action:nil] autorelease];

    self.tableViewStyle = UITableViewStyleGrouped;
  }
  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModelViewController

- (void)createModel {
  self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
    @"Photos",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Photo Browser", kTableItemTitleKey,
        @"tt://photoTest1", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Photo Thumbnails", kTableItemTitleKey,
        @"tt://photoTest2", kTableItemURLKey,
        nil]],

    @"Styles",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Styled Views", kTableItemTitleKey,
        @"tt://styleTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Styled Labels", kTableItemTitleKey,
        @"tt://styledTextTest", kTableItemURLKey,
        nil]],

    @"Controls",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Buttons", kTableItemTitleKey,
        @"tt://buttonTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Tabs", kTableItemTitleKey,
        @"tt://tabBarTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Composers", kTableItemTitleKey,
        @"tt://composerTest", kTableItemURLKey,
        nil]],

    @"Tables",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Table Items", kTableItemTitleKey,
        @"tt://tableItemTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Table Controls", kTableItemTitleKey,
        @"tt://tableControlsTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Styled Labels in Table", kTableItemTitleKey,
        @"tt://styledTextTableTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Web Images in Table", kTableItemTitleKey,
        @"tt://imageTest2", kTableItemURLKey,
        nil]],
  
    @"Models",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Model Search", kTableItemTitleKey,
        @"tt://searchTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Model States", kTableItemTitleKey,
        @"tt://tableTest", kTableItemURLKey,
        nil]],
    
    @"General",
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Web Image", kTableItemTitleKey,
        @"tt://imageTest1", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"YouTube Player", kTableItemTitleKey,
        @"tt://youTubeTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Web Browser", kTableItemTitleKey,
        @"http://github.com/facebook/three20", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Activity Labels", kTableItemTitleKey,
        @"tt://activityTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Scroll View", kTableItemTitleKey,
        @"tt://scrollViewTest", kTableItemURLKey,
        nil]],
    [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Launcher", kTableItemTitleKey,
        @"tt://launcherTest", kTableItemURLKey,
        nil]],
    nil];
}

@end
