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
    [[[TTTableTitleItem item] applyTitle:@"Photo Browser"]    applyURLPath:@"tt://photoTest1"],
    [[[TTTableTitleItem item] applyTitle:@"Photo Thumbnails"] applyURLPath:@"tt://photoTest2"],

    @"Styles",
    [[[TTTableTitleItem item] applyTitle:@"Styled Views"]     applyURLPath:@"tt://styleTest"],
    [[[TTTableTitleItem item] applyTitle:@"Styled Labels"]    applyURLPath:@"tt://styledTextTest"],

    @"Controls",
    [[[TTTableTitleItem item] applyTitle:@"Buttons"]          applyURLPath:@"tt://buttonTest"],
    [[[TTTableTitleItem item] applyTitle:@"Tabs"]             applyURLPath:@"tt://tabBarTest"],
    [[[TTTableTitleItem item] applyTitle:@"Composers"]        applyURLPath:@"tt://composerTest"],

    @"Tables",
    [[[TTTableTitleItem item] applyTitle:@"Table Items"]      applyURLPath:@"tt://tableItemTest"],
    [[[TTTableTitleItem item] applyTitle:@"Table Controls"]   applyURLPath:@"tt://tableControlsTest"],
    [[[TTTableTitleItem item] applyTitle:@"Styled Labels in Table"] applyURLPath:@"tt://styledTextTableTest"],
    [[[TTTableTitleItem item] applyTitle:@"Web Images in Table"] applyURLPath:@"tt://imageTest2"],
  
    @"Models",
    [[[TTTableTitleItem item] applyTitle:@"Table Items"]      applyURLPath:@"tt://tableItemTest"],
    [[[TTTableTitleItem item] applyTitle:@"Model Search"]     applyURLPath:@"tt://searchTest"],
    [[[TTTableTitleItem item] applyTitle:@"Model States"]     applyURLPath:@"tt://tableTest"],
    
    @"General",
    [[[TTTableTitleItem item] applyTitle:@"Web Image"]        applyURLPath:@"tt://imageTest1"],
    [[[TTTableTitleItem item] applyTitle:@"YouTube Player"]   applyURLPath:@"tt://youTubeTest"],
    [[[TTTableTitleItem item] applyTitle:@"Web Browser"]      applyURLPath:@"http://github.com/facebook/three20"],
    [[[TTTableTitleItem item] applyTitle:@"Activity Labels"]  applyURLPath:@"tt://activityTest"],
    [[[TTTableTitleItem item] applyTitle:@"Scroll View"]      applyURLPath:@"tt://scrollViewTest"],
    [[[TTTableTitleItem item] applyTitle:@"Launcher"]         applyURLPath:@"tt://launcherTest"],

    nil];
}

@end
