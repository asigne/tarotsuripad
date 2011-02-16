    //
//  Partie.m
//  TarotIpad
//
//  Created by Aurélien SIGNE on 15/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Partie.h"

@implementation Partie
@synthesize pickerView1;
@synthesize pickerView2;
@synthesize pickerView3;
@synthesize preneur, contrat, appele, poignee, chelem, bouts, petit;
@synthesize switchChelem;
@synthesize score;
@synthesize valider;

@synthesize nomJ1, nomJ2, nomJ3, nomJ4, nomJ5,
scoreJ1, scoreJ2, scoreJ3, scoreJ4, scoreJ5;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];

	if([[app joueurs] count] == 4){
		self.title = @"4 joueurs";
		preneur.hidden=YES;
		contrat.hidden=YES;
		appele.hidden=YES;
		preneurJ4.hidden=NO;
		contratJ4.hidden=NO;
	}
	if([[app joueurs] count] == 5){
		self.title = @"5 joueurs";
		preneur.hidden=NO;
		contrat.hidden=NO;
		appele.hidden=NO;
		preneurJ4.hidden=YES;
		contratJ4.hidden=YES;
	}
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	switchChelem.on = NO;
	
	pickerView1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGRect pickerRect1 = CGRectMake(0.0, 50.0, 495.0, 216.0);
	pickerView1.frame = pickerRect1;
    pickerView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerView1.showsSelectionIndicator = YES; // Par défaut, non
	pickerView1.delegate = self;
    pickerView1.dataSource = self;
	
	pickerView2 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGRect pickerRect2 = CGRectMake(480.0, 50.0, 287.0, 216.0);
	pickerView2.frame = pickerRect2;
    pickerView2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerView2.showsSelectionIndicator = YES; // Par défaut, non
	pickerView2.delegate = self;
    pickerView2.dataSource = self;
	
	pickerView3 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGRect pickerRect3 = CGRectMake(0.0, 345.0, 287.0, 216.0);
	pickerView3.frame = pickerRect3;
    pickerView3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerView3.showsSelectionIndicator = YES; // Par défaut, non
	pickerView3.delegate = self;
    pickerView3.dataSource = self;
	
	//creation de la liste des contrats
	contratsArray = [[NSArray alloc] initWithObjects:
					 @"Petite",@"Garde",@"Garde sans",@"Garde Contre",nil];
	
	//creation de la liste des joueurs
	joueursArray = [[NSMutableArray alloc] init];	
	NSInteger i;
	for (i=0; i<[[app joueurs] count]; i++) {
		[joueursArray insertObject:(NSString*)[[app.joueurs objectAtIndex:i] nom]atIndex:i];
	}
	
	
	//creation de la liste des poignees
	//if([[app joueurs] count] == 4){
		poigneesArray = [[NSArray alloc] initWithObjects:
						 @"Aucune",@"Simple (10)",@"Double (13)",@"Triple (15)",nil];
	//}
	//else if([[app joueurs] count] == 5){
		poigneesArray = [[NSArray alloc] initWithObjects:
						 @"Aucune",@"Simple (8)",@"Double (10)",@"Triple (13)",nil];
	//}
	
	//creation de la liste des chelem
	chelemsArray = [[NSArray alloc] initWithObjects:
					@"Non annoncé",@"Attaque",@"Défense",nil];
		
	//creation de la liste des nb de bouts
	boutsArray = [[NSArray alloc] initWithObjects:
					@"Aucun",@"1 bout",@"2 bouts",@"3 bouts",nil];
	
	//creation de la liste des petit au bout
	petitArray = [[NSArray alloc] initWithObjects:
						@"Personne",@"Attaque",@"Défense",nil];
	
	
	
	[self.view addSubview:pickerView1];
	[pickerView1 release];
	
	[self.view addSubview:pickerView2];
	[pickerView2 release];
	
	[self.view addSubview:pickerView3];
	[pickerView3 release];
	
	[self afficherScores];

    [super viewDidLoad];
}

