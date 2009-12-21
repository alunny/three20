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
      [[[TTTableTitleItem item]
        applyTitle:@"Porride"]
        applyURLPath:@"tt://food/porridge"],
      [[[TTTableTitleItem item]
        applyTitle:@"Bacon & Eggs"]
        applyURLPath:@"tt://food/baconeggs"],
      [[[TTTableTitleItem item]
        applyTitle:@"French Toast"]
        applyURLPath:@"tt://food/frenchtoast"],

      @"Drinks",
      [[[TTTableTitleItem item]
        applyTitle:@"Coffee"]
        applyURLPath:@"tt://food/coffee"],
      [[[TTTableTitleItem item]
        applyTitle:@"Orange Juice"]
        applyURLPath:@"tt://food/oj"],

      @"Other",
      [[[TTTableTitleItem item]
        applyTitle:@"Just Desserts"]
        applyURLPath:@"tt://menu/4"],
      [[[TTTableTitleItem item]
        applyTitle:@"Complaints"]
        applyURLPath:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPageLunch) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Menu",
      [[[TTTableTitleItem item]
        applyTitle:@"Mac & Cheese"]
        applyURLPath:@"tt://food/macncheese"],
      [[[TTTableTitleItem item]
        applyTitle:@"Ham Sandwich"]
        applyURLPath:@"tt://food/hamsam"],
      [[[TTTableTitleItem item]
        applyTitle:@"Salad"]
        applyURLPath:@"tt://food/salad"],

      @"Drinks",
      [[[TTTableTitleItem item]
        applyTitle:@"Coke"]
        applyURLPath:@"tt://food/coke"],
      [[[TTTableTitleItem item]
        applyTitle:@"Sprite"]
        applyURLPath:@"tt://food/sprite"],
      @"Other",
      [[[TTTableTitleItem item]
        applyTitle:@"Just Desserts"]
        applyURLPath:@"tt://menu/4"],
      [[[TTTableTitleItem item]
        applyTitle:@"Complaints"]
        applyURLPath:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPageDinner) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Appetizers",
      [[[TTTableTitleItem item]
        applyTitle:@"Potstickers"]
        applyURLPath:@"tt://food/potstickers"],
      [[[TTTableTitleItem item]
        applyTitle:@"Egg Rolls"]
        applyURLPath:@"tt://food/eggrolls"],
      [[[TTTableTitleItem item]
        applyTitle:@"Buffalo Wings"]
        applyURLPath:@"tt://food/wings"],
      @"Entrees",
      [[[TTTableTitleItem item]
        applyTitle:@"Steak"]
        applyURLPath:@"tt://food/steak"],
      [[[TTTableTitleItem item]
        applyTitle:@"Chicken Marsala"]
        applyURLPath:@"tt://food/marsala"],
      [[[TTTableTitleItem item]
        applyTitle:@"Cobb Salad"]
        applyURLPath:@"tt://food/cobbsalad"],
      [[[TTTableTitleItem item]
        applyTitle:@"Green Salad"]
        applyURLPath:@"tt://food/greensalad"],
      @"Drinks",
      [[[TTTableTitleItem item]
        applyTitle:@"Red Wine"]
        applyURLPath:@"tt://food/redwine"],
      [[[TTTableTitleItem item]
        applyTitle:@"White Wine"]
        applyURLPath:@"tt://food/whitewhine"],
      [[[TTTableTitleItem item]
        applyTitle:@"Beer"]
        applyURLPath:@"tt://food/beer"],
      [[[TTTableTitleItem item]
        applyTitle:@"Coke"]
        applyURLPath:@"tt://food/coke"],
      [[[TTTableTitleItem item]
        applyTitle:@"Sparkling Water"]
        applyURLPath:@"tt://food/coke"],
      @"Other",
      [[[TTTableTitleItem item]
        applyTitle:@"Just Desserts"]
        applyURLPath:@"tt://menu/4"],
      [[[TTTableTitleItem item]
        applyTitle:@"Complaints"]
        applyURLPath:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPageDessert) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Yum",
      [[[TTTableTitleItem item]
        applyTitle:@"Chocolate Cake"]
        applyURLPath:@"tt://food/cake"],
      [[[TTTableTitleItem item]
        applyTitle:@"Apple Pie"]
        applyURLPath:@"tt://food/pie"],
      @"Other",
      [[[TTTableTitleItem item]
        applyTitle:@"Complaints"]
        applyURLPath:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPageAbout) {
    self.dataSource = [TTListDataSource dataSourceWithObjects:
      [[[TTTableTitleItem item]
        applyTitle:@"Our Story"]
        applyURLPath:@"tt://about/story"],
      [[[TTTableTitleItem item]
        applyTitle:@"Call Us"]
        applyURLPath:@"tel:5555555"],
      [[[TTTableTitleItem item]
        applyTitle:@"Text Us"]
        applyURLPath:@"sms:5555555"],
      [[[TTTableTitleItem item]
        applyTitle:@"Website"]
        applyURLPath:@"http://www.melsdrive-in.com"],
      [[[TTTableTitleItem item]
        applyTitle:@"Complaints Dept."]
        applyURLPath:@"tt://about/complaints"],
      nil];
  }
}

@end
 