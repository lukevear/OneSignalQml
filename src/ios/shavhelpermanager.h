#ifndef SHAVHELPERMANAGER_H
#define SHAVHELPERMANAGER_H

#include <QtCore>

#ifdef __cplusplus
extern "C" {
#endif
 
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
 
@interface ShavHelperManager : NSObject
+ (NSDictionary*)variantToNSDictionary:(QVariantMap)map;
+ (NSArray*)variantListToNSArray:(QVariantList)list;
+ (id)variantToNSObject:(QVariant)item;
+ (QVariant)NSObjectToVariant:(id)item;
+ (QVariantMap)NSDictionaryToVariantMap:(NSDictionary*)obj;
+ (QVariantList)NSArrayToVariantList:(NSArray*)array;
+ (QString)applicationBundle;
+ (QVariantMap)NSErrorToVariantMap:(NSError*)error;
+ (QSize)CGSizeToQSize:(CGSize)size;
+ (CGSize)QSizeToCGSize:(QSize)size;
+ (QPoint)CGPointToQPoint:(CGPoint)point;
+ (CGPoint)QPointToCGPoint:(QPoint)point;
+ (QRect)CGRectToQRect:(CGRect)frame;
+ (CGRect)QRectToCGRect:(QRect)frame;
@end
#ifdef __cplusplus
}
#endif
 
#endif // SHAVHELPERMANAGER_H