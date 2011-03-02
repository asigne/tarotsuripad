    //
//  Accueil.m
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Accueil.h"


@implementation Accueil
@synthesize app;
@synthesize segmentedController;
@synthesize j1, j2, j3, j4, j5; 
@synthesize nomJ1, nomJ2, nomJ3, nomJ4, nomJ5;
@synthesize validerNoms;
@synthesize nbJoueurs;
@synthesize manager;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
	app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	[app setNbJoueursPartie:4];
	
	self.title = @"Tarot";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	//creation bouton segmentation
	segmentedController.selectedSegmentIndex = 0;
	[segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	[segmentedController release]; 
	
	manager = [[SQLManager alloc] initDatabase];
	
	//Voir si on garde les parametres
	[manager viderBase];
    
	[super viewDidLoad];
}

//action pour changer "d'onglet"
- (IBAction)segmentAction:(id)sender{
	segmentedController = (UISegmentedControl *)sender;
	if(segmentedController.selectedSegmentIndex == 0){
		j5.hidden=YES;
		nomJ5.hidden=YES;
		[app setNbJoueursPartie:4];
	}
	else if(segmentedController.selectedSegmentIndex == 1){
		j5.hidden=NO;
		nomJ5.hidden=NO;
		[app setNbJoueursPartie:5];		
	}
}

- (void) valider:(id)sender{
	NSInteger i;
	//if([app nbJoueursPartie] == 0){
		//creation tableau des joueurs avec noms et scores par défault
		for (i=0; i<[app nbJoueursPartie]; i++) {
			/*
			Joueur *joueurTemp=[[Joueur alloc] initWithNom:[NSString stringWithFormat:@"Joueur %d", i+1]];
			[[app joueurs] addObject:joueurTemp];
			[joueurTemp release];
			 */
			[manager ajouterJoueur:[NSString stringWithFormat:@"Joueur %d", i+1]:0];
	//	}
	}
	//[joueurs release];
	
	
	//[[[app joueurs] objectAtIndex:0] setNom:nomJ1.text];
	[manager setNomJoueur:nomJ1.text:0];
	//[[[app joueurs] objectAtIndex:1] setNom:nomJ2.text];
	[manager setNomJoueur:nomJ2.text:1];
	//[[[app joueurs] objectAtIndex:2] setNom:nomJ3.text];	
	[manager setNomJoueur:nomJ3.text:2];
	//[[[app joueurs] objectAtIndex:3] setNom:nomJ4.text];	
	[manager setNomJoueur:nomJ4.text:3];
	
	if([app nbJoueursPartie]==5){
		//[[[app joueurs] objectAtIndex:4] setNom:nomJ5.text];
		[manager setNomJoueur:nomJ5.text:4];
	}
	 
	 
	//a voir
	segmentedController.hidden = YES;
	
	Partie *partie = [[Partie alloc] init];
	[[app navController] pushViewController:partie animated:YES];
	[partie release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[manager release];
    [super dealloc];
}


@end
