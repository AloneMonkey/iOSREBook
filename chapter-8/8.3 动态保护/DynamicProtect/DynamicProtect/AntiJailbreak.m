//
//  SFAntiPiracy.m
//
//
//  Created by Nick Kramer on 3/3/13.
//
//

//https://github.com/Shmoopi/AntiPiracy/blob/master/SFAntiPiracy.m

#import "AntiJailbreak.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/stat.h>
#import <sys/sysctl.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>

#define NOTJAIL     4783242

enum {
    // Failed the Jailbreak Check
    KFJailbroken = 3429542,
    // Failed the OpenURL Check
    KFOpenURL = 321,
    // Failed the Cydia Check
    KFCydia = 432,
    // Failed the Inaccessible Files Check
    KFIFC = 47293,
    // Failed the plist check
    KFPlist = 9412,
    // Failed the Processes Check with Cydia
    KFProcessesCydia = 10012,
    // Failed the Processes Check with other Cydia
    KFProcessesOtherCydia = 42932,
    // Failed the Processes Check with other other Cydia
    KFProcessesOtherOCydia = 10013,
    // Failed the FSTab Check
    KFFSTab = 9620,
    // Failed the System() Check
    KFSystem = 47475,
    // Failed the Symbolic Link Check
    KFSymbolic = 34859,
    // Failed the File Exists Check
    KFFileExists = 6625,
} JailbrokenChecks;

// Define the filesystem check
#define FILECHECK [NSFileManager defaultManager] fileExistsAtPath:
// Define the exe path
#define EXEPATH [[NSBundle mainBundle] executablePath]
// Define the plist path
#define PLISTPATH [[NSBundle mainBundle] infoDictionary]

// Jailbreak Check Definitions
#define CYDIALOC        @"/Applications/Cydia.app"
#define HIDDENFILES     [NSArray arrayWithObjects:@"/Library/MobileSubstrate/MobileSubstrate.dylib", @"/Applications/RockApp.app",@"/Applications/Icy.app",@"/usr/sbin/sshd",@"/usr/bin/sshd",@"/usr/libexec/sftp-server",@"/Applications/WinterBoard.app",@"/Applications/SBSettings.app",@"/Applications/MxTube.app",@"/Applications/IntelliScreen.app",@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",@"/private/var/lib/apt",@"/private/var/stash",@"/System/Library/LaunchDaemons/com.ikey.bbot.plist",@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",@"/private/var/tmp/cydia.log",@"/private/var/lib/cydia", @"/etc/clutch.conf", @"/var/cache/clutch.plist", @"/etc/clutch_cracked.plist", @"/var/cache/clutch_cracked.plist", @"/var/lib/clutch/overdrive.dylib", @"/var/root/Documents/Cracked/", nil]

// Cydia Check
int cydiaCheck() {
    @try {
        // Create a file path string
        NSString *filePath = CYDIALOC;
        struct stat s;
        // Check if it exists
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            // It exists
            return KFCydia;
        } else if(!stat([filePath UTF8String], &s)){
            return KFCydia;
        }else {
            // It doesn't exist
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Inaccessible Files Check
int inaccessibleFilesCheck() {
    @try {
        // Run through the array of files
        for (NSString *key in HIDDENFILES) {
            struct stat s;
            // Check if any of the files exist (should return no)
            if ([[NSFileManager defaultManager] fileExistsAtPath:key]) {
                // Jailbroken
                return KFIFC;
            }else if(!stat([key UTF8String], &s)){
                return KFIFC;
            }
        }
        
        // Shouldn't get this far, return jailbroken
        return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Plist Check
int plistCheck() {
    @try {
        // Define the Executable name
        NSString *ExeName = EXEPATH;
        NSDictionary *ipl = PLISTPATH;
        // Check if the plist exists
        if ([FILECHECK ExeName] == FALSE || ipl == nil || ipl.count <= 0) {
            // Executable file can't be found and the plist can't be found...hmmm
            return KFPlist;
        } else {
            // Everything is good
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return NOTJAIL;
    }
}

// Symbolic Link available
int symbolicLinkCheck() {
    @try {
        // See if the Applications folder is a symbolic link
        struct stat s;
        if (lstat("/Applications", &s) != 0) {
            if (s.st_mode & S_IFLNK) {
                // Device is jailbroken
                return KFSymbolic;
            } else
                // Not jailbroken
                return NOTJAIL;
        } else {
            // Not jailbroken
            return NOTJAIL;
        }
    }
    @catch (NSException *exception) {
        // Not Jailbroken
        return NOTJAIL;
    }
}

// FileSystem working correctly?
int filesExistCheck() {
    @try {
        // Check if filemanager is working
        if (![FILECHECK [[NSBundle mainBundle] executablePath]]) {
            // Jailbroken and trying to hide it
            return KFFileExists;
        } else
            // Not Jailbroken
            return NOTJAIL;
    }
    @catch (NSException *exception) {
        // Not Jailbroken
        return NOTJAIL;
    }
}

bool isJailbreak(){
    // Is the device jailbroken?
#if TARGET_IPHONE_SIMULATOR
    // It's the developer
    return false;
#endif
    
    // Make an int to monitor how many checks are failed
    int motzart = 0;
    
    // Cydia Check
    if (cydiaCheck() != NOTJAIL) {
        // Jailbroken
        motzart += 3;
    }
    
    // Inaccessible Files Check
    if (inaccessibleFilesCheck() != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Plist Check
    if (plistCheck() != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Symbolic Link Check
    if (symbolicLinkCheck() != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // FilesExist Integrity Check
    if (filesExistCheck() != NOTJAIL) {
        // Jailbroken
        motzart += 2;
    }
    
    // Check if the Jailbreak Integer is 3 or more
    if (motzart >= 3) {
        // Jailbroken
        return 1;
    }
    return 0;
}
