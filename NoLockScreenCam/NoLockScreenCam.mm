
#import <Preferences/Preferences.h>

#import <spawn.h>
#import <objc/runtime.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <UIKit/UIKit.h>
/**
#import <notify.h>
#import <Social/Social.h>
#import <UIKit/UINavigationController>
**/

@interface NoLockScreenCamListController: PSListController {
}
@end
/*
@interface PSControlTableCell : PSTableCell
- (UIControl *)control;
@end
*/
@interface PSSwitchTableCell : PSControlTableCell
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier;
@end

@interface SRSwitchTableCell : PSSwitchTableCell
@end

@implementation SRSwitchTableCell

-(id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier { 
//init method

	self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier]; 
//call the super init method
	
if (self) {
		[((UISwitch *)[self control]) setOnTintColor:[UIColor redColor]]; 


	}
	return self;
}
@end

@implementation NoLockScreenCamListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"NoLockScreenCam" target:self];
	}
	return _specifiers;
}

- (void)twitterLink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/brianvs"]];
}

- (void)repoLink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://i0s-tweak3r-betas.yourepo.com"]];
} 

- (void)respring:(id)sender {
	pid_t pid;
    const char* args[] = {"killall", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

- (void)donate
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/i0stweak3r"]];
}



-(void)myOtherTweaks 
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apt.thebigboss.org/developer-packages.php?dev=i0stweak3r"]];
}

/***
- (void)love
{
	SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[twitter setInitialText:@"I'm using #NoLockscreenCam by @BrianVS New update hosted by @BigBoss compatible for all devices iOS 7-12. http://cydia.saurik.com/package/com.i0stweak3r.nolockscreencam/"];
	if (twitter != nil) {
		[[self navigationController] presentViewController:twitter animated:YES completion:nil];
	}
}

-(void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];
**/
/***
- (void) loadView
{
	[super loadView];


UIImage *heart = [[UIImage alloc] initWithContentsOfFile:[[self bundle] pathForResource:@"Heart" ofType:@"png"]];

UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
[button setBackgroundImage:heart forState:UIControlStateNormal];
[button addTarget:self action:@selector(love) forControlEvents:UIControlEventTouchUpInside];
button.adjustsImageWhenHighlighted = NO;

UIBarButtonItem *rightButton =[[UIBarButtonItem alloc] initWithCustomView:button];


    self.navigationItem.rightBarButtonItem = rightButton;
}
***/
@end

// vim:ft=objc
