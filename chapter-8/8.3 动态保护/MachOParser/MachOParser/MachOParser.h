//
//  MachOParser.h
//  MachOParser
//
//  Created by AloneMonkey on 2017/9/25.
//  Copyright © 2017年 AloneMonkey. All rights reserved.
//

#include <stdint.h>
#import <mach/mach.h>
#import <Foundation/Foundation.h>

//https://github.com/rpetrich/ldid/blob/master/ldid.cpp

#ifdef __LP64__
typedef struct mach_header_64 mach_header_t;
typedef struct segment_command_64 segment_command_t;
typedef struct section_64 section_t;
typedef struct nlist_64 nlist_t;
typedef uint64_t local_addr;
#define LC_SEGMENT_ARCH_DEPENDENT LC_SEGMENT_64
#else
typedef struct mach_header mach_header_t;
typedef struct segment_command segment_command_t;
typedef struct section section_t;
typedef struct nlist nlist_t;
typedef uint32_t local_addr;
#define LC_SEGMENT_ARCH_DEPENDENT LC_SEGMENT
#endif

typedef struct _section_info_t{
    section_t *section;
    local_addr addr;
}section_info_t;

typedef struct _segment_info_t{
    segment_command_t *segment;
    local_addr addr;
}segment_info_t;

class MachOParser{
public:
    void* base;
    long slide;
public:
    MachOParser();
    MachOParser(const char* base);
    MachOParser(void* base, local_addr slide);
    
    /**
     find mach-o load command load dylib name

     @return array of dylibs
     */
    NSArray* find_load_dylib();
    
    /**
     get mach-o segment

     @param segname segment name
     @return segment struct
     */
    segment_info_t* find_segment(const char* segname);
   
    /**
     get mach-o section

     @param segname segment name
     @param secname section name
     @return section struct
     */
    section_info_t* find_section(const char* segname,const char* secname);
    
    /**
     get md5 value from text in memory

     @return md5 string
     */
    NSString* get_text_data_md5();
private:
    local_addr vm2real(local_addr vmaddr);
};
