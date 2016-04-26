
#import <UIKit/UIKit.h>
#import "arrowView.h"
@protocol dragViewDelegate;
@interface dragView : UIView
{
    NSMutableArray *arrayLabel;
   // id<dragViewDelegate> delegate;

}
@property(nonatomic)UILabel *dragLabel;
@property (nonatomic, assign) id<dragViewDelegate> delegate;
@property(nonatomic)arrowView *ViewArrow;
@property(nonatomic)NSMutableDictionary *options;
@property(nonatomic)NSInteger * setSelectedIndex;
@property(nonatomic)NSString *strSelectedOption;
- (id)initWithFrame:(CGRect)frame options:(NSMutableDictionary *)optionals;

@end
@protocol dragViewDelegate <NSObject>
- (void)dragViewDidFinish:(dragView*)dragView selectedValue:(NSString *)selectedString;
@end