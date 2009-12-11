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

#import "UILabelAdditions.h"

#import "UIFontAdditions.h"


@implementation UILabel (TTCategory)

- (CGFloat)heightWithWidth:(CGFloat)width {
  CGFloat maxHeight = self.numberOfLines * self.font.ttLineHeight;
  if (0 == maxHeight) {
    maxHeight = CGFLOAT_MAX;
  }
  CGSize size = [self.text sizeWithFont: self.font
                      constrainedToSize: CGSizeMake(width, maxHeight)
                          lineBreakMode: self.lineBreakMode];

  return size.height;
}

@end
