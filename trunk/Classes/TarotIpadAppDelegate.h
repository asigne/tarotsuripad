//
//  TarotIpadAppDelegate.h
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accueil.h"

@interface TarotIpadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;	
	//NSMutableArray *joueurs;
	NSInteger nbJoueursPartie;
	NSInteger nbParties;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet UINavigationController *navController;
//@property (nonatomic,retain) IBOutlet NSMutableArray *joueurs;
@property (nonatomic,assign) IBOutlet NSInteger nbJoueursPartie;
@property (nonatomic,assign) IBOutlet NSInteger nbParties;


@end

