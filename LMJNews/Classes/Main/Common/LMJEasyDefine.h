//
//  LMJEasyDefine.h
//  LMJNews
//
//  Created by lmj on 16/1/2.
//  Copyright © 2016年 lmj. All rights reserved.
//

#ifndef LMJEasyDefine_h
#define LMJEasyDefine_h


#define LMJFont(x) [UIFont systemFontOfSize:x]
#define LMJBoldFont(x) [UIFont boldSystemFontOfSize:x]

#define LMJRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define LMJRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* LMJEasyDefine_h */
