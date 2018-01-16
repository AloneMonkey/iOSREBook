//
//  CheckHook.m
//  HookDetection
//
//  Created by monkey on 2017/9/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "CheckHook.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <stdio.h>
#import <string.h>
#import <mach-o/dyld.h>

bool CheckHookForOC(const char* clsname,const char* selname){
    Dl_info info;
    SEL sel = sel_registerName(selname);
    Class cls = objc_getClass(clsname);
    Method method = class_getInstanceMethod(cls, sel);
    if(!method){
        method = class_getClassMethod(cls, sel);
    }
    IMP imp = method_getImplementation(method);
    
    if(!dladdr((void*)imp, &info)){
        return false;
    }
    
    printf("%s\n", info.dli_fname);
    
    if(!strncmp(info.dli_fname, "/System/Library/Frameworks", 26)){
        return false;
    }
    
    if(!strcmp(info.dli_fname, _dyld_get_image_name(0))){
        return false;
    }
    
    return true;
}
