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

@class TTTableLinkedItem, TTTableActivityItem, TTTableErrorItem, TTTableControlItem,
       TTTableViewItem, TTImageView, TTErrorView, TTActivityLabel, TTStyledTextLabel, TTStyledText;


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableLinkedItemCell : TTTableViewCell {
@protected
  TTTableLinkedItem* _item;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableTitleItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableCaptionItemCell : TTTableLinkedItemCell
@end

/* TODO: CLEANUP
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableRightCaptionItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtitleItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMessageItemCell : TTTableLinkedItemCell {
  UILabel* _messageLabel;
  UILabel* _timestampLabel;
}

@property(nonatomic,readonly,retain) UILabel* messageLabel;
@property(nonatomic,readonly,retain) UILabel* timestampLabel;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableSubtextItemCell : TTTableLinkedItemCell
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableMoreButtonCell : TTTableTitleItemCell {
  UIActivityIndicatorView* _activityIndicatorView;
  BOOL _animating;
}

@property(nonatomic,readonly,retain) UIActivityIndicatorView* activityIndicatorView;
@property(nonatomic) BOOL animating;

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
@interface TTTableImageItemCell : TTTableTitleItemCell {
  TTImageView* _styledImageView;
}

@property(nonatomic,readonly,retain) TTImageView* styledImageView;

@end


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