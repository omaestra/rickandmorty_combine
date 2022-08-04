//
//  Apptimize+Segment.h
//  Apptimize
//
//  Copyright © 2020 Urban Airship Inc., d/b/a Airship.
//

#ifndef Apptimize_Segment_h
#define Apptimize_Segment_h

/**
 * Segment.io integration
 * :nodoc:
 */
@interface Apptimize (SEGIntegration)
+ (void)SEG_resetUserData;
+ (void)SEG_track:(NSString *)eventName attributes:(NSDictionary *)attributes;
+ (void)SEG_setUserAttributesFromDictionary:(NSDictionary *)dictionary;
@end

#endif /* Apptimize_Segment_h */
