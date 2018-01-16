//
//  AntiDebug.m
//  DynamicProtect
//
//  Created by monkey on 2017/9/24.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "AntiDebug.h"
#import <dlfcn.h>
#import </usr/include/sys/ptrace.h>
#import <sys/sysctl.h>
#import <mach/task.h>
#import <mach/mach_init.h>
#include <termios.h>
#include <sys/ioctl.h>

#ifndef PT_DENY_ATTACH
    #define PT_DENY_ATTACH 31
#endif

typedef void (^dbCheckBlock)(void);

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);

BOOL isDebuggerPresent(){
    int name[4];                //指定查询信息的数组
    
    struct kinfo_proc info;     //查询的返回结果
    size_t info_size = sizeof(info);
    
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if(sysctl(name, 4, &info, &info_size, NULL, 0) == -1){
        NSLog(@"sysctl error : %s", strerror(errno));
        return NO;
    }
    
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

void dbgCheck(dbCheckBlock block){
    dispatch_queue_t _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        if(isDebuggerPresent()){
            dispatch_source_cancel(_timer);
            if(block){
                block();
            }
        }
    });
    dispatch_resume(_timer);
}

//TODO inline
void AntiDebug_001(){
    ptrace(PT_DENY_ATTACH, 0, 0, 0);
}

void AntiDebug_002(){
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
}

void AntiDebug_003(){
    if(isDebuggerPresent()){
        NSLog(@"检测到调试器!!!");
    }
}

void AntiDebug_004(){
    dbgCheck(^{
        NSLog(@"检测到调试器!!!");
    });
}

void AntiDebug_005(){
    syscall(26,31,0,0,0);
}

void AntiDebug_006(){
#ifdef __arm__
    asm volatile(
                 "mov r0,#31\n"
                 "mov r1,#0\n"
                 "mov r2,#0\n"
                 "mov r12,#26\n"
                 "svc #80\n"
                 );
#endif
#ifdef __arm64__
    asm volatile(
                 "mov x0,#26\n"
                 "mov x1,#31\n"
                 "mov x2,#0\n"
                 "mov x3,#0\n"
                 "mov x16,#0\n"
                 "svc #128\n"
                 );
#endif
}

void AntiDebug_007(){
    struct macosx_exception_info{
        exception_mask_t masks[EXC_TYPES_COUNT];
        mach_port_t ports[EXC_TYPES_COUNT];
        exception_behavior_t behaviors[EXC_TYPES_COUNT];
        thread_state_flavor_t flavors[EXC_TYPES_COUNT];
        mach_msg_type_number_t cout;
    };
    struct macosx_exception_info *info = malloc(sizeof(struct macosx_exception_info));
    task_get_exception_ports(mach_task_self(),
                             EXC_MASK_ALL,
                             info->masks,
                             &info->cout,
                             info->ports,
                             info->behaviors,
                             info->flavors);
    for(uint32_t i = 0; i < info->cout; i ++){
        if(info->ports[i] != 0 || info->flavors[i] == THREAD_STATE_NONE){
            NSLog(@"debugger detected via exception ports (null port)!\n");
        }
    }
}

void AntiDebug_008(){
    if (isatty(1)) {
        NSLog(@"Being Debugged isatty");
    }
}

void AntiDebug_009(){
    if (!ioctl(1, TIOCGWINSZ)) {
        NSLog(@"Being Debugged ioctl");
    }
}

static __attribute__((constructor)) void entry(){
    
//    AntiDebug_001();
//
//    AntiDebug_002();
//
//    AntiDebug_003();
//
//    AntiDebug_004();
//    
//    AntiDebug_005();
    
//    AntiDebug_006();
    
//    AntiDebug_007();
    
//    AntiDebug_008();
    
//    AntiDebug_009();
}
