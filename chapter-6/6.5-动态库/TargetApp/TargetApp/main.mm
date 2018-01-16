//
//  main.m
//  TargetApp
//
//  Created by AloneMonkey on 2017/9/12.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <objc/runtime.h>
#import "Person.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        void *lib_handle = dlopen("/Library/MobileSubstrate/DynamicLibraries/target.dylib", RTLD_LOCAL);
//        if(!lib_handle){
//            NSLog(@"Unable to open library: %s",dlerror());
//            return 0;
//        }
//
//        Person_creator* NewPerson = (Person_creator*)dlsym(lib_handle, "_Z9NewPersonv");
//        if(!NewPerson){
//            NSLog(@"Unable to find NewPerson method:%s",dlerror());
//            return 0;
//        }
//
//        Person_disposer* DeletePerson = (Person_disposer*)dlsym(lib_handle, "_Z12DeletePersonP6Person");
//        if(!DeletePerson){
//            NSLog(@"Unable to find DeletePerson method:%s",dlerror());
//            return 0;
//        }
//
//        Person* person = (Person*)NewPerson();
//
//        NSLog(@"person->name() = %s",person->name());
//
//        char new_name[] = "AloneMonkey";
//
//        person->set_name(new_name);
//
//        NSLog(@"person->name() = %s",person->name());
//
//        DeletePerson(person);
//
//        if(dlclose(lib_handle) != 0){
//            NSLog(@"Unable to close library: %s",dlerror());
//        }

        // Open the library.
        void* lib_handle = dlopen("/Library/MobileSubstrate/DynamicLibraries/target.dylib", RTLD_LOCAL);
        if (!lib_handle) {
            NSLog(@"[%s] main: Unable to open library: %s\n",
                  __FILE__, dlerror());
            exit(EXIT_FAILURE);
        }
        
        Class PersonClass = objc_getClass("Person");
        if (!PersonClass) {
            NSLog(@"[%s] main: Unable to get Person class", __FILE__);
            exit(EXIT_FAILURE);
        }
        
        NSLog(@"[%s] main: Instantiating PersonClass", __FILE__);
        Person* person = [PersonClass new];
        
        [person setName:@"Alone Monkey"];
        NSLog(@"[%s] main: [person name] = %@", __FILE__, [person name]);
        
        if (dlclose(lib_handle) != 0) {
            NSLog(@"[%s] Unable to close library: %s\n",
                  __FILE__, dlerror());
            exit(EXIT_FAILURE);
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
