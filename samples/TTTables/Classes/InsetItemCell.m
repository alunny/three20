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

#import "InsetItemCell.h"

#import "InsetItem.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation InsetItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
    _insetView = [[TTView alloc] init];

    _insetView.style = 
      [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
      [TTSolidFillStyle styleWithColor:[UIColor lightGrayColor] next:
      [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.4) blur:3 offset:CGSizeMake(0, 2)
        next:nil]]];

    [self.contentView addSubview:_insetView];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_insetView);

	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];

  _insetView.frame = self.contentView.bounds;
}


@end
