//
//  ViewController.m
//  InstagramFeed
//
//  Created by Francisco Rojas Gallegos on 10/22/15.
//  Copyright © 2015 Francisco Rojas. All rights reserved.
//

#import "PhotosViewController.h"
#import "ImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *images;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchPhotos {
    NSString *clientId = @"9f651fceb25a4b1ea6a460e97fe7a6f8";
    NSString *urlString =
    [@"https://api.instagram.com/v1/media/popular?client_id=" stringByAppendingString:clientId];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    self.images = responseDictionary[@"data"];
                                                    [self.tableView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.images count];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *image = self.images[indexPath.row];
//    return image[@"images"][@"thumbnail"][@"height"];
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    NSString *cellText = [NSString stringWithFormat: @"Section %ld Row: %ld", indexPath.section, indexPath.row];
    NSLog(@"%@", cellText);

    ImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"instagramCell"];
//    ImageTableViewCell *cell = [[ImageTableViewCell alloc] init];
    NSDictionary *image = self.images[indexPath.row];


    NSURL *imageUrl = [[NSURL alloc] initWithString: image[@"images"][@"standard_resolution"][@"url"]];
    NSLog(@"trying to load %@", image[@"images"][@"standard_resolution"][@"url"]);
    [cell.instagramImageView setImageWithURL:imageUrl];

    return cell;
}


@end
