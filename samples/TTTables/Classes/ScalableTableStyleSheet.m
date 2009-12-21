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

#import "ScalableTableStyleSheet.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ScalableTableStyleSheet

@synthesize scale = _scale;

- (id)init {
  if (self = [super init]) {
    _scale = 1;
  }

  return self;
}

- (UIFont*)titleFont {
  return [[super titleFont] fontWithSize:17 * _scale];
}

- (UIFont*)subtitleFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)messageFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)captionFont {
  return [UIFont boldSystemFontOfSize:13];
}

- (UIFont*)captionTitleFont {
  return [UIFont boldSystemFontOfSize:15];
}

- (UIFont*)timestampFont {
  return [UIFont systemFontOfSize:13];
}

- (UIFont*)summaryFont {
  return [UIFont systemFontOfSize:17];
}

- (UIFont*)linkFont {
  return [UIFont boldSystemFontOfSize:17];
}

- (UIFont*)buttonFont {
  return [UIFont boldSystemFontOfSize:13];
}

- (UIFont*)moreButtonFont {
  return [UIFont boldSystemFontOfSize:15];
}

- (UIFont*)moreButtonSubtitleFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)controlCaptionFont {
  return [UIFont boldSystemFontOfSize:17];
}

- (UIFont*)longTextFont {
  return [UIFont systemFontOfSize:14];
}

- (UIFont*)styledTextFont {
  return [UIFont systemFontOfSize:14];
}

@end
