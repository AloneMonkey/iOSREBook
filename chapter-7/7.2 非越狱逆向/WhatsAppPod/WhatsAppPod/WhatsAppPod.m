//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  WhatsAppPod.m
//  WhatsAppPod
//
//  Created by AloneMonkey on 2017/9/19.
//  Copyright (c) 2017年 AloneMonkey. All rights reserved.
//

#import "WhatsAppPod.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>

@class WAChatSession;

@interface WAMessage : NSObject

@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) NSString* fromJID;

@property (nonatomic, assign) int messageStatus;

@property (nonatomic, retain) WAChatSession *chatSession;

@end

@interface WAChatStorage : NSObject

- (void)sendMessageWithText:(NSString*) text metadata:(id)arg2 toChatSessions:(NSArray*) chatSessions hasTextFromURL:(_Bool)arg4;

@end

@interface WASharedAppData

+(WAChatStorage*)chatStorage;

@end

@interface WAChatDataStore

-(void)didUpdateMessage:(WAMessage*) message;

@end

CHDeclareClass(WAChatDataStore)

CHOptimizedMethod1(self, void, WAChatDataStore, didUpdateMessage, WAMessage*, message){
    
    NSString* text = [message text];
    
    text = [NSString stringWithFormat:@"you send: %@", text];
    
    NSString* fromJID = [message fromJID];
    
    int messageStatus = [message messageStatus];
    
    WAChatSession* chatSession = [message chatSession];
    
    WAChatStorage* storage = [(Class)objc_getClass("WASharedAppData") chatStorage];
    
    if(fromJID && chatSession && messageStatus == 10){
        [storage sendMessageWithText:text metadata:nil toChatSessions:@[chatSession] hasTextFromURL:NO];
    }
    
    CHSuper1(WAChatDataStore, didUpdateMessage, message);
    
}

CHConstructor{
    CHLoadLateClass(WAChatDataStore);
    CHClassHook1(WAChatDataStore, didUpdateMessage);
}

