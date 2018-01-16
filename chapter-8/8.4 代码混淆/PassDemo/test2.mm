#include <stdio.h>
int add(int x, int y) {
    for (int i = 0; i < 10; i++) {
        printf("%d\n",i);
    }
    return x + y;
}
int main(){
    printf("%d",add(3,4));
    return 0;
}
