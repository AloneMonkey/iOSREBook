//
//  main.m
//  ArmDemo
//
//  Created by monkey on 2017/9/4.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef struct _MyStruct0{
    int a;
    int b;
}MyStruct0;

typedef struct _MyStruct1{
    int a;
    int b;
    int c;
    int d;
}MyStruct1;

typedef struct _MyStruct2{
    int a;
    int b;
    int c;
    int d;
    int e;
    int f;
}MyStruct2;

int add1(int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k){ //11 args
    return a + b + j + k;
}

double add2(double a, double b){
    return a + b;
}

//返回值保存在x0
MyStruct0 genStruct0(int a, int b){
    MyStruct0 s;
    s.a = a;
    s.b = b;
    return s;
}

//返回值保存在x0和x1
MyStruct1 genStruct1(int a, int b, int c, int d){
    MyStruct1 s;
    s.a = a;
    s.b = b;
    s.c = c;
    s.d = d;
    return s;
}

//返回值拷贝到x8
MyStruct2 genStruct2(int a, int b, int c, int d, int e, int f){
    MyStruct2 s;
    s.a = a;
    s.b = b;
    s.c = c;
    s.d = d;
    s.e = e;
    s.f = f;
    return s;
}

int main(int argc, char * argv[]) {
    
    int c = add1(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13);
    double d = add2(13.14, 5.20);
    printf("%d %f",c,d);
    
    MyStruct0 s0;
    s0 = genStruct0(3, 4);
    
    printf("%d %d", s0.a, s0.b);
    
    MyStruct1 s1;
    s1 = genStruct1(3, 4, 5, 6);
    
    printf("%d %d %d %d", s1.a, s1.b, s1.c, s1.d);
    
    MyStruct2 s2;
    s2 = genStruct2(3, 4, 5, 6, 7, 8);
    
    printf("%d %d %d %d %d %d", s2.a, s2.b, s2.c, s2.d, s2.e, s2.f);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
