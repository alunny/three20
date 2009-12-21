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
  return [[super subtitleFont] fontWithSize:14 * _scale];
}

- (UIFont*)messageFont {
  return [[super messageFont] fontWithSize:14 * _scale];
}

- (UIFont*)captionFont {
  return [[super captionFont] fontWithSize:13 * _scale];
}

- (UIFont*)captionTitleFont {
  return [[super captionTitleFont] fontWithSize:15 * _scale];
}

- (UIFont*)timestampFont {
  return [[super timestampFont] fontWithSize:13 * _scale];
}

- (UIFont*)summaryFont {
  return [[super summaryFont] fontWithSize:17 * _scale];
}

- (UIFont*)linkFont {
  return [[super linkFont] fontWithSize:17 * _scale];
}

- (UIFont*)buttonFont {
  return [[super buttonFont] fontWithSize:13 * _scale];
}

- (UIFont*)moreButtonFont {
  return [[super moreButtonFont] fontWithSize:15 * _scale];
}

- (UIFont*)moreButtonSubtitleFont {
  return [[super moreButtonSubtitleFont] fontWithSize:14 * _scale];
}

- (UIFont*)controlCaptionFont {
  return [[super controlCaptionFont] fontWithSize:17 * _scale];
}

- (UIFont*)longTextFont {
  return [[super longTextFont] fontWithSize:14 * _scale];
}

- (UIFont*)styledTextFont {
  return [[super styledTextFont] fontWithSize:14 * _scale];
}

@end
