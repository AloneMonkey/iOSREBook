//
//  MachOParser.m
//  MachOParser
//
//  Created by AloneMonkey on 2017/9/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#import "MachOParser.h"
#import <mach-o/dyld.h>
#import <string.h>
#import <stdio.h>
#import <stdlib.h>
#import <sys/types.h>
#import <CommonCrypto/CommonDigest.h>

MachOParser::MachOParser(){
    this->base = (void*)_dyld_get_image_header(0);
    this->slide = _dyld_get_image_vmaddr_slide(0);
}

MachOParser::MachOParser(void* base,local_addr slide){
    this->base = base;
    this->slide = slide;
}

MachOParser::MachOParser(const char* name){
    unsigned imgCount = _dyld_image_count();
    for (unsigned i = 0; i < imgCount; i++) {
        const char *imgName = _dyld_get_image_name(i);
        if(strstr(imgName,name)){
            this->base = (void*)_dyld_get_image_header(i);
            this->slide = _dyld_get_image_vmaddr_slide(i);
            return;
        }
    }
}

local_addr MachOParser::vm2real(local_addr vmaddr){
    return this->slide + vmaddr;
}

//获取加载的动态库
NSArray* MachOParser::find_load_dylib(){
    NSMutableArray* array = [[NSMutableArray alloc] init];;
    mach_header_t *header = (mach_header_t*)base;
    segment_command_t *cur_seg_cmd;
    uintptr_t cur = (uintptr_t)this->base + sizeof(mach_header_t);
    for (uint i = 0; i < header->ncmds; i++,cur += cur_seg_cmd->cmdsize) {
        cur_seg_cmd = (segment_command_t*)cur;
        if(cur_seg_cmd->cmd == LC_LOAD_DYLIB || cur_seg_cmd->cmd == LC_LOAD_WEAK_DYLIB){
            dylib_command *dylib = (dylib_command*)cur_seg_cmd;
            char* name = (char*)((uintptr_t)dylib + dylib->dylib.name.offset);
            NSString* dylibName = [NSString stringWithUTF8String:name];
            [array addObject:dylibName];
        }
    }
    return [array copy];
}

//查找某个段
segment_info_t* MachOParser::find_segment(const char *segname){
    mach_header_t *header = (mach_header_t*)base;
    segment_command_t *cur_seg_cmd;
    uintptr_t cur = (uintptr_t)this->base + sizeof(mach_header_t);
    for (uint i = 0; i < header->ncmds; i++,cur += cur_seg_cmd->cmdsize) {
        cur_seg_cmd = (segment_command_t*)cur;
        if(cur_seg_cmd->cmd == LC_SEGMENT_ARCH_DEPENDENT){
            if(!strcmp(segname,cur_seg_cmd->segname)){
                segment_info_t *cur_segment_info = new segment_info_t();
                cur_segment_info->segment = cur_seg_cmd;
                cur_segment_info->addr = this->vm2real(cur_seg_cmd->vmaddr);
                return cur_segment_info;
            }
        }
    }
    return nullptr;
}

//查找某个节
section_info_t* MachOParser::find_section(const char *segname, const char *secname){
    mach_header_t *header = (mach_header_t*)base;
    segment_command_t *cur_seg_cmd;
    uintptr_t cur = (uintptr_t)this->base + sizeof(mach_header_t);
    for (uint i = 0; i < header->ncmds; i++,cur += cur_seg_cmd->cmdsize) {
        cur_seg_cmd = (segment_command_t*)cur;
        if(cur_seg_cmd->cmd == LC_SEGMENT_ARCH_DEPENDENT){
            if(!strcmp(segname,cur_seg_cmd->segname)){
                for (uint j = 0; j < cur_seg_cmd->nsects; j++) {
                    section_t *sect = (section_t *)(cur + sizeof(segment_command_t)) + j;
                    if(!strcmp(secname, sect->sectname)){
                        section_info_t *cur_section_info = new section_info_t();
                        cur_section_info->section = sect;
                        cur_section_info->addr = this->vm2real(sect->addr);
                        return cur_section_info;
                    }
                }
            }
        }
    }
    return nullptr;
}

//获取运行代码md5
NSString* MachOParser::get_text_data_md5(){
    NSMutableString *result = [NSMutableString string];
    section_info_t *section = this->find_section("__TEXT", "__text");
    local_addr startAddr =  section->addr;
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5((const void *)startAddr, (CC_LONG)section->section->size, hash);
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",hash[i]];
    }
    return [result copy];
}

