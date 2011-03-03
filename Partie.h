//
//  Partie.h
//  TarotIpad
//
//  Created by Aurélien SIGNE on 15/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TarotIpadAppDelegate.h"

@class TarotIpadAppDelegate;
@class SQLManager;


@interface Partie : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDataSource> {
	UIPickerView *pickerView1;
	UIPickerView *pickerView2;
	UIPickerView *pickerView3;
	
	NSMutableArray *joueursArray;
	NSMutableArray *contratsArray;
	NSMutableArray *poigneesArray;
	NSMutableArray *chelemsArray;
	NSMutableArray *boutsArray;
	NSMutableArray *petitArray;

	UILabel *preneur, *contrat, *appele, *poignee, *chelem, *bouts, *petit;
	UILabel *preneurJ4, *contratJ4;

	UISwitch *switchChelem;
	UITextField *score;
	
	UIButton *btnValider;
	
	TarotIpadAppDelegate *app;
	SQLManager *manager;
	
	UITableView *tableScores;
	UITableView *tableParties;
}

@property (nonatomic, retain) IBOutlet UIPickerView* pickerView1;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerView2;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerView3;
@property (nonatomic, retain) IBOutlet UILabel *preneur, *contrat, *appele, *poignee, *chelem, *bouts, *petit;
@property (nonatomic, retain) IBOutlet UILabel *preneurJ4, *contratJ4;
@property (nonatomic, retain) IBOutlet UISwitch* switchChelem;
@property (nonatomic, retain) IBOutlet UITextField* score;
@property (nonatomic, retain) IBOutlet UIButton* btnValider;
@property (nonatomic, retain) TarotIpadAppDelegate *app;
@property (nonatomic, retain) SQLManager *manager;
@property (nonatomic, retain) IBOutlet UITableView *tableScores, *tableParties;

-(void) valider;
-(void) afficherScores;
-(void) retirerClavier:(id)sender;

@end
