//
//  Accueil.h
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TarotIpadAppDelegate.h"
#import "Partie.h"


@interface Accueil : UIViewController {

	UISegmentedControl* segmentedController;
	UILabel *j1, *j2, *j3, *j4, *j5;  
	UITextField *nomJ1, *nomJ2, *nomJ3, *nomJ4, *nomJ5;
	UIButton *validerNoms;
	NSInteger nbJoueurs;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedController;
@property (nonatomic, retain) IBOutlet UILabel *j1, *j2, *j3, *j4, *j5; 
@property (nonatomic, retain) IBOutlet UITextField *nomJ1, *nomJ2, *nomJ3, *nomJ4, *nomJ5;
@property (nonatomic, retain) IBOutlet UIButton *validerNoms;
@property (nonatomic, assign) IBOutlet NSInteger nbJoueurs;

- (IBAction)segmentAction:(id)sender;
- (void) valider:(id)sender;
@end
