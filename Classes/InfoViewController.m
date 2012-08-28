//
//  InfoViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/8/10.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize infoView;

// Load the HTML file that has the info text
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"info1" ofType:@"html"];  
	NSData *htmlData = [NSData dataWithContentsOfFile:filePath];  
	if (htmlData) {  
		[infoView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];  
	}
}

// Support all portrait orientations
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
