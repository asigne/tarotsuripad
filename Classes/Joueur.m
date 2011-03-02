//
//  Joueur.m
//  Tarot
//
//  Created by Aurélien SIGNE on 28/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Joueur.h"


@implementation Joueur
@synthesize scoreJoueur;
@synthesize nomJoueur;

-(id) initWithNom: (NSString*) leNom
{
	if(self =[super init]){
		self.nomJoueur = leNom;
		self.scoreJoueur = 0.0;
	}
	return self;
}

-(void) dealloc{
	[nomJoueur release];
	[super dealloc];
}


-(void) modifierScore:(double) points{
	self.scoreJoueur = self.scoreJoueur+points;
}

@end
