#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
<<<<<<< HEAD
=======
#import "GoogleMaps/GoogleMaps.h"
>>>>>>> aae9f3a48f0eb63071c640ec12d69aeeb183d3e9

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
<<<<<<< HEAD
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

=======
  [GMSServices provideAPIKey:@"AIzaSyBTubYVW8-qH5cVgHaML0UKx_Wwlf54MSI"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
>>>>>>> aae9f3a48f0eb63071c640ec12d69aeeb183d3e9
@end
