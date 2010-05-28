//
//  ChatBubbleView.h
//  TwitterFon
//
//  Created by kaz on 12/17/08.
//  Copyright 2008 naan studio. All rights reserved.
//

@class Message;


#define CHAT_BUBBLE_WIDTH           (320 - 32 - 8 - 20 - 20)
#define CHAT_BUBBLE_TEXT_WIDTH      (CHAT_BUBBLE_WIDTH - 30)
#define CHAT_BUBBLE_TIMESTAMP_DIFF  (60 * 30)

typedef enum {
    BUBBLE_TYPE_GRAY,
    BUBBLE_TYPE_GREEN,
} BubbleType;

@interface ChatBubbleView : UIView
{
    BubbleType      type;
    Message*        message;
    UIImage*        image;
}

@property(nonatomic, retain) UIImage* image;

- (void)setMessage:(Message*)message type:(BubbleType)type;
- (BubbleType)type;

@end
