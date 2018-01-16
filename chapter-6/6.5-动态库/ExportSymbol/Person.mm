#include "Person.h"
#include <string.h>

//#define EXPORT __attribute__((visibility("default")))

static char _person_name[30] = {'\0'};

void _set_name(char* name) {
   strcpy(_person_name, name);
}

// EXPORT
char* name(void) {
    return _person_name;
}

// EXPORT
void set_name(char* name) {
    if (name == NULL) {
        _set_name((char*)"");
    }
    else {
        _set_name(name);
    }
}