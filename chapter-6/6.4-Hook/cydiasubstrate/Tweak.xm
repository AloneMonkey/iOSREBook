
#include <substrate.h>
#include <objc/runtime.h>

@class ViewController;

static void (*originMethodImp)(ViewController*, SEL, id);

static void newMethodImp(ViewController* self, SEL _cmd, id sender) { 
	NSLog(@"-[<ViewController: %p> Hook clickMe:%@]", self, sender); 
	originMethodImp(self, _cmd, sender); 
}

int (*oldopen)(const char *, int, ...);

int newopen(const char *path, int oflag, ...) {
    va_list ap = {0};
    mode_t mode = 0;
    
    if ((oflag & O_CREAT) != 0) {
        va_start(ap, oflag);
        mode = va_arg(ap, int);
        va_end(ap);
        printf("MSHookFunction | Calling real open('%s', %d, %d)\n", path, oflag, mode);
        return oldopen(path, oflag, mode);
    } else {
        printf("MSHookFunction | Calling real open('%s', %d)\n", path, oflag);
        return oldopen(path, oflag, mode);
    }
}

static __attribute__((constructor)) void myinit() {

    Class targetClass = objc_getClass("ViewController");
    
	MSHookMessageEx(targetClass,@selector(clickMe:),(IMP)&newMethodImp,(IMP*)&originMethodImp);

	MSHookFunction(open, newopen, &oldopen);

}