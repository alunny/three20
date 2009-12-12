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

@class TTTableLinkedItem;
@class TTTableSummaryItem;
@class TTImageView;
@class TTTableMoreButtonItem;
@class TTTableActivityItem;
@class TTActivityLabel;


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkedItemCell : TTTableViewCell {
@protected
  TTTableLinkedItem* _item;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableImageLinkedItemCell : TTTableLinkedItemCell {
@protected
  TTImageView* _styledImageView;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableTitleItemCell : TTTableImageLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtitleItemCell : TTTableImageLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMessageItemCell : TTTableImageLinkedItemCell {
  UILabel* _messageLabel;
  UILabel* _timestampLabel;
}

@property(nonatomic,readonly,retain) UILabel* messageLabel;
@property(nonatomic,readonly,retain) UILabel* timestampLabel;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableCaptionItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSummaryItemCell : TTTableViewCell {
@protected
  TTTableSummaryItem* _item;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkItemCell : TTTableImageLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableButtonItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMoreButtonItemCell : TTTableViewCell {
@protected
  TTTableMoreButtonItem*    _item;
  UIActivityIndicatorView*  _activityIndicatorView;
  BOOL                      _animating;
}

@property(nonatomic,readonly,retain) UIActivityIndicatorView* activityIndicatorView;
@property(nonatomic)                 BOOL                     animating;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableActivityItemCell : TTTableViewCell {
@protected
  TTTableActivityItem*  _item;
  TTActivityLabel*      _activityLabel;
}

@property(nonatomic,readonly,retain) TTActivityLabel* activityLabel;

@end


/* TODO: CLEANUP

///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTStyledTextTableItemCell : TTTableLinkedItemCell {
  TTStyledTextLabel* _label;
}

@property(nonatomic,readonly) TTStyledTextLabel* label;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTStyledTextTableCell : TTTableViewCell {
  TTStyledTextLabel* _label;
}

@property(nonatomic,readonly) TTStyledTextLabel* label;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableActivityItemCell : TTTableViewCell {
  TTTableActivityItem* _item;
  TTActivityLabel* _activityLabel;
}

@property(nonatomic,readonly,retain) TTActivityLabel* activityLabel;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableControlCell : TTTableViewCell {
  TTTableControlItem* _item;
  UIControl* _control;
}

@property(nonatomic,readonly,retain) TTTableControlItem* item;
@property(nonatomic,readonly,retain) UIControl* control;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableFlushViewCell : TTTableViewCell {
  TTTableViewItem* _item;
  UIView* _view;
}

@property(nonatomic,readonly,retain) TTTableViewItem* item;
@property(nonatomic,readonly,retain) UIView* view;

@end
*/