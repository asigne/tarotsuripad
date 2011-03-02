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
@synthesize preneurJ4, contratJ4;
@synthesize switchChelem;
@synthesize score;
@synthesize valider;
@synthesize app;
@synthesize manager;
@synthesize tableScores;
@synthesize tableParties;



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
	app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	manager = [[SQLManager alloc] initDatabase];
	
	tableScores = [[UITableView alloc] initWithFrame:CGRectZero];
	CGRect tableRectScore = CGRectMake(0.0, 690.0, 165.0, 220.0);
	tableScores.frame = tableRectScore;
	tableScores.dataSource = self;
	[self.view addSubview:tableScores];
	[tableScores release];
	
	tableParties = [[UITableView alloc] initWithFrame:CGRectZero];
	CGRect tableRectPartie = CGRectMake(168.0, 690.0, 600.0, 220.0);
	tableParties.frame = tableRectPartie;
	tableParties.dataSource = self;
	[self.view addSubview:tableParties];
	[tableParties release];
	
	
	if([app nbJoueursPartie] == 4){
		self.title = @"4 joueurs";
		preneur.hidden=YES;
		contrat.hidden=YES;
		appele.hidden=YES;
		preneurJ4.hidden=NO;
		contratJ4.hidden=NO;
	}
	if([app nbJoueursPartie] == 5){
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
	
	NSInteger i;
	
	
	//creation de la liste des contrats
	contratsArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[manager getNbLignes:@"CONTRAT"]; i++) {
		[contratsArray insertObject:(NSString *)[manager getLibelle:@"CONTRAT":i] atIndex:i];
	}
	
	//creation de la liste des joueurs
	joueursArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[app nbJoueursPartie]; i++) {
		//NSLog(@"%d",i);
		[joueursArray insertObject:(NSString *)[manager getNomJoueur:i] atIndex:i];
	}
	
	
	//creation de la liste des poignees
	poigneesArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[manager getNbLignes:@"POIGNEE"]; i++) {
		[poigneesArray insertObject:(NSString *)[manager getLibelle:@"POIGNEE":i] atIndex:i];
	}
	
	
	//creation de la liste des chelem
	chelemsArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[manager getNbLignes:@"CHELEM"]; i++) {
		[chelemsArray insertObject:(NSString *)[manager getLibelle:@"CHELEM":i] atIndex:i];
	}
	
	
	
	//creation de la liste des nb de bouts
	boutsArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[manager getNbLignes:@"BOUTS"]; i++) {
		[boutsArray insertObject:(NSString *)[manager getLibelle:@"BOUTS":i] atIndex:i];
	}
	
	
	//creation de la liste des petit au bout
	petitArray = [[NSMutableArray alloc] init];	
	for (i=0; i<[manager getNbLignes:@"PETIT"]; i++) {
		[petitArray insertObject:(NSString *)[manager getLibelle:@"PETIT":i] atIndex:i];
	}
	
	[self.view addSubview:pickerView1];
	[pickerView1 release];
	
	[self.view addSubview:pickerView2];
	[pickerView2 release];
	
	[self.view addSubview:pickerView3];
	[pickerView3 release];
	
	[self.tableScores reloadData];
	[self.tableParties reloadData];
	
    [super viewDidLoad];
}

