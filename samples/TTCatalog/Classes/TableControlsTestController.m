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
      [[TTTableControlItem item] applyControl:textField],
      [[TTTableControlItem item] applyControl:(UIControl*)editor],
      [[TTTableControlItem item] applyControl:(UIControl*)textView],
      [[[TTTableControlItem item] applyControl:textField2] applyCaption:@"Text field"],
      [[[TTTableControlItem item] applyControl:switchy] applyCaption:@"UISwitch"],
      [[[TTTableControlItem item] applyControl:slider] applyCaption:@"UISlider"],
      nil];
  }
  return self;
}

@end
