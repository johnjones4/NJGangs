//
//  InfoViewController.h
//  NJ Gangs
//
//  Created by John Jones on 10/8/10.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController {
	UIWebView* infoView;
}

// UIWebView that displays the info text
@property (nonatomic,retain) IBOutlet UIWebView* infoView;

@end
