    //
//  Accueil.m
//  TarotIpad
//
//  Created by Aurélien SIGNE on 08/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Accueil.h"


@implementation Accueil
@synthesize segmentedController;
@synthesize j1, j2, j3, j4, j5; 
@synthesize nomJ1, nomJ2, nomJ3, nomJ4, nomJ5;
@synthesize validerNoms;

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
	nbJoueurs=4;
	self.title = @"Tarot";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	//creation bouton segmentation
	segmentedController.selectedSegmentIndex = 0;
	[segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	[segmentedController release]; 
	
	
    [super viewDidLoad];
}

//action pour changer "d'onglet"
- (IBAction)segmentAction:(id)sender{
	segmentedController = (UISegmentedControl *)sender;
	if(segmentedController.selectedSegmentIndex == 0){
		j5.hidden=YES;
		nomJ5.hidden=YES;
		nbJoueurs=4;
	}
	else if(segmentedController.selectedSegmentIndex == 1){
		j5.hidden=NO;
		nomJ5.hidden=NO;
		nbJoueurs=5;
		
	}
}

- (void) valider:(id)sender{
	TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if([[app joueurs] count] == 0){
		NSInteger i;
		//creation tableau des joueurs avec noms et scores par défault
		for (i=0; i<nbJoueurs; i++) {
			Joueur *joueurTemp=[[Joueur alloc] initWithNom:[NSString stringWithFormat:@"Joueur %d", i+1]];
			[[app joueurs] addObject:joueurTemp];
			[joueurTemp release];
		}
	}
	//[joueurs release];
	[[[app joueurs] objectAtIndex:0] setNom:nomJ1.text];	
	[[[app joueurs] objectAtIndex:1] setNom:nomJ2.text];	
	[[[app joueurs] objectAtIndex:2] setNom:nomJ3.text];	
	[[[app joueurs] objectAtIndex:3] setNom:nomJ4.text];	
	
	
	if(nbJoueurs==5){
		[[[app joueurs] objectAtIndex:4] setNom:nomJ5.text];		
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
    [super dealloc];
}


@end
