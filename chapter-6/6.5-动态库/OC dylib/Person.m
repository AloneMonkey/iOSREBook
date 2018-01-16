#import "Person.h"
 
@implementation Person{
	NSString* _person_name;
}

- (id)init {
    if (self = [super init]) {
        _person_name = @"";
    }
    return self;
}
 
- (void)setName:(NSString*)name {
    _person_name = name;
}
 
- (NSString*)name {
    return _person_name;
}
@end