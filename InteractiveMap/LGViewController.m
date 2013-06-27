//
//  LGViewController.m
//  InteractiveMap
//
//  Created by Mass Defect on 6/26/13.
//  Copyright (c) 2013 Lonny Gomes. All rights reserved.
//

#import "LGViewController.h"
#import <Mapbox/RMInteractiveSource.h>

#define MAP_NAME @"geography-class"

@interface LGViewController ()
@property (nonatomic, strong) RMMapView *mapView;
@end

@implementation LGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    RMMBTilesSource *offlineSource = [[RMMBTilesSource alloc] initWithTileSetResource:MAP_NAME ofType:@"mbtiles"];
    
    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:offlineSource];
    
    self.mapView.delegate = self;
    
    self.mapView.zoom = 2;
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.mapView.adjustTilesForRetinaDisplay = YES; // these tiles aren't designed specifically for retina, so make them legible
    
    [self.view addSubview:self.mapView];

}

- (void)singleTapOnMap:(RMMapView *)mapView at:(CGPoint)point
{
    [mapView removeAllAnnotations];
    
    RMMBTilesSource *source = (RMMBTilesSource *)mapView.tileSource;
    
    if ([source conformsToProtocol:@protocol(RMInteractiveSource)] && [source supportsInteractivity])
    {
        NSString *formattedOutput = [source formattedOutputOfType:RMInteractiveSourceOutputTypeTeaser
                                                         forPoint:point
                                                        inMapView:mapView];
        NSLog(@"Output:%@", formattedOutput);
//        if (formattedOutput && [formattedOutput length])
//        {
//            // parse the country name out of the content
//            //
//            NSUInteger startOfCountryName = [formattedOutput rangeOfString:@"<strong>"].location + [@"<strong>" length];
//            NSUInteger endOfCountryName   = [formattedOutput rangeOfString:@"</strong>"].location;
//            
//            NSString *countryName = [formattedOutput substringWithRange:NSMakeRange(startOfCountryName, endOfCountryName - startOfCountryName)];
//            
//            // parse the flag image out of the content
//            //
//            NSUInteger startOfFlagImage = [formattedOutput rangeOfString:@"base64,"].location + [@"base64," length];
//            NSUInteger endOfFlagImage   = [formattedOutput rangeOfString:@"\" style"].location;
//            
//            UIImage *flagImage = [UIImage imageWithData:[NSData dataFromBase64String:[formattedOutput substringWithRange:NSMakeRange(startOfFlagImage, endOfFlagImage)]]];
//            
//            RMAnnotation *annotation = [RMAnnotation annotationWithMapView:mapView coordinate:[mapView pixelToCoordinate:point] andTitle:countryName];
//            
//            annotation.userInfo = flagImage;
//            
//            [mapView addAnnotation:annotation];
//            
//            [mapView selectAnnotation:annotation animated:YES];
//        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
