#import "Kiwi.h"
#import "ViewController.h"

SPEC_BEGIN(ViewControllerSpec)

describe(@"View Controller", ^{
    it(@"should have a mutable array of ToDos", ^{
        ViewController* controller = [[ViewController alloc] init];
        [[theValue(controller) shouldNot] equal:theValue(Nil)];
    });
});

SPEC_END