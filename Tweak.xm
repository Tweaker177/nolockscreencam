/**
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.nolockscreencam.plist"
**/
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <UIKit/UIKit.h>

static bool kEnabled = YES;
static bool kCCRemove = YES;
static bool kRemoveButtonX = YES;


@interface SBDashBoardQuickActionsButton : UIView
@property(nonatomic, assign, readwrite)NSInteger type;
//-(id)statisticsIdentifierForType @“flashlight”

-(id)initWithType:(NSInteger)type;
@end

%hook SBDashBoardQuickActionsButton
-(id)initWithType:(NSInteger)type {
SBDashBoardQuickActionsButton *cameraButton = %orig;

if((kEnabled && kRemoveButtonX) && (self.type == 0)) {
cameraButton.hidden= YES;
[cameraButton setHidden: YES];


return cameraButton;
}
else {
return cameraButton; }
}
%end

%hook SBPolicyAggregator
-(bool) _allowsCapabilityLockScreenCameraSupportedWithExplanation:(id*)arg1 {
if(kEnabled) {
%orig;
return FALSE;
}
return %orig;
}
-(bool) _allowsCapabilityLockScreenCameraWithExplanation:(id*)arg1 {
if(kEnabled) {
%orig;
return FALSE;

}
return %orig;
}

%end


%hook SBLockScreenTestPluginSettings
-(bool) restrictCamera {
if(kEnabled) {
return TRUE;
}
return %orig;
}

-(BOOL) showCamera {
if(kEnabled) {
return FALSE;
}
return %orig;
} //ios 9

-(void) setShowCamera:(BOOL)arg1 {
if(kEnabled) {
arg1=FALSE;
return %orig(arg1);
}
return %orig;
} //ios 7

%end

%hook SBCCCameraShortcut
-(bool) isRestricted {
if(kCCRemove && kEnabled) {
return TRUE;
}
return %orig;
}
%end

%hook CCUICameraShortcut
-(bool) isRestricted {
if(kCCRemove && kEnabled) {
return TRUE;
}
return %orig;
}
%end

%hook SpringBoard
-(BOOL)canShowLockScreenCameraGrabber {
if(kEnabled) {
return FALSE;
}
return %orig;
}

//ios 9
-(bool) lockScreenCameraSupported {
if(kEnabled) {
return FALSE;
}
return %orig;
}
%end

%hook SBAwayViewPluginController
-(BOOL) allowsLockScreenCamera {
if(kEnabled) {
return FALSE;
}
return %orig;
} //ios 8 

%end

//ios 7

%hook SBLockScreenCameraController
-(id) grabberView {
if(kEnabled) {
return nil;
}
return %orig;
} //ios 7

-(void) _activateCameraWithNewSessionID:(BOOL)arg1 afterCall:(BOOL)arg2 {
if(kEnabled) {
arg1= NO; 
arg2=NO;
return %orig(arg1,arg2);
}
return %orig;
}

-(void) presentCameraAnimated:(BOOL)arg1 {
if(kEnabled) {
arg1= NO;
return %orig(arg1);
}
return %orig;
}
-(void)setGrabberOnLockScreen:(id)arg1 {
if(kEnabled) {
arg1=nil;
return %orig;
}
return %orig;
}
%end //ios 7

%hook SBLockScreenView
-(void)setCameraGrabberHidden:(bool)arg1 forRequester:(id)arg2 {

if(kEnabled) {
arg1=TRUE; //was false
return %orig;
}
return %orig;
}

-(bool) isCameraGrabberHidden {

if(kEnabled) {
return YES;
}
return %orig;
}

-(id)cameraGrabberView {
if(kEnabled) {
return nil;
}
return %orig;
}
%end  //ios 9

static void
loadPrefs() {
    static NSUserDefaults *prefs = [[NSUserDefaults alloc]
                                    initWithSuiteName:@"com.i0stweak3r.nolockscreencam"];
    
    kEnabled = [prefs boolForKey:@"key1"];
    kCCRemove= [prefs boolForKey:@"key2"];
    kRemoveButtonX = [prefs boolForKey:@"key3"];
}

%ctor {
    CFNotificationCenterAddObserver(
                                    CFNotificationCenterGetDarwinNotifyCenter(), NULL,
                                    (CFNotificationCallback)loadPrefs,
                                    CFSTR("com.i0stweak3r.nolockscreencam-prefsReload"), NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPrefs();
}
