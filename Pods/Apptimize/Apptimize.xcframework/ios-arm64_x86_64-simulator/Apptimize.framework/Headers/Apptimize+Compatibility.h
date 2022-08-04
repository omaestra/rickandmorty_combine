//
//  Apptimize+Compatibility.h
//  Apptimize 3.5.10
//
//  Copyright © 2020 Urban Airship Inc., d/b/a Airship.
//
//  WARNING: Methods and Constants in this file should not be used in new code!
//

#ifndef __deprecated_msg
#define __deprecated_msg(_msg) __deprecated
#endif

/// :nodoc:
@interface Apptimize (Compatibility)

/**
 * metricAchieved: is deprecated. Prefer track: in all new code.
 * :nodoc:
 */
+ (void)metricAchieved:(NSString *)metric DEPRECATED_MSG_ATTRIBUTE("Prefer track: in all new code");

@end
