#import <UIKit/UIKit.h>

@interface MyClass : NSObject

+ (void) classMethod;

@end

@implementation MyClass

+ (void) classMethod{
    NSLog(@"class method");
}

@end

int main(int argc, char * argv[]){
    @autoreleasepool {
        [MyClass classMethod];
        return 0;
    }
}
