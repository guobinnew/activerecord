//
//  ARRelationship.m
//  ActiveRecord
//
//  Created by Fjölnir Ásgeirsson on 30.8.2007.
//  Copyright 2007 ninja kitten. All rights reserved.
//

#import "ARRelationship.h"
#import "ARBase.h"

@implementation ARRelationship
@synthesize name, className, record;

+ (id)relationshipWithName:(NSString *)aName className:(NSString *)aClassName
{
  return [[[self alloc] initWithName:aName className:aClassName] autorelease];
}
+ (id)relationshipWithName:(NSString *)aName
{
  return [[[self alloc] initWithName:aName className:nil] autorelease];
}
- (id)initWithName:(NSString *)aName className:(NSString *)aClassName
{
  if(![super init])
    return nil;
  
  self.name = aName;
  self.className = aClassName;
  
  return self;
}

- (BOOL)respondsToKey:(NSString *)key supportsAdding:(BOOL *)supportsAddingRet
{
  if(supportsAddingRet != NULL)
    *supportsAddingRet = NO;
  return NO;
}
- (BOOL)respondsToKey:(NSString *)key
{
  return [self respondsToKey:key supportsAdding:NULL];
}
- (id)retrieveRecordForKey:(NSString *)key
{
	return [self retrieveRecordForKey:key filter:nil order:nil limit:0];
}
- (id)retrieveRecordForKey:(NSString *)key 
										filter:(NSString *)whereSQL 
										 order:(NSString *)orderSQL
										 limit:(NSUInteger)limit
{
	[NSException raise:@"Unused method" format:@"You shouldn't be using ARRelationship directly!"];
	return nil;
}
- (void)sendRecord:(id)record forKey:(NSString *)key
{
  return;
}
- (void)addRecord:(id)record forKey:(NSString *)key
{
  return;
}
- (void)removeRecord:(id)record forKey:(NSString *)key
{
  return;
}

#pragma mark Accessors
#pragma mark -
- (NSString *)className
{
  return @"";
}

#pragma mark -
#pragma mark Copying
- (id)copyWithZone:(NSZone *)zone
{
  ARRelationship *ret = [[[self class] allocWithZone:zone] initWithName:self.name className:self.className];
  ret.record = self.record;
  return ret; 
}
#pragma mark -
#pragma mark Cosmetics
- (NSString *)description
{
  return [NSString stringWithFormat:@"{ %@ Name: %@ }", [super description], self.name];
}
@end

@implementation ARBase (Relationships)
- (NSArray *)relationshipsOfType:(NSString *)type
{
  NSMutableArray *ret = [NSMutableArray array];
  for(ARRelationship *relationship in self.relationships)
  {
    if([[[relationship class] className] isEqualToString:type])
      [ret addObject:relationship];
  }
  return ret;
}
@end
