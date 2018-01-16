#import <UIKit/UIKit.h>

@interface MyClass : NSObject

@property NSString *myProperty;

@end

@implementation MyClass

- (void)myMethod{
    NSLog(@"my method");
}

+ (void)myClassMethod{
    NSLog(@"my class method");
}

@end

int main(int argc, char * argv[]){
    @autoreleasepool{
        return 0;
    }
}

