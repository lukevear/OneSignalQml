#include "shavhelpermanager.h"
 
@implementation ShavHelperManager
 
+ (NSDictionary*)variantToNSDictionary:(QVariantMap)map {
    NSMutableDictionary* userInfoDic = nil;
    if(!map.isEmpty()) {
        userInfoDic = [NSMutableDictionary dictionary];
        foreach(QString key, map.keys()){
            QVariant item = map[key];
            if(!item.isNull()) {
                if(item.type() == QVariant::String) {
                    NSString* value = item.toString().toNSString();
                    if(value) {
                        [userInfoDic setObject: value forKey: key.toNSString()];
                    }
                } else if(item.type() == QVariant::Bool || item.type() == QVariant::Int || item.type() == QVariant::Double ||
                        item.type() == QVariant::LongLong || item.type() == QVariant::UInt || item.type() == QVariant::ULongLong) {
                    if(item.type() == QVariant::Int) {
                        NSNumber* value = [NSNumber numberWithInt:item.toInt()];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    } else if(item.type() == QVariant::UInt) {
                        NSNumber* value = [NSNumber numberWithUnsignedInt:item.toUInt()];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    } else if(item.type() == QVariant::LongLong) {
                        NSNumber* value = [NSNumber numberWithLongLong:item.toLongLong()];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    } else if(item.type() == QVariant::ULongLong) {
                        NSNumber* value = [NSNumber numberWithUnsignedLongLong:item.toULongLong()];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    } else if(item.type() == QVariant::Double) {
                        NSNumber* value = [NSNumber numberWithDouble:item.toDouble()];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    } else if(item.type() == QVariant::Bool) {
                        BOOL flag = ((item.toBool() == true) ? YES : NO);
                        NSNumber* value = [NSNumber numberWithBool:flag];
                        if(value) {
                            [userInfoDic setObject: value forKey: key.toNSString()];
                        }
                    }
                } else if(item.type() == QVariant::Url) {
                    QUrl url = item.toUrl();
                    NSURL* urlPath = [NSURL URLWithString: (url.toString().toNSString())];
                    [userInfoDic setObject: urlPath forKey: key.toNSString()];
                } else if(item.canConvert<QVariantMap>()) {
                    NSDictionary* value = [ShavHelperManager variantToNSDictionary: (QVariantMap)item.toMap()];
                    if(value) {
                        [userInfoDic setObject: value forKey: key.toNSString()];
                    }
                } else if(item.canConvert<QVariantList>()) {
                    NSArray* value = [ShavHelperManager variantListToNSArray: (QVariantList)item.toList()];
                    if(value) {
                        [userInfoDic setObject: value forKey: key.toNSString()];
                    }
                }
            }
        }
    }
    return userInfoDic;
}
 
+ (NSArray*)variantListToNSArray:(QVariantList)list {
    NSMutableArray* res = nil;
    if(!list.isEmpty()) {
        res = [NSMutableArray array];
        foreach(QVariant item, list) {
            if(item.type() == QVariant::String) {
                NSString* value = item.toString().toNSString();
                if(value) {
                    [res addObject: value];
                }
            } else if(item.type() == QVariant::Bool || item.type() == QVariant::Int || item.type() == QVariant::Double ||
                    item.type() == QVariant::LongLong || item.type() == QVariant::UInt || item.type() == QVariant::ULongLong) {
                if(item.type() == QVariant::Int) {
                    NSNumber* value = [NSNumber numberWithInt:item.toInt()];
                    if(value) {
                        [res addObject: value];
                    }
                } else if(item.type() == QVariant::UInt) {
                    NSNumber* value = [NSNumber numberWithUnsignedInt:item.toUInt()];
                    if(value) {
                        [res addObject: value];
                    }
                } else if(item.type() == QVariant::LongLong) {
                    NSNumber* value = [NSNumber numberWithLongLong:item.toLongLong()];
                    if(value) {
                        [res addObject: value];
                    }
                } else if(item.type() == QVariant::ULongLong) {
                    NSNumber* value = [NSNumber numberWithUnsignedLongLong:item.toULongLong()];
                    if(value) {
                        [res addObject: value];
                    }
                } else if(item.type() == QVariant::Double) {
                    NSNumber* value = [NSNumber numberWithDouble:item.toDouble()];
                    if(value) {
                        [res addObject: value];
                    }
                } else if(item.type() == QVariant::Bool) {
                    BOOL flag = ((item.toBool() == true) ? YES : NO);
                    NSNumber* value = [NSNumber numberWithBool:flag];
                    if(value) {
                        [res addObject: value];
                    }
                }
            } else if(item.type() == QVariant::Url) {
                QUrl url = item.toUrl();
                NSURL* urlPath = [NSURL URLWithString: (url.toString().toNSString())];
                [res addObject: urlPath];
            } else if(item.canConvert<QVariantMap>()) {
                [res addObject: [ShavHelperManager variantToNSDictionary: (QVariantMap)item.toMap()]];
            } else if(item.canConvert<QVariantList>()) {
                [res addObject: [ShavHelperManager variantListToNSArray: (QVariantList)item.toList()]];
            }
        }
    }
    return res;
}
 
