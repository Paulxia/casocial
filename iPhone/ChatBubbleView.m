//
//  ChatBubbleView.m
//  TwitterFon
//
//  Created by kaz on 12/17/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import "ChatBubbleView.h"
#import "Message.h"

static UIImage* sGreenBubble = nil;
static UIImage* sGrayBubble = nil;

@interface ChatBubbleView(Private)
+ (UIImage*)greenBubble;
+ (UIImage*)grayBubble;
@end

@implementation ChatBubbleView

@synthesize image;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setMessage:(Message*)aMessage type:(BubbleType)aType
{
    message = aMessage;
    type = aType;
    [self setNeedsDisplay];    
}

#define IMAGE_SIZE 32
#define IMAGE_H_PADDING 8

- (void)drawRect:(CGRect)rect 
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    float top = 0;
    
    //
    // Draw timestamp
    //
	if (YES) { // needs timestamp?
		UIColor *timestampColor = [UIColor darkGrayColor];
		[timestampColor set];
        
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
		
		//NSDate *date = [NSDate dateWithTimeIntervalSince1970:message.createdAt];
		NSString *formattedDateString = [dateFormatter stringFromDate:message.createdAt];
		[formattedDateString drawInRect:CGRectMake(0, 4, 320, 16) withFont:[UIFont boldSystemFontOfSize:12]
						  lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];        
        
		top = 22;
	}
    //
    // Draw message profile image icon with drop shadow
    //
	/*
    CGContextSetShadowWithColor(c, CGSizeMake(0, -1), 3, [[UIColor darkGrayColor] CGColor]);        
    
    CGRect imageRect = CGRectMake(0, 0, IMAGE_SIZE, IMAGE_SIZE);
    imageRect.origin.y = rect.size.height - IMAGE_SIZE - 4;
    if (type == BUBBLE_TYPE_GRAY) {
        imageRect.origin.x = IMAGE_H_PADDING;
    }
    else {
        imageRect.origin.x = 320 - IMAGE_H_PADDING - IMAGE_SIZE;
    }
    [image drawInRect:imageRect];
	 */
	

    CGContextSetShadowWithColor(c, CGSizeMake(0, 0), 0, [[UIColor whiteColor] CGColor]);

    //
    // Draw chat bubble
    //
    UIImage *bubble;
    int height = self.bounds.size.height - 5;
    //if (message.needTimestamp) height -= 21;
	height -= 21;
    //CGRect bubbleRect = CGRectMake(0, 0, message.bubbleRect.size.width, height);
	CGRect bubbleRect = CGRectMake(0, 0, 200.0, height);
    
    int width = bubbleRect.size.width + 30;
    width = (width / 10) * 10 + ((width % 10) ? 10 : 0);
    bubbleRect.size.width = width;
    bubbleRect.origin.y = 4 + top;
    
    if (type == BUBBLE_TYPE_GRAY) {
        bubble = [ChatBubbleView grayBubble];
       // bubbleRect.origin.x = IMAGE_SIZE + IMAGE_H_PADDING;
		 bubbleRect.origin.x = 2.0;
    }
    else {
        bubble = [ChatBubbleView greenBubble];
      //  bubbleRect.origin.x = 320 - bubbleRect.size.width - IMAGE_SIZE - IMAGE_H_PADDING;
		  bubbleRect.origin.x = 320 - bubbleRect.size.width - 2.0;
    }
    [bubble drawInRect:bubbleRect];
    
    //
    // Draw message text
    //
    [[UIColor blackColor] set];
    bubbleRect.origin.y += 6;
    //bubbleRect.size.width = message.bubbleRect.size.width;
	bubbleRect.size.width = 200.0;
    if (type == BUBBLE_TYPE_GRAY) {
        bubbleRect.origin.x += 20;
    }
    else {
        bubbleRect.origin.x += 10;
    }
    [message.body drawInRect:bubbleRect withFont:[UIFont systemFontOfSize:14]];
	
}

- (BubbleType)type {
	return type;
}


- (void)dealloc {
    [image release];
    [super dealloc];
}

+ (UIImage*)greenBubble
{
    if (sGreenBubble == nil) {
        UIImage *i = [UIImage imageNamed:@"balloon_me.png"];
        sGreenBubble = [[i stretchableImageWithLeftCapWidth:15 topCapHeight:13] retain];
    }
    return sGreenBubble;
}

+ (UIImage*)grayBubble
{
    if (sGrayBubble == nil) {
        UIImage *i = [UIImage imageNamed:@"balloon_other.png"];
        sGrayBubble = [[i stretchableImageWithLeftCapWidth:21 topCapHeight:13] retain];
    }
    return sGrayBubble;
}

@end
