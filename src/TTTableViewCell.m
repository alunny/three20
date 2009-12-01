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

#import "Three20/TTTableViewCell.h"
#import "Three20/TTGlobal.h"

#import "Three20/TTGlobalUI.h"

const CGFloat kDisclosureIndicatorWidth = 20;
const CGFloat kDetailDisclosureButtonWidth = 33;
const CGFloat kEditingIndentationWidth = 32;
const CGFloat kReorderButtonWidth = 32;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TTTableViewCell

- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  return TT_ROW_HEIGHT;
}

- (CGFloat)contentWidthWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
  CGFloat width = tableView.width - TTSTYLEVAR(tableHPadding) * 2 - [tableView tableCellMargin] * 2;

  if (tableView.editing) {
    UITableViewCellEditingStyle editingStyle;
    if ([tableView.delegate respondsToSelector:
          @selector(tableView:editingStyleForRowAtIndexPath:)]) {
      editingStyle = [tableView.delegate
                            tableView: tableView
        editingStyleForRowAtIndexPath: indexPath];
    } else {
      editingStyle = UITableViewCellEditingStyleDelete;
    }

    BOOL shouldIndent = YES;
    if (editingStyle == UITableViewCellEditingStyleNone &&
        [tableView.delegate respondsToSelector:
          @selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
      shouldIndent = [tableView.delegate
                                     tableView: tableView
        shouldIndentWhileEditingRowAtIndexPath: indexPath];
    }

    if (shouldIndent) {
      width -= kEditingIndentationWidth;
    }

    BOOL canMoveRow = NO;
    if ([tableView.dataSource respondsToSelector:
          @selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
      canMoveRow = YES;
      if ([tableView.dataSource respondsToSelector:
            @selector(tableView:canMoveRowAtIndexPath:)]) {
        canMoveRow = [tableView.dataSource
                      tableView: tableView
          canMoveRowAtIndexPath: indexPath];
      }

      if (canMoveRow) {
        width -= kReorderButtonWidth;
      }
    }

    if (canMoveRow) {
      width++;
    }

  } else {
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
      width -= kDisclosureIndicatorWidth;
    } else if (self.accessoryType == UITableViewCellAccessoryDetailDisclosureButton) {
      width -= kDetailDisclosureButtonWidth;
    }

    if (tableView.style == UITableViewStyleGrouped) {
      width++;
    }
  }

  return width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UITableViewCell

- (void)prepareForReuse {
  self.object = nil;
  [super prepareForReuse];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (id)object {
  return nil;
}

- (void)setObject:(id)object {
}

@end
