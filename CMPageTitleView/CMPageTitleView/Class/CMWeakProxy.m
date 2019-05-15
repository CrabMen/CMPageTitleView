//
//  CMWeakProxy.m
//
//  GitHub 下载地址：https://github.com/CrabMen/CMPageTitleView
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "CMWeakProxy.h"


@implementation CMWeakProxy

- (instancetype)initWithTarget:(id)target {
    _cm_target = target;
    return self;
}

+ (instancetype)cm_proxyWithTarget:(id)target {
    return [[CMWeakProxy alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _cm_target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_cm_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_cm_target isEqual:object];
}

- (NSUInteger)hash {
    return [_cm_target hash];
}

- (Class)superclass {
    return [_cm_target superclass];
}

- (Class)class {
    return [_cm_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_cm_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_cm_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_cm_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_cm_target description];
}

- (NSString *)debugDescription {
    return [_cm_target debugDescription];
}

@end
