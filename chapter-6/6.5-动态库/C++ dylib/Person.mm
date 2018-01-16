#include <iostream>
#import <Foundation/Foundation.h>
#include "Person.h"
 
#define EXPORT __attribute__((visibility("default")))
 
EXPORT
Person::Person() {
    char default_name[] = "<no value>";
    this->set_name(default_name);
}
 
EXPORT
Person* NewPerson(void) {
    return new Person;
}
 
EXPORT
void DeletePerson(Person* person) {
    delete person;
}
 
void Person::set_name(char name[]) {
    strcpy(_person_name, name);
}
 
EXPORT
char* Person::name(void) {
    return _person_name;
}

__attribute__((constructor))
static void initializer1() {
	NSLog(@"我被加载了。。。。。");
}