- (void) valider{
	TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	//NSInteger monScore = [score.text intValue];
	if([score.text isEqualToString:@"Score de l'attaque"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Le score saisi est invalide !"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else{
		//initialisation des variables à 0
		NSInteger scoreAObtenir = 0;
		NSInteger coeffMulti = 0;
		NSInteger primeChelem = 0;
		NSInteger primePetitAuBout = 0;
		NSInteger primePoignee = 0;
		NSInteger scoreTotal = 0;
		
		//recuperation du score saisi
		NSInteger scoreObtenu = [score.text integerValue];
		
		//determination du score a obtenir en fonction du nombre de bouts
		switch ([pickerView3 selectedRowInComponent:0]) {
			case 0://aucun bout
				scoreAObtenir=56;
				break;
			case 1://1 bout
				scoreAObtenir=51;
				break;
			case 2://2 bouts
				scoreAObtenir=41;
				break;
			case 3://3 bouts
				scoreAObtenir=36;
				break;
			default:
				break;
		}
		
		//determination de 25 ou -25
		if((scoreObtenu - scoreAObtenir)>0){
			//attaque gagne
			scoreTotal = 25;
		}
		else {
			//attaque perd
			scoreTotal = -25;
		}
		
		//determination du coeff multiplicateur en fonction du contrat
		switch ([pickerView1 selectedRowInComponent:1]) {
			case 0://petite
				coeffMulti=1;
				break;
			case 1://garde
				coeffMulti=2;
				break;
			case 2://garde sans
				coeffMulti=4;
				break;
			case 3://garde contre
				coeffMulti=6;
				break;
			default:
				break;
		}
		
		//determination de la prime pour le petit au bout
		switch ([pickerView3 selectedRowInComponent:1]){
			case 0:
				//personne
				break;
			case 1:
				//dernier pli pour l'attaque
				primePetitAuBout = 10*coeffMulti;
				break;
			case 2:
				//dernier pli pour la défense
				if((scoreObtenu - scoreAObtenir)>0){
					//attaque gagne
					primePetitAuBout = -10*coeffMulti;
				}
				else {
					//attaque perd
					primePetitAuBout = 10*coeffMulti;
				}
				break;
			default:
				break;
		}
		
		//determination de la prime pour le chelem
		switch ([pickerView2 selectedRowInComponent:1]) {
			case 0:
				//aucun
				if(switchChelem.on){
					//aucun chelem annoncé
					if((scoreObtenu - scoreAObtenir)>0){
						//si chelem réussi pour l'attaque
						primeChelem=200;
					}
					else {
						//si chelem réussi pour la défense
						primeChelem=-200;
					}
				}
				else {
					primeChelem=0;
				}
				break;
			case 1:
				//chelem attaque
				if(switchChelem.on){
					//si chelem reussi par l'attaque
					primeChelem=400;
				}
				else {
					//si chelem raté par l'attaque
					primeChelem=-200;
				}
				break;
			case 2:
				//chelem defense
				if(switchChelem.on){
					//si chelem reussi par la defense
					primeChelem=-400;
				}
				else {
					//si chelem raté par la defense
					primeChelem=200;
				}
				break;
			default:
				break;
		}
		
		/*if(chelem.on){
			[app setChelemRealise:YES];
		}
		else{
			[app setChelemRealise:NO];
		}*/
		
		//determination de la prime pour la poignée
		switch ([pickerView2 selectedRowInComponent:0]){
			case 1:
				//Simple attaque
				primePoignee = 20;
				break;
			case 2:
				//Double attaque
				primePoignee = 30;
				break;
			case 3:
				//Triple attaque
				primePoignee = 40;
				break;
			default:
				break;
		}
		if((scoreObtenu - scoreAObtenir)<0){
			//dans le cas d'une victoire de la défense 	
			primePoignee = -primePoignee;
		}
		
		//score calcule pour le preneur (attaque)
		/*scoreTotal =	+ ou - 25 
		 + (difference entre le score obtenu et le score à obtenir) * le coeff multiplicateur
		 + prime de la poignee
		 + prime du petit au bout
		 + prime du chelem
		 */
		scoreTotal = (scoreTotal+(scoreObtenu - scoreAObtenir))*coeffMulti+ primePoignee + primePetitAuBout + primeChelem;
		
		//mise a jour des scores de chaque joueur
		NSInteger i;
		/*if(![app typePartage]){
			for (i=0; i<[[app joueurs] count]; i++) {
				if([[app joueurs] objectAtIndex:i] == [app preneur] || 
				   [[app joueurs] objectAtIndex:i] == [[app joueurs] objectAtIndex:[monPickerView selectedRowInComponent:1]]){
					//preneur ou appelé
					if([[app joueurs] objectAtIndex:i] == [app preneur] && 
					   [[app joueurs] objectAtIndex:i] == [[app joueurs] objectAtIndex:[monPickerView selectedRowInComponent:1]]){
						//preneur et appelé
						[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*4)];
					}
					else{
						[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*1.5)];
					}
				}
				else{
					//joueurs de la défense
					[[[app joueurs] objectAtIndex:i] modifierScore:-scoreTotal];
				}
			}
		}
		else{*/
			for (i=0; i<[[app joueurs] count]; i++) {
				if(i == [pickerView1 selectedRowInComponent:0]){
					if(i == [pickerView1 selectedRowInComponent:2]){
						//preneur et appelé
						[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*4)];
					}
					else{
						//preneur seul
						[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*2)];
					}
				}
				else if(i == [pickerView1 selectedRowInComponent:2]){
					//appele
					[[[app joueurs] objectAtIndex:i] modifierScore:scoreTotal];
				}
				else{
					//joueurs de la défense
					[[[app joueurs] objectAtIndex:i] modifierScore:-scoreTotal];
				}
			}
		//}
		//app.nouvellePartie=YES;
		
		//Recapitulatif *recapitulatif = [[Recapitulatif alloc] init];//WithNibName:@"affichageScores" bundle:nil];
		//[self.navigationController pushViewController:recapitulatif animated:YES];
		//[recapitulatif release];
	}
	[self afficherScores];
}

