



#import "CYLPlusButton.h"
#import "CYLTabBarController.h"

UIButton<CYLPlusButtonSubclassing> *CYLExternPushlishButton = nil;
@interface CYLPlusButton ()<UIActionSheetDelegate>

@end

@implementation CYLPlusButton

#pragma mark -
#pragma mark - Private Methods

+ (void)registerSubclass {
    if ([self conformsToProtocol:@protocol(CYLPlusButtonSubclassing)]) {
        Class<CYLPlusButtonSubclassing> class = self;
        CYLExternPushlishButton = [class plusButton];
    }
}

@end
