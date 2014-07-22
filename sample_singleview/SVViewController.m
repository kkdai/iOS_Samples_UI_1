 //
//  SVViewController.m
//  sample_singleview
//
//  Created on 2014/3/13.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#import "SVViewController.h"

@interface SVViewController ()
@end

@implementation SVViewController
{
    SVInheritParent *obj1;
}
@synthesize drawingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    CGRect frame = CGRectMake(20, 45, 140, 21);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [self.view addSubview:label];
    [label setText:@"Number of sides:"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    lineView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lineView];

    
    //[drawingView setNeedsDisplay];

    {
//        CGRect frame = CGRectMake(20, 45, 140, 21);
//        UILabel *label = [[UILabel alloc] initWithFrame:frame];
//        [drawingView addSubview:label];
//        [label setText:@"Number of sides:"];
    }
    
    
    [self listSubviewsOfView:self.view];
    NSLog(@"------------------------");
    [self listSubviewsOfView:drawingView];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, drawingView.bounds.size.width, 30)];
    lineView2.backgroundColor = [UIColor yellowColor];
    [drawingView addSubview:lineView2];
    NSLog(@"------------------------");
    [self listSubviewsOfView:drawingView];
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES); // 360 degree (0 to 2pi) arc
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"%@", subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 1)];
//    lineView.backgroundColor = [UIColor blackColor];
//
//    [self.view addSubview:lineView];


-(IBAction)startScaleTransform:(id)sender
{
    self.view.transform = CGAffineTransformMakeScale(2,2);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    self.view.transform = CGAffineTransformMakeScale(1,1);
    self.view.alpha = 1.0;
    [UIView commitAnimations];
    obj1 = [[SVInheritChild alloc] initWithDelegate:self];
    [obj1 method_1];
}

#pragma mark Callback Delegate
-(void)didCallBack:(NSString*) callback_str;
{
    NSLog(callback_str);
}


#pragma mark xml load
- (void)parseXMLandWriteServer
{
    //打开xml文件，读取数据到NSData
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"xml"];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    
    //测试从xml接受到的数据
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataString);
    
    NSXMLParser *m_parser = [[NSXMLParser alloc] initWithData:data];
    //设置该类本身为代理类，即该类在声明时要实现NSXMLParserDelegate委托协议
    [m_parser setDelegate:self];  //设置代理为本地
    
    BOOL flag = [m_parser parse]; //开始解析
    if(flag) {
        NSLog(@"解析指定路径的xml文件成功");
    }
    else {
        NSLog(@"解析指定路径的xml文件失败");
    }
}

#pragma mark xmlparser
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //Initialize the array.
    bankWebArray = [[NSMutableArray alloc] init];
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //去掉字符串的空格
    NSLog(@"value =%@", elementName);
    if([elementName isEqualToString:@"Banks"]) {
        storingFlag = NO;
    }
    else if([elementName isEqualToString:@"li"]) {
        //push arry
        if (aBank) {
            [bankWebArray addObject:aBank];
            aBank = nil;
        }
        
        aBank = [[Bank alloc] init];
        storingFlag = NO;
    }else if([elementName isEqualToString:@"div"]) {
        storingFlag = YES;
        NSString *classValue = [attributeDict objectForKey:@"class"];
        currentAttrib = classValue;
        //NSLog(@"Bank ....");
    }
    
    //storingFlag = [elementToParse containsObject:elementName];  //判断是否存在要存储的对象
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingFlag) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
}

//step 4 ：解析完当前节点
// 这里才是真正完成整个解析并保存数据的最终结果的地方
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (storingFlag) {
        //去掉字符串的空格
        NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimmedString length]== 0)
            return;
        
        //将字符串置空
        if ([currentAttrib isEqualToString:@"location_name"]) {
            aBank.name = trimmedString;
        }
        if ([currentAttrib isEqualToString:@"address"]) {
            aBank.address = trimmedString;
        }
        if ([currentAttrib isEqualToString:@"phone_no"]) {
            aBank.phone = trimmedString;
        }
        if ([currentAttrib isEqualToString:@"area"]) {
            NSArray *myWords = [trimmedString componentsSeparatedByCharactersInSet:
                                [NSCharacterSet characterSetWithCharactersInString:@" "]];
            aBank.area = myWords[0];
            aBank.address = [[NSString alloc] initWithFormat:@"%@%@", aBank.area, aBank.address];
            aBank.add_num = myWords[1];
        }
        NSLog(@"Parse data %@",trimmedString);
    }
}

//step 5：解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //Save last parsed data
    if (aBank) {
        [bankWebArray addObject:aBank];
        aBank = nil;
    }
    
    
    //Print all data
    for (Bank *obj in bankWebArray) {
        NSLog(@"Bank data[%@] name =%@, address=%@, phone=%@", obj.area, obj.name, obj.address, obj.phone);
        
        //save to DB
    }
}
//step 6：获取cdata块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    
}
@end
