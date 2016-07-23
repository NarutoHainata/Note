//
//  TxtModel.h
//  Note
//
//  Created by zhang on 1/15/16.
//  Copyright (c) 2016 naruto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TxtModel : NSObject

@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSString *fileSize;
@property(nonatomic,strong)NSString *fileTime;
@property(nonatomic,strong)NSString *fileContent;

@end
