nbminimodal
===========

Displays a small modal dialog that doesn't cover the whole screen

Demo
====

The demo/ folder contains a demo project showing NBMiniModal in use.
Open and run it.

Usage
=====

Create a subclass of NBMiniModal and define an init method for it,
passing in any needed parameters. Be sure to include a delegate.

	-(id)initWithMessage:(NSString *)message
    	        delegate:(id<NBMiniModalDelegate>)delegate;

In the init method, set up all properties of the modal including its
frame size. Don't worry about positioning it or adding it to any parent
view. In any event handlers you add to the modal, if you want to close
the modal, just call:

	[self.delegate completedMiniModal:self];

In the .h file of your view controller that will display the mini modal,
import:

	#import "NBMiniModal.h"

Then implement NBMiniModalDelegate:

	@interface NBViewController : UIViewController <NBMiniModalDelegate>

Then in the .m file, import:

	#import "UIViewController+MiniModal.h"

When you want to display the modal, instantiate it, then call:

	[self displayMiniModal:modal];

This will display the modal centered on the screen, with a mask behind
it. Then, implement the following NBMiniModalDelegate method:

	-(void)completedMiniModal:(NBMiniModal *)modal
	{
    	[self dismissMiniModal];
	}

Add any other handling code you want, to respond to what the user did in
the modal.

Compatibility
=============

This class has been tested back to iOS 6.1.

Implementation
==============

The NBMiniModal is just a simple UIView. The UIViewController category
includes code to display that view centered in the view, show the mask,
and add parallax to it for iOS 7.

License
=======

This code is released under the MIT License. See the LICENSE file for
details.