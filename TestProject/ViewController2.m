
#import "ViewController2.h"
#import "dragView.h"
@interface ViewController2 ()<dragViewDelegate>
{
   
}
@end
@implementation ViewController2
-(void)viewDidLoad
{
    self.title = @"DragView";
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"one" forKey:@"1"];
    [dict setValue:@"two" forKey:@"2"];
    [dict setValue:@"three" forKey:@"3"];
    [dict setValue:@"four" forKey:@"4"];
    [dict setValue:@"five" forKey:@"5"];
    [dict setValue:@"six" forKey:@"6"];
    
    NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
    [dict2 setValue:@"one" forKey:@"1"];
    [dict2 setValue:@"six" forKey:@"6"];
    
    NSMutableDictionary *dict3=[[NSMutableDictionary alloc]init];
    [dict3 setValue:@"one" forKey:@"1"];
    [dict3 setValue:@"two" forKey:@"2"];
    [dict3 setValue:@"three" forKey:@"3"];
    [dict3 setValue:@"four" forKey:@"4"];
    
    NSMutableDictionary *dict4=[[NSMutableDictionary alloc]init];
    [dict4 setValue:@"one" forKey:@"1"];
    [dict4 setValue:@"four" forKey:@"4"];
    [dict4 setValue:@"five" forKey:@"5"];
    [dict4 setValue:@"six" forKey:@"6"];
    
    dragView *drag2=[[dragView alloc]initWithFrame:CGRectMake(0,70,self.view.frame.size.width ,80 ) options:dict];
    drag2.delegate=self;
    drag2.setSelectedIndex=(NSInteger *)5;

    [self.view addSubview:drag2];
    
    dragView *drag3=[[dragView alloc]initWithFrame:CGRectMake(0,160,self.view.frame.size.width ,80 ) options:dict2];
    drag3.delegate=self;

    [self.view addSubview:drag3];
    
    dragView *drag4=[[dragView alloc]initWithFrame:CGRectMake(0,250,self.view.frame.size.width ,80 ) options:dict3];
    drag4.delegate=self;

    [self.view addSubview:drag4];
    
    dragView *drag5=[[dragView alloc]initWithFrame:CGRectMake(0,340,self.view.frame.size.width ,80 ) options:dict4];
    drag5.delegate=self;

    [self.view addSubview:drag5];
    
    dragView *drag6=[[dragView alloc]initWithFrame:CGRectMake(0,430,self.view.frame.size.width ,80 ) options:dict];
    drag6.setSelectedIndex=(NSInteger *)3;
    drag6.delegate=self;

    [self.view addSubview:drag6];

}
- (void)dragViewDidFinish:(dragView*)dragView selectedValue:(NSString *)selectedString

{
    NSLog(@"From Delegate, selected string is :%@",selectedString);
}
@end
