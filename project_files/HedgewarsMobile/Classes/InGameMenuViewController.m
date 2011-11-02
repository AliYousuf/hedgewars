/*
 * Hedgewars-iOS, a Hedgewars port for iOS devices
 * Copyright (c) 2009-2011 Vittorio Giovara <vittorio.giovara@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * File created on 25/03/2010.
 */


#import "InGameMenuViewController.h"
#import "SDL_sysvideo.h"
#import "SDL_uikitkeyboard.h"

//FIXME: add a proper #import when this is exposed in SDL
extern UIView *SDL_getUikitView(void *);

#define VIEW_HEIGHT 200

@implementation InGameMenuViewController
@synthesize menuList;


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
    return rotationManager(interfaceOrientation);
}

-(void) didReceiveMemoryWarning {
    self.menuList = nil;
    [super didReceiveMemoryWarning];
}

-(void) viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:
                      NSLocalizedString(@"Show Help", @""),
                      NSLocalizedString(@"Tag", @""),
//                      NSLocalizedString(@"Snapshot",@""),
                      NSLocalizedString(@"End Game", @""),
                      nil];
    self.menuList = array;
    [array release];

    [super viewDidLoad];
}

-(void) viewDidUnload {
    self.menuList = nil;
    MSG_DIDUNLOAD();
    [super viewDidUnload];
}

-(void) dealloc {
    releaseAndNil(menuList);
    [super dealloc];
}

#pragma mark -
#pragma mark animating
-(void) present {
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(screen.size.height, 0, 200, VIEW_HEIGHT);

    [UIView beginAnimations:@"showing popover" context:NULL];
    [UIView setAnimationDuration:0.35];
    self.view.frame = CGRectMake(screen.size.height-200, 0, 200, VIEW_HEIGHT);
    [UIView commitAnimations];
}

-(void) dismiss {
    if (IS_IPAD() == NO) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        [UIView beginAnimations:@"hiding popover" context:NULL];
        [UIView setAnimationDuration:0.35];
        self.view.frame = CGRectMake(screen.size.height, 0, 200, VIEW_HEIGHT);
        [UIView commitAnimations];
        [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.35];
    }

    SDL_iPhoneKeyboardHide((SDL_Window *)HW_getSDLWindow());

    /*
    if (shouldTakeScreenshot) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please wait"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 45);
        [indicator startAnimating];
        [alert addSubview:indicator];
        [indicator release];

        // all these hacks because of the PAUSE caption on top of everything...
        [self performSelector:@selector(saveCurrentScreenToPhotoAlbum:) withObject:alert afterDelay:0.3];
    }
    */
    shouldTakeScreenshot = NO;
}

#pragma mark -
#pragma mark tableView methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
//    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.menuList objectAtIndex:[indexPath row]];

    if (IS_IPAD())
        cell.textLabel.textAlignment = UITextAlignmentCenter;

    return cell;
}

-(void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIActionSheet *actionSheet;
//    UIAlertView *alert;

    switch ([indexPath row]) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"show help ingame" object:nil];

            break;
        case 1:
            HW_chat();
            SDL_iPhoneKeyboardShow((SDL_Window *)HW_getSDLWindow());

            break;
        case 2:
/*
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Going to take a screenshot",@"")
                                               message:NSLocalizedString(@"The game snapshot will be placed in your Photo Album and it will be taken as soon as the pause menu is dismissed",@"")
                                              delegate:nil
                                     cancelButtonTitle:NSLocalizedString(@"Ok, got it",@"")
                                     otherButtonTitles:nil];
            [alert show];
            [alert release];
            shouldTakeScreenshot = YES;

            break;
        case 3:
*/
            actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Are you reeeeeally sure?", @"")
                                                      delegate:self
                                             cancelButtonTitle:NSLocalizedString(@"Well, maybe not...", @"")
                                        destructiveButtonTitle:NSLocalizedString(@"Of course!", @"")
                                             otherButtonTitles:nil];
            [actionSheet showInView:(IS_IPAD() ? self.view : SDL_getUikitView(HW_getSDLWindow()))];
            [actionSheet release];

            break;
        default:
            DLog(@"Warning: unset case value in section!");
            break;
    }

    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark actionSheet methods
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex {
    if ([actionSheet cancelButtonIndex] != buttonIndex) {
        SDL_iPhoneKeyboardHide((SDL_Window *)HW_getSDLWindow());
        HW_terminate(NO);
    }
}

//TODO: check this is still needed since we switched to SDL_GL_CreateContext()
/*
#pragma mark -
#pragma mark save screenshot
//by http://www.bit-101.com/blog/?p=1861
// callback for CGDataProviderCreateWithData
void releaseData(void *info, const void *data, size_t dataSize) {
    DLog(@"freeing raw data\n");
    free((void *)data);
}

// callback for UIImageWriteToSavedPhotosAlbum
-(void) image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    DLog(@"Save finished\n");
    [image release];
    UIAlertView *alert = (UIAlertView *)contextInfo;
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

// the resolution of the buffer is always equal to the hardware device even if scaled
-(void) saveCurrentScreenToPhotoAlbum:(UIAlertView *)alert {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width;
    int height = screenRect.size.height;

    NSInteger size = width * height * 4;
    GLubyte *buffer = (GLubyte *) malloc(size * sizeof(GLubyte));
    GLubyte *buffer_flipped = (GLubyte *) malloc(size * sizeof(GLubyte));

    glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    HW_screenshot();
    // flip the data as glReadPixels here reads upside down
    for(int y = 0; y <height; y++)
        for(int x = 0; x <width * 4; x++)
            buffer_flipped[(int)((height - 1 - y) * width * 4 + x)] = buffer[(int)(y * 4 * width + x)];
    free(buffer);

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer_flipped, size, releaseData);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, 8, 32, 4 * width, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);

    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);

    UIImage *image;
    if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)])
        image = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:UIImageOrientationRight];
    else
        image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);

    // add callback for cleaning memory and removing alert
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (void *)alert);
}
*/

@end
