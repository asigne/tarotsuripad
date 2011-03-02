//
//  TarotIpadAppDelegate.m
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TarotIpadAppDelegate.h"

@implementation TarotIpadAppDelegate

@synthesize window;
@synthesize navController;
//@synthesize joueurs;
@synthesize nbJoueursPartie;
@synthesize nbParties;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	
    navController = [[UINavigationController alloc] init];
	[window addSubview:navController.view];	
	
	//joueurs = [[NSMutableArray alloc] init];//WithCapacity:nbJoueurs];
	nbJoueursPartie=0;
	nbParties=0;
	
	Accueil *accueil = [[Accueil alloc] init];
	[navController pushViewController:accueil animated:NO];
	[accueil release];
	[window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[navController release];
    [super dealloc];
}


@end
