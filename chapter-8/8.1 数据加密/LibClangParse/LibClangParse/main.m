//
//  main.m
//  LibClangParse
//
//  Created by monkey on 2017/9/23.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import "Index.h"

#define FILENAME "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-8/LibClangParse/LibClangParse/DealFiles/TargetFile.m"

CXIndex  (*myclang_createIndex)(int excludeDeclarationsFromPCH, int displayDiagnostics);
CXTranslationUnit (*myclang_createTranslationUnitFromSourceFile)(
                                               CXIndex CIdx,
                                               const char *source_filename,
                                               int num_clang_command_line_args,
                                               const char * const *clang_command_line_args,
                                               unsigned num_unsaved_files,
                                               struct CXUnsavedFile *unsaved_files);
CXCursor (*myclang_getTranslationUnitCursor)(CXTranslationUnit);
unsigned (*myclang_visitChildren)(CXCursor parent,
                                  CXCursorVisitor visitor,
                                  CXClientData client_data);
void (*myclang_disposeTranslationUnit)(CXTranslationUnit);
void (*myclang_disposeIndex)(CXIndex index);
CXSourceRange (*myclang_getCursorExtent)(CXCursor);
CXSourceLocation (*myclang_getRangeStart)(CXSourceRange range);
CXSourceLocation (*myclang_getRangeEnd)(CXSourceRange range);
void (*myclang_getExpansionLocation)(CXSourceLocation location,
                                     CXFile *file,
                                     unsigned *line,
                                     unsigned *column,
                                     unsigned *offset);
CXString (*myclang_getFileName)(CXFile SFile);
const char *(*myclang_getCString)(CXString string);
CXString (*myclang_getCursorDisplayName)(CXCursor);
void (*myclang_disposeString)(CXString string);
enum CXCursorKind (*myclang_getCursorKind)(CXCursor);
enum CXLinkageKind (*myclang_getCursorLinkage)(CXCursor cursor);
unsigned (*myclang_isPreprocessing)(enum CXCursorKind);
CXString (*myclang_getCursorKindSpelling)(enum CXCursorKind Kind);
unsigned (*myclang_isStatement)(enum CXCursorKind);
unsigned (*myclang_isAttribute)(enum CXCursorKind);
unsigned (*myclang_isExpression)(enum CXCursorKind);
unsigned (*myclang_isTranslationUnit)(enum CXCursorKind);
unsigned (*myclang_isDeclaration)(enum CXCursorKind);
unsigned (*myclang_isReference)(enum CXCursorKind);
unsigned (*myclang_isInvalid)(enum CXCursorKind);
CXString (*myclang_getTokenSpelling)(CXTranslationUnit, CXToken);
CXSourceRange (*myclang_getRange)(CXSourceLocation begin,
                                  CXSourceLocation end);

void initlibfunclist(void *handle){
    myclang_createIndex = dlsym(handle, "clang_createIndex");
    myclang_createTranslationUnitFromSourceFile = dlsym(handle, "clang_createTranslationUnitFromSourceFile");
    myclang_getTranslationUnitCursor = dlsym(handle, "clang_getTranslationUnitCursor");
    myclang_visitChildren = dlsym(handle, "clang_visitChildren");
    myclang_disposeTranslationUnit = dlsym(handle, "clang_disposeTranslationUnit");
    myclang_disposeIndex = dlsym(handle, "clang_disposeIndex");
    myclang_getCursorExtent = dlsym(handle, "clang_getCursorExtent");
    myclang_getRangeStart = dlsym(handle, "clang_getRangeStart");
    myclang_getRangeEnd = dlsym(handle, "clang_getRangeEnd");
    myclang_getExpansionLocation = dlsym(handle, "clang_getExpansionLocation");
    myclang_getFileName = dlsym(handle, "clang_getFileName");
    myclang_getCursorDisplayName = dlsym(handle, "clang_getCursorDisplayName");
    myclang_disposeString = dlsym(handle, "clang_disposeString");
    myclang_getCString = dlsym(handle, "clang_getCString");
    myclang_getCursorKind = dlsym(handle, "clang_getCursorKind");
    myclang_getCursorLinkage = dlsym(handle, "clang_getCursorLinkage");
    myclang_getCursorKindSpelling = dlsym(handle, "clang_getCursorKindSpelling");
    myclang_getTokenSpelling = dlsym(handle, "clang_getTokenSpelling");
}

CXTranslationUnit TU;

void showString(int start, int end){
    NSString *conent = [[NSString alloc] initWithContentsOfFile:@FILENAME encoding:NSASCIIStringEncoding error:nil];
    NSString *res = [conent substringWithRange:NSMakeRange(start, end-start)];
    
    printf("----------遍历的内容----------\n %s\n------------------------------\n",[res UTF8String]);
}

enum CXChildVisitResult printVisitor(CXCursor cursor, CXCursor parent, CXClientData client_data) {
    CXFile file;
    unsigned int line,column,start,end;
    CXSourceRange range = myclang_getCursorExtent(cursor);
    CXSourceLocation startLocation = myclang_getRangeStart(range);
    CXSourceLocation endLocation = myclang_getRangeEnd(range);
    
    myclang_getExpansionLocation(startLocation, &file, &line, &column, &start);
    myclang_getExpansionLocation(endLocation, &file, &line, &column, &end);
    
    //获取文件名
    CXString cxname = myclang_getFileName(file);
    const char* filename = myclang_getCString(cxname);
    myclang_disposeString(cxname);
    
    //过滤文件
    if(filename == NULL || strcmp(filename, FILENAME)){
        return CXChildVisit_Continue;
    }
    
    showString(start,end);
    
    //获取displayName
    CXString cxdisname =  myclang_getCursorDisplayName(cursor);
    const char* disname = myclang_getCString(cxdisname);
    printf("disname is => %s\n",disname);
    myclang_disposeString(cxdisname);
    
    //获取类型
    enum CXCursorKind kind = myclang_getCursorKind(cursor);
    CXString cxcurkind = myclang_getCursorKindSpelling(kind);
    const char* ccurkind = myclang_getCString(cxcurkind);
    printf("ccurkind is =>%s\n",ccurkind);
    myclang_disposeString(cxcurkind);
    
    //判断类型
    enum CXLinkageKind cxlinkkind = myclang_getCursorLinkage(cursor);
    if(!strcmp(ccurkind, "VarDecl")&&(cxlinkkind == CXLinkage_External)){
        return CXChildVisit_Continue;
    }
    
    if(!strcmp(ccurkind, "ObjCStringLiteral")){
        printf("OC类型字符串\n");
        return CXChildVisit_Continue;
    }
    
    if(!strcmp(ccurkind, "StringLiteral")){
        printf("C类型字符串\n");
        return CXChildVisit_Continue;
    }
    
    const char* disname2 = myclang_getCString(cxdisname);
    
    printf("继续遍历孩子节点%s\n",disname2);
    
    return CXChildVisit_Recurse;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        void *hand = dlopen("/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib",RTLD_LAZY);
        
        initlibfunclist(hand);
        
        // excludeDeclsFromPCH = 1, displayDiagnostics=1
        CXIndex cxindex = myclang_createIndex(1, 1);
        
        TU = myclang_createTranslationUnitFromSourceFile(cxindex, FILENAME, 0, nil, 0, 0);
        myclang_visitChildren(myclang_getTranslationUnitCursor(TU), printVisitor, 0);

        myclang_disposeTranslationUnit(TU);
        myclang_disposeIndex(cxindex);
    }
    return 0;
}
