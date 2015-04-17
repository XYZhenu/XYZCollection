//
//  XYZUpdateLog.h
//  XYZCollection
//
//  Created by xieyan on 15/3/31.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#ifndef XYZCollection_XYZUpdateLog_h
#define XYZCollection_XYZUpdateLog_h

/**
 *  
 extract
 
 localhost:teststatic xieyan$ lipo -extract armv7 -output libstaticarmv7.a libstaticlib.a
 localhost:teststatic xieyan$ lipo -extract armv7s -output libstaticarmv7s.a libstaticlib.a
 localhost:teststatic xieyan$ lipo -extract arm64 -output libstaticarm64.a libstaticlib.a
 
 
 thin
 
 localhost:teststatic xieyan$ lipo libstaticarm64.a -thin arm64 -output libstati_arm64.a
 localhost:teststatic xieyan$ lipo libstaticarmv7.a -thin armv7 -output libstati_armv7.a
 localhost:teststatic xieyan$ lipo libstaticarmv7s.a -thin armv7s -output libstati_armv7s.a
 
 -o
 localhost:teststatic xieyan$ ar -x libstati_arm64.a
 localhost:teststatic xieyan$ ar -x libstati_armv7.a
 localhost:teststatic xieyan$ ar -x libstati_armv7s.a
 
 
 fat
 
 localhost:teststatic xieyan$ libtool -static -o ../libfinalarmv7.a *.o
 
 final
 
 localhost:thined_fat副本 xieyan$ lipo -create -output libWeChatSDK.a *.a
 */
#endif
