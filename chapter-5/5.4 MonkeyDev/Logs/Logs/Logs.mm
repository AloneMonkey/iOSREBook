#line 1 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-4/Logs/Logs/Logs.xm"


#import <UIKit/UIKit.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class Manager; 
static void (*_logos_meta_orig$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, int, _Bool, _Bool, _Bool, id); static void _logos_meta_method$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, int, _Bool, _Bool, _Bool, id); 

#line 5 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-4/Logs/Logs/Logs.xm"


static void _logos_meta_method$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, int arg4, _Bool arg5, _Bool arg6, _Bool arg7, id arg8){
    HBLogDebug(@"+[<Manager: %p> performLoginWithUsernameOrEmail:%@ password:%@ preAuthToken:%@ twoFAMethod:%d confirmReactivation:%d rememberDevice:%d fromDeepLink:%d onComplete:%@]", self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    _logos_meta_orig$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Manager = objc_getClass("Manager"); Class _logos_metaclass$_ungrouped$Manager = object_getClass(_logos_class$_ungrouped$Manager); MSHookMessageEx(_logos_metaclass$_ungrouped$Manager, @selector(performLoginWithUsernameOrEmail:password:preAuthToken:twoFAMethod:confirmReactivation:rememberDevice:fromDeepLink:onComplete:), (IMP)&_logos_meta_method$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$, (IMP*)&_logos_meta_orig$_ungrouped$Manager$performLoginWithUsernameOrEmail$password$preAuthToken$twoFAMethod$confirmReactivation$rememberDevice$fromDeepLink$onComplete$);} }
#line 13 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-4/Logs/Logs/Logs.xm"
