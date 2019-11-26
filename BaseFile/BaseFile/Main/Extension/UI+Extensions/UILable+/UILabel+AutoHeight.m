//
//  UIView+Extensions.h
//  iCampsite
//
//  Created by liuhao on 16/4/14.
//  Copyright © 2016年 liuhao. All rights reserved.
//

#import "UILabel+AutoHeight.h"
#import <CoreText/CoreText.h>

@implementation UILabel (AutoHeight)

- (float)autoHeight{
    
    if (!self.text) {
        self.text = @"";
    }
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:self.font,
                                 NSForegroundColorAttributeName: self.textColor};
    CGSize  customLabSize =[self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    ;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,customLabSize.height);
    return customLabSize.height;
}

- (float)autoHeightWithLineSpace:(float)space{
    
    if (!self.text) {
        self.text = @"";
    }
    
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.minimumLineHeight = 18;
    paragraphStyle.lineSpacing = space;
    NSDictionary *attributes = @{NSFontAttributeName:self.font,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: self.textColor};
    CGSize  customLabSize =[self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    ;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,customLabSize.height);
    return customLabSize.height;
}

- (void)lineSpacing:(float)space{
    
    if (!self.text) {
        self.text = @"";
    }
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.minimumLineHeight = 18;
    paragraphStyle.lineSpacing = space;
    NSDictionary *attributes = @{NSFontAttributeName:self.font,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName:self.textColor};
    if (self.text.length)
       self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}


- (void)autoHeight:(int)maxLines{
    
    if (!self.text) {
        self.text = @"";
    }
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize  customLabSize =[self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    float offset = 0;
    if(customLabSize.height>maxLines*CGRectGetHeight(self.frame))
        offset = (CGRectGetHeight(self.frame)+3)*3;
    else
        offset = self.frame.size.height+customLabSize.height-CGRectGetHeight(self.frame);
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, offset);
}
//ios7方法，获取文本需要的size，限制宽度
- (void)autoWidth{
    
    if (!self.text) {
        self.text = @"";
    }
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 1;
    CGSize size = CGSizeMake(320,2000);
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize  labelsize =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y, labelsize.width, CGRectGetHeight(self.frame))];
}

-(void)alignTop {
    if (!self.text) {
        self.text = @"";
    }
    CGSize fontSize = [self.text sizeWithAttributes: @{NSFontAttributeName:self.font}];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize  theStringSize =[self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

- (void)changeAlignmentRightandLeft{
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    
    CGFloat margin = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
    
}

@end
