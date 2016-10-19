//
//  ViewController.m
//  MySnapDog
//
//  Created by ITE on 19/10/16.
//  Copyright © 2016 ITE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    float firstX;
    float firstY;
}

@end

@implementation ViewController

@synthesize imageView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getImage:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker
                       animated:YES
                     completion:NULL];

}


-(UIImage *)createImage:(UIImageView *)imgView
{
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:context];
    
    UIImage *imgs = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        UIImageWriteToSavedPhotosAlbum(imgs,
                                       self,
                                       @selector(image:didFinishSavingWithError:contextInfo:),
                                       nil);
    });
    
    return imgs;
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    
    //    UIAlertView *alertView;
    if(error)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Error occurred"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                       message:@"Your image has been saved successfully to your photo album"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}


- (IBAction)saveImage:(id)sender
{
    [self createImage:imageView];
}

- (IBAction)addDog:(id)sender
{
    // Add Left Ear image
    UIImageView *imgEarLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"DogEarLeft.png"]];
    [imageView addSubview:imgEarLeft];
    [imgEarLeft setUserInteractionEnabled:YES];

    // Add Right Ear image
    UIImageView *imgEarRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"DogEarRight.png"]];
    [imageView addSubview:imgEarRight];
    [imgEarRight setUserInteractionEnabled:YES];
    
    // Add Nose image
    UIImageView *imgNose = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"DogNose.png"]];
    [imageView addSubview:imgNose];
    [imgNose setUserInteractionEnabled:YES];
    
    // Add Tongue image
    UIImageView *imgTongue = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"DogTongue.png"]];
    [imageView addSubview:imgTongue];
    [imgTongue setUserInteractionEnabled:YES];
    
    
    
    [imageView setUserInteractionEnabled:YES];
    
    UIPanGestureRecognizer *panGesture2 = [[UIPanGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handlePanGesture:)];
    
    [panGesture2 setMinimumNumberOfTouches:1];
    [panGesture2 setMaximumNumberOfTouches:1];

    UIPanGestureRecognizer *panGesture3 = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handlePanGesture:)];
    [panGesture3 setMinimumNumberOfTouches:1];
    [panGesture3 setMaximumNumberOfTouches:1];
    
    UIPanGestureRecognizer *panGesture4 = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handlePanGesture:)];
    [panGesture4 setMinimumNumberOfTouches:1];
    [panGesture4 setMaximumNumberOfTouches:1];
    
    UIPanGestureRecognizer *panGesture5 = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handlePanGesture:)];
    [panGesture5 setMinimumNumberOfTouches:1];
    [panGesture5 setMaximumNumberOfTouches:1];

    
    
    [imgEarLeft addGestureRecognizer:panGesture2];
    [imgEarRight addGestureRecognizer:panGesture3];
    [imgNose addGestureRecognizer:panGesture4];
    [imgTongue addGestureRecognizer:panGesture5];
    
    
    
    panGesture2 = nil;
    panGesture3 = nil;
    panGesture4 = nil;
    panGesture5 = nil;
    
    
}


-(void) handlePanGesture: (id) sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer *) sender translationInView:self.view];
    
    if([(UIPanGestureRecognizer *) sender state] == UIGestureRecognizerStateBegan)
    {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }
    
    translatedPoint = CGPointMake(firstX + translatedPoint.x,
                                  firstY + translatedPoint.y);
    
    [[sender view] setCenter:translatedPoint];
}








@end
