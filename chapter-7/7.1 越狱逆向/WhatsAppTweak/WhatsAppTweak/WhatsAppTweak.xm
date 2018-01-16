// See http://iphonedevwiki.net/index.php/Logos

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

%hook UIMenuController

-(void)wa_reallyInstallItems{
    %log;
    %orig;
    NSMutableArray* menuItemArray = [NSMutableArray arrayWithArray:[self menuItems]];
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(message_collect:)];
    [menuItemArray addObject:menuItem];
    [self setMenuItems:menuItemArray];
}

%end

%hook WAChatSessionViewController

%new
-(void)message_collect:(id) data{
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

-(BOOL)canPerformAction:(SEL) action withSender:(id) sender{
    if(action == @selector(message_collect:)){
        return YES;
    }else{
        return %orig;
    }
}

%end

@interface WASettingsViewController : UIViewController

@end

%hook WASettingsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return %orig + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 4){
        return 1;
    }
    return %orig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    return %orig;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 4 && indexPath.row == 0){
        return 50;
    }
    return %orig;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 4 && indexPath.row == 0){
        return NO;
    }
    return %orig;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 4 && indexPath.row == 0){
        return indexPath;
    }
    return %orig;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 4){
        return @"";
    }
    return %orig;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 4){
        return @"";
    }
    return %orig;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 4 && indexPath.row == 0){
        [self setHidesBottomBarWhenPushed:YES];
        CollectViewController* collectViewController = [CollectViewController new];
        [collectViewController setCollectMessages:collectMessages];
        [self.navigationController pushViewController:collectViewController animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        return;
    }
    return %orig;
}

%end




