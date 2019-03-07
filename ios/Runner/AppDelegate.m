#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"
//#import "GoogleMaps/GoogleMaps.h"
#import "GoogleMapsBase/GoogleMapsBase.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      
    [GMSServices provideAPIKey:@"AIzaSyCFl7tJo20BPyYb78blViWGd8f308nATqE"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
