#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <malloc/malloc.h>
#import <Foundation/Foundation.h>

//标准的interpose数据结构
typedef struct interpose_s{
    void *new_func;
    void *orig_func;
}interpose_t;

void *my_malloc(int size);
void my_free(void *);

static const interpose_t interposing_functions[] \
__attribute((used, section("__DATA,""__interpose"" "))) = {{(void *)my_free,(void *)free},{(void *)my_malloc,(void *)malloc}};

void *my_malloc (int size){
    void *returned = malloc(size);
    //printf中会调用malloc(),产生无限递归调用
    malloc_printf("malloc hooked!!! is my malloc %p %d\n",returned,size);
    return (returned);
}

void my_free(void *freed){
    malloc_printf("free hooked!!! is my free  %p\n",freed);
    free(freed);
}

__attribute__((constructor)) static void entry(){
    NSLog(@"InsertDylib Loaded!!!\n");
}
