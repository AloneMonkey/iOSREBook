#include <substrate.h>
#include <objc/runtime.h>

static int (*origin_custom_method)(int,id) = NULL;

int new_custom_method(int number, id _self)
{
	NSLog(@"Hooked!!!");
	number = 20;
    return origin_custom_method(number, _self);   
}

__attribute__((constructor))
int main(void){
	NSLog(@"Load!!!");
    MSHookFunction(MSFindSymbol(NULL,"__T09SwiftDemo14ViewControllerC12CustomMethodS2i6number_tF"),
         (void*)new_custom_method,
         (void**)&origin_custom_method);
   
   return 0;
}