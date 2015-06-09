//
//  AppDelegate.m
//  btc-ticker
//
//  Created by Matthew Campbell on 6/7/15.
//  Copyright (c) 2015 Matt Campbell. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize bitcoinPriceUrl;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *price = [self getDataFrom:@"https://api.coinbase.com/v1/prices/spot_rate"];
    [self activateStatusMenu:price];
    [NSTimer scheduledTimerWithTimeInterval:120.0f
                                     target:self selector:@selector(refreshSpotPrice:) userInfo:nil repeats:YES];
}

- (void)activateStatusMenu:(NSString *)price {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSLog(@"The status item's class is: %@", NSStringFromClass([_statusItem class]));

    _statusItem.button.image = [NSImage imageNamed:@"icon.png"];
    [_statusItem.button.image setTemplate:YES];
    
    NSString *currencySymbol = @" $";
    NSString *formattedPrice = [NSString stringWithFormat:@"%@%@", currencySymbol, price];
    _statusItem.title = formattedPrice;
}

- (void)refreshSpotPrice:(NSTimer *)timer {
    NSString *price = [self getDataFrom:@"https://api.coinbase.com/v1/prices/spot_rate"];
    NSLog(@"The current spot price is: %@", price);
    [self activateStatusMenu:price];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSString *)getDataFrom:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.coinbase.com/v1/prices/spot_rate"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    NSError *jsonParsingError = nil;
    NSDictionary *spotRate = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    NSString *priceString = [NSString stringWithFormat:@"%@", [spotRate objectForKey:@"amount"]];
    NSLog(@"%@", [spotRate objectForKey:@"amount"]);
    return [[NSString alloc] initWithFormat:priceString];
}

@end
