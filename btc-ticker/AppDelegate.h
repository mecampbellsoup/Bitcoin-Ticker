//
//  AppDelegate.h
//  btc-ticker
//
//  Created by Matthew Campbell on 6/7/15.
//  Copyright (c) 2015 Matt Campbell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (readonly, nonatomic) NSString *bitcoinPriceUrl;

@end

