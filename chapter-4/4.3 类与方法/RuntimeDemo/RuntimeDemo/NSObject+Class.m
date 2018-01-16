//
//  NSObject+Class.m
//  ClassDemo
//
//  Created by AloneMonkey on 2017/8/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "NSObject+Class.h"
#import <objc/runtime.h>

#if __LP64__
typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits
#else
typedef uint16_t mask_t;
#endif

#if !__LP64__
#define FAST_DATA_MASK 0xfffffffcUL
#else
#define FAST_DATA_MASK 0x00007ffffffffff8UL
#endif

typedef struct objc_method {
    char * sel;
    const char *method_type;
    void  *_imp;
}objc_method;

typedef struct method_list_t {
    unsigned int entsizeAndFlags;
    unsigned int count;
    objc_method first;
}method_list_t;

typedef struct property_t {
    const char *name;
    const char *attributes;
}property_t;

typedef struct property_list_t {
    unsigned int entsizeAndFlags;
    unsigned int count;
    property_t first;
}property_list_t;

typedef struct protocol_list_t {
    // count is 64-bit by accident.
    uintptr_t count;
    uintptr_t list[0]; // variable-size
}protocol_list_t;

struct ivar_t {
    int32_t *offset;
    const char *name;
    const char *type;
    // alignment is sometimes -1; use alignment() instead
    uint32_t alignment_raw;
    uint32_t size;
};

typedef struct ivar_list_t {
    unsigned int entsizeAndFlags;
    unsigned int count;
    struct ivar_t first;
}ivar_list_t;

typedef struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;
#ifdef __LP64__
    uint32_t reserved;
#endif
    
    const uint8_t * ivarLayout;
    
    const char * name;
    method_list_t * baseMethodList;
    protocol_list_t * baseProtocols;
    ivar_list_t * ivars;
    
    const uint8_t * weakIvarLayout;
    property_list_t * baseProperties;
}class_ro_t;

typedef struct class_rw_t {
    // Be warned that Symbolication knows the layout of this structure.
    uint32_t flags;
    uint32_t version;
    
    const class_ro_t *ro;
    
    method_list_t * methods;
    property_list_t * properties;
    protocol_list_t * protocols;
    
    Class firstSubclass;
    Class nextSiblingClass;
    
    char * demangledName;
}class_rw_t;

struct bucket_t {
    uintptr_t _key;
    IMP _imp;
};

typedef struct cache_t {
    struct bucket_t *_buckets;
    mask_t _mask;
    mask_t _occupied;
}cache_t;

typedef struct class_data_bits_t {
    // Values are the FAST_ flags above.
    uintptr_t bits;
}class_data_bits_t;

typedef struct _objc_class{
    Class isa;
    Class superclass;
    cache_t cache;             // formerly cache pointer and vtable
    class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
}_objc_class;


@implementation NSObject(Class)

+ (void) PrintInternalClass{
    _objc_class *objcClass = (__bridge typeof(objcClass))[self class];
    
    class_rw_t *classReadWrite = (typeof(classReadWrite))(objcClass->bits.bits & FAST_DATA_MASK);
    
    NSLog(@"done");
}

+ (NSArray*) PrintVariables {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        ptrdiff_t ivarOffset = ivar_getOffset(ivars[i]);
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivars[i])];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        NSString *ivarDescription = [NSString stringWithFormat:@"offset: %td name:%@ type:%@",ivarOffset, name, type];
        [result addObject:ivarDescription];
    }
    free(ivars);
    return result;
}

+ (NSArray*) PrintMethods{
    NSMutableArray * array = [NSMutableArray array];
    unsigned int count = 0;
    Method * methodList = class_copyMethodList([self class], &count);
    for(int i = 0; i < count; i++) {
        [array addObject:[NSString stringWithFormat:@"name:%@ type encode:%@ IMP:%p",
                          NSStringFromSelector(method_getName(methodList[i])),
                          [NSString stringWithUTF8String:method_getTypeEncoding(methodList[i])],
                          method_getImplementation(methodList[i])]];
    }
    
    free(methodList);
    return array;
}

+ (void)PrintClassChain:(Class)aClass{
    NSLog(@"Class:%@ Address:%p", aClass,aClass);
    
    Class getClass = object_getClass(aClass);
    
    if(getClass != aClass){
        [self PrintClassChain:getClass];
    }
}

@end
