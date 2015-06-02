//
//  NormalButton.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "BaseButton.h"
#import "ConstColors.h"
#import "ConstFonts.h"

// Border
#define kButtonBorderSize 1.0f
#define kButtonBorderColor kColorGrayDark

// Corner
#define kButtonCornerRadius 3.0f

// Normal state style
#define kButtonBackgroundColorNormalState kColorGrayLight //kColorGreen
#define kButtonTextColorNormalState kColorWhite

// Highlighted state style
#define kButtonBackgroundColorHighlightedState kColorGrayLight //kColorGreen
#define kButtonTextColorHighlightedState kColorWhite

// Disabled state style
#define kButtonBackgroundColorDisabledState kColorGrayLight1
#define kButtonTextColorDisabledState kColorWhite

// Font
#define kButtonTextFont kFontNormal
#define kButtonTextFontSize 15

@interface NormalButton : BaseButton

@end
