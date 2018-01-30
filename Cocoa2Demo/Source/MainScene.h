

#import "BaseScene.h"


typedef NS_ENUM(NSUInteger, SceneStyle) {
    SuccessSytle,
    FailureStyle
};


@interface MainScene : BaseScene

+ (instancetype)sceneWithStyle:(SceneStyle)style;

@end
