//
//  System+Application.h
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 04/07/14

@brief This class is used to interact with the Application under test to get the snippet of a control.

@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import <Foundation/Foundation.h>

@class Control_Get,Application_Search, SystemManager;
@interface System_Application : NSObject

@property (nonatomic, retain) Control_Get *control_Get;
@property (nonatomic, retain) Application_Search *application_Search;
@property (nonatomic, retain) SystemManager *system;

-(CGImageRef)   getControlSnip: (NSString*) appname and:(NSDictionary*)uielementConditions and:(NSDictionary*)windowConditions;
@end
