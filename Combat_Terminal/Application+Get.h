//
//  Application+Get.h
/*!
@author Piyush Bansal (piyush2508@gmail.com), Gopi Krishna Rajoju (gopirajoju@live.com) and Sakshi Goyal (sakshigoyal369@gmail.com)

@date 07/07/14

@brief This class is used to get UI element information from the Application under test. 
It gives UI element's attribute information, Descendants' information and it's leneage.
@copyright Copyright (c) 2015, The Combat authors - Piyush Bansal, Gopi Krishna Rajoju and Sakshi Goyal. All rights reserved.

Redistribution is not permitted. Use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Use of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Use in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the derived product.

The names of its contributors must not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import <Foundation/Foundation.h>

@interface Application_Get : NSObject

-(NSString*)            getElementInfo:(AXUIElementRef)uielement;
-(NSString *)           getElementAndDescendantsInfo:(AXUIElementRef)uielement;
-(NSString *)           getLineage:(AXUIElementRef)uielement;

@end
