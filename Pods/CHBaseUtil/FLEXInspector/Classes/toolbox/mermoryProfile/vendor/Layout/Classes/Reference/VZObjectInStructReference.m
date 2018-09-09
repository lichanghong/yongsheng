/**
 * Copyright (c) 2016-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "VZObjectInStructReference.h"

#import "VZClassStrongLayoutHelpers.h"

@implementation VZObjectInStructReference
{
  NSUInteger _index;
  NSArray<NSString *> *_namePath;
}

- (instancetype)initWithIndex:(NSUInteger)index
                     namePath:(NSArray<NSString *> *)namePath
{
  if (self = [super init]) {
    _index = index;
    _namePath = namePath;
  }

  return self;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"[in_struct; index: %td]", _index];
}

#pragma mark - VZObjectReference

- (id)objectReferenceFromObject:(id)object
{
  return VZExtractObjectByOffset(object, _index);
}

- (NSUInteger)indexInIvarLayout
{
  return _index;
}

- (NSArray<NSString *> *)namePath
{
  return _namePath;
}

@end
