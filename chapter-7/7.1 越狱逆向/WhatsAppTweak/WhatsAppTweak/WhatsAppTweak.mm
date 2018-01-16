#line 1 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-7/WhatsAppTweak/WhatsAppTweak/WhatsAppTweak.xm"


#import <UIKit/UIKit.h>
#import "CollectViewController.h"

static NSMutableArray* collectMessages = [NSMutableArray new];

@class WAChatCellData;
@class WAMessage;

@interface WAChatSessionViewController{
    WAChatCellData* _cellDataForMenuController;
}

@end

@interface WAChatCellData

@property (nonatomic, retain) WAMessage* message;

@end

@interface WAMessage

@property (nonatomic, copy) NSString* text;

@end


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

@class WASettingsViewController; @class UIMenuController; @class WAChatSessionViewController; 
static void (*_logos_orig$_ungrouped$UIMenuController$wa_reallyInstallItems)(_LOGOS_SELF_TYPE_NORMAL UIMenuController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UIMenuController$wa_reallyInstallItems(_LOGOS_SELF_TYPE_NORMAL UIMenuController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$WAChatSessionViewController$message_collect$(_LOGOS_SELF_TYPE_NORMAL WAChatSessionViewController* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$)(_LOGOS_SELF_TYPE_NORMAL WAChatSessionViewController* _LOGOS_SELF_CONST, SEL, SEL, id); static BOOL _logos_method$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$(_LOGOS_SELF_TYPE_NORMAL WAChatSessionViewController* _LOGOS_SELF_CONST, SEL, SEL, id); static NSInteger (*_logos_orig$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *); static NSInteger _logos_method$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *); static NSInteger (*_logos_orig$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static NSInteger _logos_method$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static UITableViewCell * (*_logos_orig$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static CGFloat (*_logos_orig$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static CGFloat _logos_method$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static BOOL (*_logos_orig$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static BOOL _logos_method$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static NSIndexPath * (*_logos_orig$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static NSIndexPath * _logos_method$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static NSString * (*_logos_orig$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static NSString * _logos_method$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static NSString * (*_logos_orig$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static NSString * _logos_method$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSInteger); static void (*_logos_orig$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void _logos_method$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); 

#line 29 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-7/WhatsAppTweak/WhatsAppTweak/WhatsAppTweak.xm"


static void _logos_method$_ungrouped$UIMenuController$wa_reallyInstallItems(_LOGOS_SELF_TYPE_NORMAL UIMenuController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<UIMenuController: %p> wa_reallyInstallItems]", self);
    _logos_orig$_ungrouped$UIMenuController$wa_reallyInstallItems(self, _cmd);
    NSMutableArray* menuItemArray = [NSMutableArray arrayWithArray:[self menuItems]];
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(message_collect:)];
    [menuItemArray addObject:menuItem];
    [self setMenuItems:menuItemArray];
}






static void _logos_method$_ungrouped$WAChatSessionViewController$message_collect$(_LOGOS_SELF_TYPE_NORMAL WAChatSessionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id data){
    WAChatCellData* cellData = MSHookIvar<WAChatCellData *>(self, "_cellDataForMenuController");
    WAMessage* message = [cellData message];
    NSString* text = [message text];
    if(text){
        NSLog(@"text is %@", text);
        if(![collectMessages containsObject:text]){
            [collectMessages addObject:text];
        }
    }
}

static BOOL _logos_method$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$(_LOGOS_SELF_TYPE_NORMAL WAChatSessionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SEL action, id sender){
    if(action == @selector(message_collect:)){
        return YES;
    }else{
        return _logos_orig$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$(self, _cmd, action, sender);
    }
}



@interface WASettingsViewController : UIViewController

@end



static NSInteger _logos_method$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView){
    return _logos_orig$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$(self, _cmd, tableView) + 1;
}

static NSInteger _logos_method$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSInteger section){
    if(section == 4){
        return 1;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$(self, _cmd, tableView, section);
}

static UITableViewCell * _logos_method$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){
    if(indexPath.section == 4 && indexPath.row == 0){
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"message_collect"];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"message_collect"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setBackgroundColor:[UIColor whiteColor]];
        }
        [[cell textLabel] setText:@"收藏的消息"];
        return cell;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$(self, _cmd, tableView, indexPath);
}

static CGFloat _logos_method$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){
    if(indexPath.section == 4 && indexPath.row == 0){
        return 50;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$(self, _cmd, tableView, indexPath);
}

static BOOL _logos_method$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){
    if(indexPath.section == 4 && indexPath.row == 0){
        return NO;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$(self, _cmd, tableView, indexPath);
}

static NSIndexPath * _logos_method$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){
    if(indexPath.section == 4 && indexPath.row == 0){
        return indexPath;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$(self, _cmd, tableView, indexPath);
}

static NSString * _logos_method$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSInteger section){
    if(section == 4){
        return @"";
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$(self, _cmd, tableView, section);
}

static NSString * _logos_method$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSInteger section){
    if(section == 4){
        return @"";
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$(self, _cmd, tableView, section);
}

static void _logos_method$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WASettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){
    if(indexPath.section == 4 && indexPath.row == 0){
        [self setHidesBottomBarWhenPushed:YES];
        CollectViewController* collectViewController = [CollectViewController new];
        [collectViewController setCollectMessages:collectMessages];
        [self.navigationController pushViewController:collectViewController animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        return;
    }
    return _logos_orig$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$(self, _cmd, tableView, indexPath);
}






static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIMenuController = objc_getClass("UIMenuController"); MSHookMessageEx(_logos_class$_ungrouped$UIMenuController, @selector(wa_reallyInstallItems), (IMP)&_logos_method$_ungrouped$UIMenuController$wa_reallyInstallItems, (IMP*)&_logos_orig$_ungrouped$UIMenuController$wa_reallyInstallItems);Class _logos_class$_ungrouped$WAChatSessionViewController = objc_getClass("WAChatSessionViewController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$WAChatSessionViewController, @selector(message_collect:), (IMP)&_logos_method$_ungrouped$WAChatSessionViewController$message_collect$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$WAChatSessionViewController, @selector(canPerformAction:withSender:), (IMP)&_logos_method$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$, (IMP*)&_logos_orig$_ungrouped$WAChatSessionViewController$canPerformAction$withSender$);Class _logos_class$_ungrouped$WASettingsViewController = objc_getClass("WASettingsViewController"); MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(numberOfSectionsInTableView:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$numberOfSectionsInTableView$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:numberOfRowsInSection:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$numberOfRowsInSection$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:heightForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$heightForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:canEditRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$canEditRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:willSelectRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$willSelectRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:titleForHeaderInSection:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$titleForHeaderInSection$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:titleForFooterInSection:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$titleForFooterInSection$);MSHookMessageEx(_logos_class$_ungrouped$WASettingsViewController, @selector(tableView:didSelectRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WASettingsViewController$tableView$didSelectRowAtIndexPath$);} }
#line 152 "/Users/monkey/Documents/iosreversebook/sourcecode/chapter-7/WhatsAppTweak/WhatsAppTweak/WhatsAppTweak.xm"
