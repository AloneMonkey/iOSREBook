//
//  ViewController.m
//  RuntimeDemo
//
//  Created by AloneMonkey on 2017/8/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"
#import <objc/runtime.h>

static const void *kAssociatedKey = &kAssociatedKey;

static void *kExampleDoubleKey;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyClass *myClass = [[MyClass alloc] init];
    
    //KVC
    NSString* property = [myClass valueForKey:@"_property"];
    NSLog(@"property: %@", property);
    
    Ivar ivar = class_getInstanceVariable(objc_getClass("MyClass"), "_property");
    if(ivar){
        NSString* ivarProperty = (__bridge NSString *)(*(void**)((__bridge void*)myClass + ivar_getOffset(ivar)));
        NSLog(@"ivarProperty: %@", ivarProperty);
    }
    
    //AssociatedObject
    
    objc_setAssociatedObject(myClass, kAssociatedKey, @"AssociatedObject1", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString* associatedString = objc_getAssociatedObject(myClass, kAssociatedKey);
    
    NSLog(@"associatedString: %@", associatedString);
    
    objc_setAssociatedObject(myClass, &kExampleDoubleKey, @"AssociatedObject2", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    associatedString = objc_getAssociatedObject(myClass, &kExampleDoubleKey);
    
    NSLog(@"associatedString: %@", associatedString);
    
    objc_setAssociatedObject(myClass, @selector(myProperty), @"AssociatedObject3", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    associatedString = objc_getAssociatedObject(myClass, @selector(myProperty));
    
    NSLog(@"associatedString: %@", associatedString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