+ (id)variantToNSObject:(QVariant)item {
    id res = nil;
    if(!item.isNull()) {
        if(item.type() == QVariant::String) {
            res = item.toString().toNSString();
        } else if(item.type() == QVariant::Bool || item.type() == QVariant::Int || item.type() == QVariant::Double ||
                item.type() == QVariant::LongLong || item.type() == QVariant::UInt || item.type() == QVariant::ULongLong) {
            if(item.type() == QVariant::Int) {
                res = [NSNumber numberWithInt:item.toInt()];
            } else if(item.type() == QVariant::UInt) {
                res = [NSNumber numberWithUnsignedInt:item.toUInt()];
            } else if(item.type() == QVariant::LongLong) {
                res = [NSNumber numberWithLongLong:item.toLongLong()];
            } else if(item.type() == QVariant::ULongLong) {
                res = [NSNumber numberWithUnsignedLongLong:item.toULongLong()];
            } else if(item.type() == QVariant::Double) {
                res = [NSNumber numberWithDouble:item.toDouble()];
            } else if(item.type() == QVariant::Bool) {
                BOOL flag = ((item.toBool() == true) ? YES : NO);
                res = [NSNumber numberWithBool:flag];
            }
        } else if(item.type() == QVariant::Url) {
            QUrl url = item.toUrl();
            res = [NSURL URLWithString: (url.toString().toNSString())];
        } else if(item.canConvert<QVariantMap>()) {
            res = [ShavHelperManager variantToNSDictionary: (QVariantMap)item.toMap()];
        } else if(item.canConvert<QVariantList>()) {
            res = [ShavHelperManager variantListToNSArray: (QVariantList)item.toList()];
        }
    }
    return res;
}
 
+ (QVariant)NSObjectToVariant:(id)item {
    QVariant res;
    res.clear();
    if(item) {
        if([item isKindOfClass: [NSDictionary class]]) {
            res = QVariant([ShavHelperManager NSDictionaryToVariantMap: (NSDictionary*)item]);
        } else if([item isKindOfClass: [NSArray class]]) {
            res = QVariant([ShavHelperManager NSArrayToVariantList: (NSArray*)item]);
        } else if([item isKindOfClass: [NSNumber class]]) {
            if((NSNumber*)item == (void*)kCFBooleanFalse || (NSNumber*)item == (void*)kCFBooleanTrue) {
                BOOL value = [(NSNumber*)item boolValue];
                res = QVariant(((value == YES) ? true : false));
            } else if(strcmp([item objCType], @encode(int)) == 0) {
                int value = [(NSNumber*)item intValue];
                res = QVariant(value);
            } else if(strcmp([item objCType], @encode(double)) == 0) {
                double value = [(NSNumber*)item doubleValue];
                res = QVariant(value);
            } else if(strcmp([item objCType], @encode(float)) == 0) {
                float value = [(NSNumber*)item floatValue];
                res = QVariant(value);
            } else if(strcmp([item objCType], @encode(uint)) == 0) {
                uint value = [(NSNumber*)item unsignedIntValue];
                res = QVariant(value);
            } else if(strcmp([item objCType], @encode(long long)) == 0) {
                long long value = [(NSNumber*)item longLongValue];
                res = QVariant(value);
            }
        } else if([item isKindOfClass: [NSString class]]) {
            res = QVariant(QString::fromNSString((NSString*)item));
        } else if([item isKindOfClass:[NSURL class]]) {
            NSURL* url = (NSURL*)item;
            res = QVariant(QUrl(QString::fromNSString(url.absoluteString)));
        }
    }
    return res;
}
 
+ (QVariantMap)NSDictionaryToVariantMap:(NSDictionary*)obj {
    QVariantMap res;
    res.clear();
    if(obj && [obj isKindOfClass: [NSDictionary class]]) {
        for(NSEnumerator* key in [obj keyEnumerator]) {
            id item = [obj objectForKey: key];
            QString keyString = QString::fromNSString((NSString*)key);
            if([item isKindOfClass: [NSDictionary class]]) {
                res[keyString] = [ShavHelperManager NSDictionaryToVariantMap: (NSDictionary*)item];
            } else if([item isKindOfClass: [NSArray class]]) {
                res[keyString] = [ShavHelperManager NSArrayToVariantList: (NSArray*)item];
            } else if([item isKindOfClass: [NSNumber class]]) {
                if((NSNumber*)item == (void*)kCFBooleanFalse || (NSNumber*)item == (void*)kCFBooleanTrue) {
                    BOOL value = [(NSNumber*)item boolValue];
                    res[keyString] = QVariant(((value == YES) ? true : false));
                } else if(strcmp([item objCType], @encode(int)) == 0) {
                    int value = [(NSNumber*)item intValue];
                    res[keyString] = QVariant(value);
                } else if(strcmp([item objCType], @encode(double)) == 0) {
                    double value = [(NSNumber*)item doubleValue];
                    res[keyString] = QVariant(value);
                } else if(strcmp([item objCType], @encode(float)) == 0) {
                    float value = [(NSNumber*)item floatValue];
                    res[keyString] = QVariant(value);
                } else if(strcmp([item objCType], @encode(uint)) == 0) {
                    uint value = [(NSNumber*)item unsignedIntValue];
                    res[keyString] = QVariant(value);
                } else if(strcmp([item objCType], @encode(long long)) == 0) {
                    long long value = [(NSNumber*)item longLongValue];
                    res[keyString] = QVariant(value);
                }
            } else if([item isKindOfClass: [NSString class]]) {
                res[keyString] = QString::fromNSString((NSString*)item);
            } else if([item isKindOfClass:[NSURL class]]) {
                NSURL* url = (NSURL*)item;
                res[keyString] = QVariant(QUrl(QString::fromNSString(url.absoluteString)));
            }
        }
    }
    return res;
}
 
