//class Person {
//    private:
//        char _person_name[30];
//    public:
//        Person();
//        virtual void set_name(char person_name[]);
//        virtual char* name();
//};
//
//// extern "C" Person *NewPerson(void);
//typedef Person *Person_creator(void);
//
//// extern "C" void DeletePerson(Person *person);
//typedef void Person_disposer(Person *);

@interface Person : NSObject
    
-(void)setName:(NSString*)name;
-(NSString*)name;

@end