- (void) valider{
	//TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
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
		if((scoreObtenu - scoreAObtenir)>=0){
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
				if((scoreObtenu - scoreAObtenir)>=0){
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
					if((scoreObtenu - scoreAObtenir)>=0){
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
		
		[app setNbParties:[app nbParties]+1];
		[manager nouvellePartie:[pickerView1 selectedRowInComponent:0] 
							   :[pickerView1 selectedRowInComponent:2] :[pickerView1 selectedRowInComponent:1] 
							   :[pickerView2 selectedRowInComponent:0] :[pickerView3 selectedRowInComponent:1]
							   :[pickerView2 selectedRowInComponent:1] :switchChelem.on
							   :scoreObtenu :[pickerView3 selectedRowInComponent:0]];
		
		scoreTotal = (scoreTotal+(scoreObtenu - scoreAObtenir))*coeffMulti+ primePoignee + primePetitAuBout + primeChelem;
		
		//mise a jour des scores de chaque joueur
		NSInteger i;
		for (i=0; i<[app nbJoueursPartie]; i++) {
			if(i == [pickerView1 selectedRowInComponent:0]){
				if(i == [pickerView1 selectedRowInComponent:2]){
					//preneur et appelé
					//[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*4)];
					[manager setScoreJoueur:(scoreTotal*4):i];
				}
				else{
					//preneur seul
					//[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*2)];
					[manager setScoreJoueur:(scoreTotal*2):i];

				}
			}
			else if(i == [pickerView1 selectedRowInComponent:2]){
				//appele
				//[[[app joueurs] objectAtIndex:i] modifierScore:scoreTotal];
				[manager setScoreJoueur:scoreTotal:i];

			}
			else{
				//joueurs de la défense
				//[[[app joueurs] objectAtIndex:i] modifierScore:-scoreTotal];
				[manager setScoreJoueur:(-scoreTotal):i];

			}
		}
	}
	[self afficherScores];
}

-(void) afficherScores{
	//TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	/*nomJ1.text = [[[app joueurs] objectAtIndex:0] nomJoueur];
	nomJ2.text = [[[app joueurs] objectAtIndex:1] nomJoueur];
	nomJ3.text = [[[app joueurs] objectAtIndex:2] nomJoueur];
	nomJ4.text = [[[app joueurs] objectAtIndex:3] nomJoueur];
	
	scoreJ1.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:0] scoreJoueur]];
	scoreJ2.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:1] scoreJoueur]];
	scoreJ3.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:2] scoreJoueur]];
	scoreJ4.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:3] scoreJoueur]];
	scoreJ3.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:2] scoreJoueur]];


	if([[app joueurs] count] == 5){
		nomJ5.text = [[[app joueurs] objectAtIndex:4] nomJoueur];
		scoreJ5.text = [NSString stringWithFormat:@"%.1f",[[[app joueurs] objectAtIndex:4] scoreJoueur]];
	}	
	else{
		nomJ5.hidden=YES;
		scoreJ5.hidden=YES;
	}
	*/
	[self.tableScores reloadData];
	[self.tableParties reloadData];
	
//	[self.tableParties scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	NSInteger nbComponents = 0;
	if(pickerView == pickerView1){
		TarotIpadAppDelegate *app = (TarotIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
		if([app nbJoueursPartie] == 4){
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



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(tableView == tableScores){
		return 1;
	}
	else if(tableView == tableParties){
		return 1;
	}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if(tableView == tableScores){
		return [app nbJoueursPartie];
	}
	else if(tableView == tableParties){
		return [app nbParties];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if(tableView == tableScores){
		[manager affichageScoreDepuisLaBase];
		Score *score = [manager.scores objectAtIndex:indexPath.row];
		cell.textLabel.text =  score.nom;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", score.points];
		//[NSString stringWithFormat:@"%d",score.resultat];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	else if(tableView == tableParties){
		[manager affichagePartieJoueeDepuisLaBase];
		if([[manager partiesJouees] count] > 0){
			PartieJouee *partieJouee = [manager.partiesJouees objectAtIndex:indexPath.row];
			/*cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@ %d", partieJouee.preneurPartie,
								   partieJouee.contratPartie,
								   partieJouee.appelePartie,
								   partieJouee.poigneePartie,
								   partieJouee.chelemAPartie,
								   partieJouee.boutsPartie,
								   partieJouee.petitPartie,
								   partieJouee.chelemRPartie,
								   partieJouee.scorePartie];*/
			cell.textLabel.text = [NSString stringWithFormat:@"Partie %d :      %@     %@     %@", partieJouee.idPartie, partieJouee.preneurPartie,
								   partieJouee.contratPartie,
								   partieJouee.appelePartie];
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %d", partieJouee.boutsPartie, partieJouee.scorePartie];
			//[NSString stringWithFormat:@"%d",score.resultat];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
	}
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      //  [manager deleteFromDatabase:[manager.scores objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
}*/




@end
