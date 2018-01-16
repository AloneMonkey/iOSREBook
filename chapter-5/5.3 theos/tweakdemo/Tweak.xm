#import <BookLib/BookLib.h>
#import <BookFramework/BookFramework.h>

@class SCLoginV2ViewController;

@interface Manager

-(void)printMessage:(NSString*) message;

@end

%hook Manager

%new(v@:@)
-(void)printMessage:(NSString*) message{
    NSLog(@"[TestApp]: %@",message);
}

+ (void)performLoginWithUsernameOrEmail:(id)arg1 password:(id)arg2 preAuthToken:(id)arg3 twoFAMethod:(int)arg4 confirmReactivation:(_Bool)arg5 rememberDevice:(_Bool)arg6 fromDeepLink:(_Bool)arg7 onComplete:(id)arg8{
	SCLoginV2ViewController* loginVC = [[objc_getClass("SCLoginV2ViewController") alloc] init];
	NSLog(@"%@",loginVC);

	[[self new] printMessage:@"test new method"];

	NSString* resourcePath = @"/Library/Application Support/TweakDemo/";

	NSDictionary* resourceDict = [[NSDictionary alloc] initWithContentsOfFile:[resourcePath stringByAppendingPathComponent:@"resource.plist"]];

	NSLog(@"resourceDict:%@", resourceDict);

	BookLib* bookLib = [[BookLib alloc] init];
	[bookLib printLib];

	BookFramework* bookFramework = [[BookFramework alloc] init];
	[bookFramework printFramwork];

    %log;
    %orig;
}

%end