-(void) afficherScores{
	TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	nomJ1.text = [[[app joueurs] objectAtIndex:0] nom];
	nomJ2.text = [[[app joueurs] objectAtIndex:1] nom];
	nomJ3.text = [[[app joueurs] objectAtIndex:2] nom];
	nomJ4.text = [[[app joueurs] objectAtIndex:3] nom];
	
	scoreJ1.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:0] score]];
	scoreJ2.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:1] score]];
	scoreJ3.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:2] score]];
	scoreJ4.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:3] score]];
	scoreJ3.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:2] score]];

	if([[app joueurs] count] == 5){
		nomJ5.text = [[[app joueurs] objectAtIndex:4] nom];
		scoreJ5.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:4] score]];
	}	
	else{
		nomJ5.hidden=YES;
		scoreJ5.hidden=YES;
	}
}

//retirer la clavier apres avoir ecrit le score
-(void) retirerClavier:(id)sender{
	NSInteger monScore = [score.text intValue];
	if(monScore < 0 || monScore > 91 || [score.text isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Le score saisi est invalide !"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else{
		[self valider];
		[score resignFirstResponder];	
	}
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



#pragma mark -
#pragma mark UIPickerViewDelegate
/*- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 
 Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
 self.contrat = [NSString stringWithFormat:@"%@",
 [contratsArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
 
 preneur = [app.joueurs objectAtIndex:[pickerView selectedRowInComponent:0]];
 }*/

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *returnStr = @"";
	if(pickerView == pickerView1){
		if (component == 0)
			returnStr = [joueursArray objectAtIndex:row];
		else if (component == 1)
			returnStr = [contratsArray objectAtIndex:row];
		else if (component == 2)
			returnStr = [joueursArray objectAtIndex:row];
	}
	else if(pickerView == pickerView2){
		if (component == 0)
			returnStr = [poigneesArray objectAtIndex:row];
		else if (component == 1)
			returnStr = [chelemsArray objectAtIndex:row];
	}
	else if(pickerView == pickerView3){
		if (component == 0)
			returnStr = [boutsArray objectAtIndex:row];
		else if (component == 1)
			returnStr = [petitArray objectAtIndex:row];
	}
    return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat componentWidth = 0.0;
    if(pickerView == pickerView1){
		if (component == 0)
			componentWidth = 160.0;
		else if (component == 1)
			componentWidth = 160.0;	
		else if (component == 2)
			componentWidth = 160.0;
	}
	else if(pickerView == pickerView2){
		if (component == 0)
			componentWidth = 136.0;
		else if (component == 1)
			componentWidth = 136.0;
	}
	else if(pickerView == pickerView3){
		if (component == 0)
			componentWidth = 136.0;
		else if (component == 1)
			componentWidth = 136.0;
	}
    return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger nbLignes = 0;
	if(pickerView == pickerView1){
		if(component==0)
			nbLignes = [joueursArray count];
		else if(component==1)
			nbLignes = [contratsArray count];	
		else if(component==2)
			nbLignes = [joueursArray count];
	}
	else if(pickerView == pickerView2){
		if(component==0)
			nbLignes = [poigneesArray count];
		else if(component==1)
			nbLignes = [chelemsArray count];
	}
	else if(pickerView == pickerView3){
		if(component==0)
			nbLignes = [boutsArray count];
		else if(component==1)
			nbLignes = [petitArray count];
	}
	return nbLignes;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	NSInteger nbComponents = 0;
	if(pickerView == pickerView1){
		TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
		if([[app joueurs] count] == 4){
			nbComponents = 2;
		}
		else{
			nbComponents = 3;
		}
	}
	else if(pickerView == pickerView2)
		nbComponents = 2;
	else if(pickerView == pickerView3)
		nbComponents = 2;
	return nbComponents;
}



@end
