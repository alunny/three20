#import "TableControlsTestController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TableControlsTestController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
    self.tableViewStyle = UITableViewStyleGrouped;
    self.autoresizesForKeyboard = YES;
    self.variableHeightRows = YES;
    
    UITextField* textField = [[[UITextField alloc] init] autorelease];
    textField.placeholder = @"UITextField";
    textField.font = TTSTYLEVAR(font);

    UITextField* textField2 = [[[UITextField alloc] init] autorelease];
    textField2.font = TTSTYLEVAR(font);
    textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UITextView* textView = [[[UITextView alloc] init] autorelease];
    textView.text = @"UITextView";
    textView.font = TTSTYLEVAR(font);
    
    TTTextEditor* editor = [[[TTTextEditor alloc] init] autorelease];
    editor.font = TTSTYLEVAR(font);
    editor.backgroundColor = TTSTYLEVAR(backgroundColor);
    editor.autoresizesToText = NO;
    editor.minNumberOfLines = 3;
    editor.placeholder = @"TTTextEditor";
    
    UISwitch* switchy = [[[UISwitch alloc] init] autorelease];
    UISlider* slider = [[[UISlider alloc] init] autorelease];
    
    self.dataSource = [TTListDataSource dataSourceWithObjects:
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        textField, kTableItemControlKey,
        nil]],
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        editor, kTableItemControlKey,
        nil]],
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        textView, kTableItemControlKey,
        nil]],
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"Text field", kTableItemCaptionKey,
        textField2, kTableItemControlKey,
        nil]],
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"UISwitch", kTableItemCaptionKey,
        switchy, kTableItemControlKey,
        nil]],
      [TTTableControlItem itemWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
        @"UISlider", kTableItemCaptionKey,
        slider, kTableItemControlKey,
        nil]],
      nil];
  }
  return self;
}

@end
