#import "MenuController.h"

@implementation MenuController

@synthesize page = _page;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)nameForMenuPage:(MenuPage)page {
  switch (page) {
    case MenuPageBreakfast:
      return @"Breakfast";
    case MenuPageLunch:
      return @"Lunch";
    case MenuPageDinner:
      return @"Dinner";
    case MenuPageDessert:
      return @"Dessert";
    case MenuPageAbout:
      return @"About";
    default:
      return @"";
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithMenu:(MenuPage)page {
  if (self = [super init]) {
    self.page = page;
  }
  return self;
}

- (id)init {
  if (self = [super init]) {
    _page = MenuPageNone;
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

- (void)setPage:(MenuPage)page {
  _page = page;
  
  self.title = [self nameForMenuPage:page];

  UIImage* image = [UIImage imageNamed:@"tab.png"];
  self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
  
  self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStyleBordered
                              target:@"tt://order?waitress=Betty&ref=toolbar"
                              action:@selector(openURLFromButton:)] autorelease];

  if (_page == MenuPageBreakfast) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Food",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Porridge", kTableItemTitleKey,
        @"tt://food/porridge", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Bacon & Eggs", kTableItemTitleKey,
        @"tt://food/baconeggs", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"French Toast", kTableItemTitleKey,
        @"tt://food/frenchtoast", kTableItemURLKey,
        nil]],
      @"Drinks",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Coffee", kTableItemTitleKey,
        @"tt://food/coffee", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Orange Juice", kTableItemTitleKey,
        @"tt://food/oj", kTableItemURLKey,
        nil]],
      @"Other",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Just Desserts", kTableItemTitleKey,
        @"tt://menu/4", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Complaints", kTableItemTitleKey,
        @"tt://about/complaints", kTableItemURLKey,
        nil]],
      nil];
  } else if (_page == MenuPageLunch) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Menu",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Mac & Cheese", kTableItemTitleKey,
        @"tt://food/macncheese", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Ham Sandwich", kTableItemTitleKey,
        @"tt://food/hamsam", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Salad", kTableItemTitleKey,
        @"tt://food/salad", kTableItemURLKey,
        nil]],
      @"Drinks",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Coke", kTableItemTitleKey,
        @"tt://food/coke", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Sprite", kTableItemTitleKey,
        @"tt://food/sprite", kTableItemURLKey,
        nil]],
      @"Other",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Just Desserts", kTableItemTitleKey,
        @"tt://menu/4", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Complaints", kTableItemTitleKey,
        @"tt://about/complaints", kTableItemURLKey,
        nil]],
      nil];
  } else if (_page == MenuPageDinner) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Appetizers",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Potstickers", kTableItemTitleKey,
        @"tt://food/potstickers", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Egg Rolls", kTableItemTitleKey,
        @"tt://food/eggrolls", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Buffalo Wings", kTableItemTitleKey,
        @"tt://food/wings", kTableItemURLKey,
        nil]],
      @"Entrees",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Steak", kTableItemTitleKey,
        @"tt://food/steak", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Chicken Marsala", kTableItemTitleKey,
        @"tt://food/marsala", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Cobb Salad", kTableItemTitleKey,
        @"tt://food/cobbsalad", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Green Salad", kTableItemTitleKey,
        @"tt://food/greensalad", kTableItemURLKey,
        nil]],
      @"Drinks",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Red Wine", kTableItemTitleKey,
        @"tt://food/redwine", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"White Wine", kTableItemTitleKey,
        @"tt://food/whitewhine", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Beer", kTableItemTitleKey,
        @"tt://food/beer", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Coke", kTableItemTitleKey,
        @"tt://food/coke", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Sparkling Water", kTableItemTitleKey,
        @"tt://food/coke", kTableItemURLKey,
        nil]],
      @"Other",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Just Desserts", kTableItemTitleKey,
        @"tt://menu/4", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Complaints", kTableItemTitleKey,
        @"tt://about/complaints", kTableItemURLKey,
        nil]],
      nil];
  } else if (_page == MenuPageDessert) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Yum",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Chocolate Cake", kTableItemTitleKey,
        @"tt://food/cake", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Apple Pie", kTableItemTitleKey,
        @"tt://food/pie", kTableItemURLKey,
        nil]],
      @"Other",
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Complaints", kTableItemTitleKey,
        @"tt://about/complaints", kTableItemURLKey,
        nil]],
      nil];
  } else if (_page == MenuPageAbout) {
    self.dataSource = [TTListDataSource dataSourceWithObjects:
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Our Story", kTableItemTitleKey,
        @"tt://about/story", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Call Us", kTableItemTitleKey,
        @"tel:5555555", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Text Us", kTableItemTitleKey,
        @"sms:5555555", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Website", kTableItemTitleKey,
        @"http://www.melsdrive-in.com", kTableItemURLKey,
        nil]],
      [TTTableTitleItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Complaints Dept.", kTableItemTitleKey,
        @"tt://about/complaints", kTableItemURLKey,
        nil]],
      nil];
  }
}

@end
 