//
//  Joueur.h
//  Tarot
//
//  Created by Aurélien SIGNE on 28/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Joueur : NSObject {
	NSString *nomJoueur;
	double scoreJoueur;
}
@property (nonatomic, assign) double scoreJoueur;
@property (nonatomic, retain) NSString* nomJoueur;

-(id) initWithNom: (NSString*) leNom;
-(void) modifierScore:(double) points;

@end

