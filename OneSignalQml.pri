INCLUDEPATH += $$PWD/src
DEPENDPATH += $$PWD/src

HEADERS += \
    $$PWD/src/onesignalqml.h

SOURCES += \
    $$PWD/src/onesignalqml.cpp

ios {
    HEADERS += \
        $$PWD/src/ios/onesignalqmlios.h

    OBJECTIVE_HEADERS += \
        $$PWD/src/ios/shavhelpermanager.h

    OBJECTIVE_SOURCES += \
        $$PWD/src/ios/shavhelpermanager.mm \
        $$PWD/src/ios/onesignalqmlios.mm
}
