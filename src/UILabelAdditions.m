
#import "UILabelAdditions.h"

#import "UIFontAdditions.h"


@implementation UILabel (TTCategory)

- (CGFloat)heightWithWidth:(CGFloat)width {
  CGFloat maxHeight = self.numberOfLines * self.font.lineHeight;
  if (0 == maxHeight) {
    maxHeight = CGFLOAT_MAX;
  }
  CGSize size = [self.text sizeWithFont: self.font
                      constrainedToSize: CGSizeMake(width, maxHeight)
                          lineBreakMode: self.lineBreakMode];

  return size.height;
}

@end
