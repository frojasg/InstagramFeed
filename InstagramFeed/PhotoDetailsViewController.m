//
//  PhotoDetailsViewController.m
//  InstagramFeed
//
//  Created by Chang Liu on 10/22/15.
//  Copyright © 2015 Francisco Rojas. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mainImageView setImageWithURL:self.instagramImageURL];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
