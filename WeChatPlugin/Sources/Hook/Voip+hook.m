//
//  Voip+hoot.m
//  WeChatPlugin
//
//  Created by jsb-xiakj on 2017/10/25.
//  Copyright © 2017年 tk. All rights reserved.
//

#import "Voip+hook.h"
#import "WeChatPlugin.h"
#import "XMLReader.h"
#import "TKAutoReplyWindowController.h"
#import "TKRemoteControlWindowController.h"
#import "TKIgnoreSessonModel.h"

@implementation NSObject(VoipHook)
+ (void)hookVoip {
    //视频聊天
    tk_hookMethod(objc_getClass("MMVoipReceiverWindowController"), @selector(loadContent), [self class], @selector(hook_loadContent));
    tk_hookMethod(objc_getClass("MMVoipReceiverWindowController"), @selector(showWindowAnimated:), [self class], @selector(hook_showWindowAnimated:));
    tk_hookMethod(objc_getClass("MMVoipBaseWindowController"), @selector(playSound:OfType:numberOfLoops:), [self class], @selector(hook_playSound:OfType:numberOfLoops:));
}

/**
 视频语音聊天
 */


- (void)hook_playSound:(id)arg1 OfType:(id)arg2 numberOfLoops:(long long)arg3
{
    NSString *currentUserName = [objc_getClass("CUtility") GetCurrentUserName];
    NSLog(@"####hook_playSound:%@,type=%@",arg1,arg2);
    if (![currentUserName isEqualToString: @"xhjy100fen"])
    {
        [self hook_playSound:arg1 OfType:arg2 numberOfLoops:arg3];
    }
}

- (void)hook_loadContent
{
    [self hook_loadContent];

    if ([[TKWeChatPluginConfig sharedConfig] autoOpenCameraEnable])
    {
        [self performSelector:@selector(acceptVoipInvite)
                   withObject:nil
                   afterDelay:0.1];
        NSLog(@"####hook_showWindowAnimated");
       // [self performSelectorInBackground:@selector(acceptVoipInvite) withObject:nil];
    }
    NSLog([[TKWeChatPluginConfig sharedConfig] autoOpenCameraEnable]?@"####hook_xxxxxxxx":@"#######hook_---------");
    //[self performSelectorInBackground:@selector(setAudioDeviceMute) withObject:nil];
}

- (void)hook_showWindowAnimated:(BOOL)arg1
{
    [self hook_showWindowAnimated:arg1];
    //[self performSelectorInBackground:@selector(closeWindowAnimated:) withObject:@NO];
    NSLog(@"####hook_showWindowAnimated");
}

@end
