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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const CGFloat kDisclosureIndicatorWidth;
extern const CGFloat kDetailDisclosureButtonWidth;
extern const CGFloat kEditingIndentationWidth;
extern const CGFloat kReorderButtonWidth;

@class TTTableStyleSheet;

/**
 * The base class for table cells which are single-object based.
 *
 * TTTableViewDataSource initializes each cell that it creates by assigning it the object
 * that the data source returned for the row. The responsibility for initializing the table cell
 * is then shifted from the table data source to the setObject method on the cell itself, which
 * this developer feels is a more appropriate delegation.  The same goes for the cell height
 * measurement, whose responsibility is transferred from the data source to the cell.
 *
 * Subclasses should implement the object getter and setter.  The base implementations do
 * nothing, allowing you to store the object yourself using the appropriate type.
 */
@interface TTTableViewCell : UITableViewCell {
  TTTableStyleSheet* _styleSheet;
}

@property(nonatomic,retain) id object;
@property(nonatomic,assign) TTTableStyleSheet* styleSheet;

/**
 * Measure the height of the row with the given table view.
 *
 * @param  tableView      Used to determine if we are editing.
 * @return The necessary number of vertical pixels required to draw this cell.
 * @default TT_ROW_HEIGHT
 */
- (CGFloat)rowHeightWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

/**
 * Calculate the width of the row with the given table view and considering accessory types.
 */
- (CGFloat)contentWidthWithTableView: (UITableView*)tableView
                           indexPath: (NSIndexPath*)indexPath
                             padding: (UIEdgeInsets)padding;

/**
 * Calculate the best label heights for this cell's current height.
 *
 * Accepts up to 10 labels and their corresponding calculated heights.
 * Replaces the calculatedLabelHeights values with the calculated label heights.
 */
- (void)optimizeLabels: (NSArray*)labels
               heights: (NSMutableArray*)calculatedLabelHeights
               padding: (UIEdgeInsets)padding;

@end