+ (QVariantList)NSArrayToVariantList:(NSArray*)array {
    QVariantList list;
    list.clear();
    if(array) {
        for(id item in array) {
            if([item isKindOfClass: [NSDictionary class]]) {
                list.append([ShavHelperManager NSDictionaryToVariantMap: (NSDictionary*)item]);
            } else if([item isKindOfClass: [NSArray class]]) {
                list.append([ShavHelperManager NSArrayToVariantList: (NSArray*)item]);
            } else if([item isKindOfClass: [NSNumber class]]) {
                if((NSNumber*)item == (void*)kCFBooleanFalse || (NSNumber*)item == (void*)kCFBooleanTrue) {
                    BOOL value = [(NSNumber*)item boolValue];
                    list.append(QVariant(((value == YES) ? true : false)));
                } else if(strcmp([item objCType], @encode(int)) == 0) {
                    int value = [(NSNumber*)item intValue];
                    list.append(QVariant(value));
                } else if(strcmp([item objCType], @encode(double)) == 0) {
                    double value = [(NSNumber*)item doubleValue];
                    list.append(QVariant(value));
                } else if(strcmp([item objCType], @encode(float)) == 0) {
                    float value = [(NSNumber*)item floatValue];
                    list.append(QVariant(value));
                } else if(strcmp([item objCType], @encode(uint)) == 0) {
                    uint value = [(NSNumber*)item unsignedIntValue];
                    list.append(QVariant(value));
                } else if(strcmp([item objCType], @encode(long long)) == 0) {
                    long long value = [(NSNumber*)item longLongValue];
                    list.append(QVariant(value));
                }
            } else if([item isKindOfClass: [NSString class]]) {
                list.append(QString::fromNSString((NSString*)item));
            } else if([item isKindOfClass:[NSURL class]]) {
                NSURL* url = (NSURL*)item;
                list.append(QVariant(QUrl(QString::fromNSString(url.absoluteString))));
            }
        }
    }
    return list;
}
 
+ (QString)applicationBundle {
    return QString::fromNSString([[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleIdentifier"]);
}
 
+ (QVariantMap)NSErrorToVariantMap:(NSError*)error {
    QVariantMap map;
    map.clear();
    if(error) {
        map["code"] = (int)(error.code);
        map["domain"] = QString::fromNSString(error.domain);
        map["localizedDescription"] = QString::fromNSString(error.localizedDescription);
        map["localizedFailureReason"] = QString::fromNSString(error.localizedFailureReason);
        map["localizedRecoverySuggestion"] = QString::fromNSString(error.localizedRecoverySuggestion);
        if(error.userInfo != nil) {
            map["userInfo"] = [ShavHelperManager NSDictionaryToVariantMap: error.userInfo];
        }
    }
 
    return map;
}
 
+ (QSize)CGSizeToQSize:(CGSize)size {
    QSize res;
    res.setWidth((int)size.width);
    res.setHeight((int)size.height);
    return res;
}
 
+ (CGSize)QSizeToCGSize:(QSize)size {
    CGSize res;
    res.width = (float)(size.width());
    res.height = (float)(size.height());
    return res;
}
 
+ (QPoint)CGPointToQPoint:(CGPoint)point {
    QPoint res;
    res.setX((int)point.x);
    res.setY((int)point.y);
    return res;
}
 
+ (CGPoint)QPointToCGPoint:(QPoint)point {
    CGPoint res;
    res.x = (float)(point.x());
    res.y = (float)(point.y());
    return res;
}
 
+ (QRect)CGRectToQRect:(CGRect)frame {
    QRect rec;
    rec.setX((int)frame.origin.x);
    rec.setY((int)frame.origin.y);
    rec.setWidth((int)frame.size.width);
    rec.setHeight((int)frame.size.height);
    return rec;
}
 
+ (CGRect)QRectToCGRect:(QRect)frame {
    CGRect res;
    res.origin.x = frame.x();
    res.origin.y = frame.y();
    res.size.width = frame.width();
    res.size.height = frame.height();
    return res;
}
@end