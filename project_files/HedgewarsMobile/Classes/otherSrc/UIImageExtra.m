//
//  UIImageExtra.m
//  HedgewarsMobile
//
//  Created by Vittorio on 08/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIImageExtra.h"


@implementation UIImage (extra)
 
-(UIImage *)scaleToSize:(CGSize) size {
  // Create a bitmap graphics context
  // This will also set it as the current context
  UIGraphicsBeginImageContext(size);
 
  // Draw the scaled image in the current context
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
 
  // Create a new image from current context
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
 
  // Pop the current context from the stack
  UIGraphicsEndImageContext();
 
  // Return our new scaled image (autoreleased)
  return scaledImage;
}

-(UIImage *)mergeWith:(UIImage *)secondImage atPoint:(CGPoint) secondImagePoint {
    // create a contex of size of the background image
    return [self mergeWith:secondImage atPoint:secondImagePoint atSize:self.size];
}

-(UIImage *)mergeWith:(UIImage *)secondImage atPoint:(CGPoint) secondImagePoint atSize:(CGSize) resultingSize {
    UIGraphicsBeginImageContext(resultingSize);
    
    // drav the background image
    [self drawAtPoint:CGPointMake(0,0)];
    
    // draw the image on top of the first image
    [secondImage drawAtPoint:secondImagePoint];
    
    // create an image from the current contex (not thread safe)
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // free drawing contex
    UIGraphicsEndImageContext();
    
    // return the resulting autoreleased image
    return resultImage;
}

-(id) initWithContentsOfFile:(NSString *)path andCutAt:(CGRect) rect {
    // load image from path
    UIImage *image = [[UIImage alloc] initWithContentsOfFile: path];
    
    if (nil != image) {
        // get its CGImage representation with a give size
        CGImageRef cgImgage = CGImageCreateWithImageInRect([image CGImage], rect);
    
        // clean memory
        [image release];
    
        // create a UIImage from the CGImage (memory must be allocated already)
        UIImage *sprite = [self initWithCGImage:cgImgage];
    
        // clean memory
        CGImageRelease(cgImgage);

        // return resulting image
        return sprite;
    } else {
        DLog(@"error - image == nil");
        return nil;
    }
}

-(UIImage *)convertToGrayScale {
  // Create image rectangle with current image width/height
  CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
 
  // Grayscale color space
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
 
  // Create bitmap content with current image size and grayscale colorspace
  CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
 
  // Draw image into current context, with specified rectangle
  // using previously defined context (with grayscale colorspace)
  CGContextDrawImage(context, imageRect, [self CGImage]);
 
  // Create bitmap image info from pixel data in current context
  CGImageRef imageRef = CGBitmapContextCreateImage(context);
 
  // Create a new UIImage object  
  UIImage *newImage = [UIImage imageWithCGImage:imageRef];
 
  // Release colorspace, context and bitmap information
  CGColorSpaceRelease(colorSpace);
  CGContextRelease(context);
  CFRelease(imageRef);
 
  // Return the new grayscale image
  return newImage;
}

// by http://iphonedevelopertips.com/cocoa/how-to-mask-an-image.html turned into a category by koda
-(UIImage*) maskImageWith:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
    
    CGImageRelease(mask);
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(masked);
    
    return retImage;
}

// by http://blog.sallarp.com/iphone-uiimage-round-corners/ turned into a category by koda
void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

-(UIImage *)makeRoundCornersOfSize:(CGSize) sizewh {
	UIImage * newImage = nil;
    
    NSInteger cornerWidth = sizewh.width;
    NSInteger cornerHeight = sizewh.height;
    int w = self.size.width;
    int h = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    newImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
        
    return newImage;
}


@end
