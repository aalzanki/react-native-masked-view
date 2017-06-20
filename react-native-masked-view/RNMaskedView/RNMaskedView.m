//
//  RNMaskedView.m
//  RNMaskedView
//

#import "RNMaskedView.h"
#import "RCTConvert.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation RNMaskedView {
    UIImage *_maskUIImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[_maskUIImage CGImage];
    mask.frame = self.bounds; //TODO custom: CGRectMake(left, top, width, height);
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}

- (void)setMaskImage:(NSString *)imageString
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSString *imageURL = [RCTConvert NSString:imageString];
		NSURL *url = [NSURL URLWithString:imageURL];
		NSData *data = [NSData dataWithContentsOfURL:url];
		_maskUIImage = [[UIImage alloc]initWithData:data];

		dispatch_async(dispatch_get_main_queue(), ^{
			[self layoutSubviews];
		});
	});
}

- (void)displayLayer:(CALayer *)layer
{
//    override displayLayer because the build-in RCTView
//    #displayLayer kills the mask
}

@end
