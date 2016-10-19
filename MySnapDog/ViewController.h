//
//  ViewController.h
//  MySnapDog
//
//  Created by ITE on 19/10/16.
//  Copyright © 2016 ITE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)getImage:(id)sender;
- (IBAction)saveImage:(id)sender;
- (IBAction)addDog:(id)sender;
@end

