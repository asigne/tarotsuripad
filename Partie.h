//
//  Partie.h
//  TarotIpad
//
//  Created by Aurélien SIGNE on 15/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TarotIpadAppDelegate.h"

@interface Partie : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *pickerView1;
	UIPickerView *pickerView2;
	UIPickerView *pickerView3;
	
	NSArray *joueursArray;
	NSArray *contratsArray;
	NSArray *poigneesArray;
	NSArray *chelemsArray;
	NSArray *boutsArray;
	NSArray *petitArray;

	UILabel *preneur, *contrat, *appele, *poignee, *chelem, *bouts, *petit;
	UILabel *preneurJ4, *contratJ4;

	UISwitch *switchChelem;
	UITextField *score;
	
	UIButton *valider;
	
	UILabel *nomJ1;
	UILabel *nomJ2;
	UILabel *nomJ3;
	UILabel *nomJ4;
	UILabel *nomJ5;
	
	UILabel *scoreJ1;
	UILabel *scoreJ2;
	UILabel *scoreJ3;
	UILabel *scoreJ4;
	UILabel *scoreJ5;
	
}

@property (nonatomic, retain) IBOutlet UIPickerView* pickerView1;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerView2;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerView3;
@property (nonatomic, retain) IBOutlet UILabel *preneur, *contrat, *appele, *poignee, *chelem, *bouts, *petit;
@property (nonatomic, retain) IBOutlet UILabel *preneurJ4, *contratJ4;
@property (nonatomic, retain) IBOutlet UISwitch* switchChelem;
@property (nonatomic, retain) IBOutlet UITextField* score;
@property (nonatomic, retain) IBOutlet UIButton* valider;

@property (nonatomic, retain) IBOutlet UILabel *nomJ1, *nomJ2, *nomJ3, *nomJ4, *nomJ5,
												*scoreJ1, *scoreJ2, *scoreJ3, *scoreJ4, *scoreJ5;

- (void) valider;
-(void) afficherScores;
-(void) retirerClavier:(id)sender;

@end
