//
//  TarotIpadAppDelegate.h
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accueil.h"
#import "Joueur.h"

@interface TarotIpadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;	
	NSMutableArray *joueurs;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet UINavigationController *navController;
@property (nonatomic,retain) IBOutlet NSMutableArray *joueurs;


@end

