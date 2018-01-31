

#import "BaseScene.h"


typedef NS_ENUM(NSUInteger, SceneStyle) {
    SuccessSytle,
    FailureStyle
};


@interface MainScene : BaseScene

+ (instancetype)sceneWithStyle:(SceneStyle)style;

@property (nonatomic, assign) int total;
@property (nonatomic, assign) int headCount;
@property (nonatomic, assign) int bodyCount;

@end
