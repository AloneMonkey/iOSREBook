// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>

%hook Manager

+ (void)performLoginWithUsernameOrEmail:(id)arg1 password:(id)arg2 preAuthToken:(id)arg3 twoFAMethod:(int)arg4 confirmReactivation:(_Bool)arg5 rememberDevice:(_Bool)arg6 fromDeepLink:(_Bool)arg7 onComplete:(id)arg8{
    %log;
    %orig;
}

%end
