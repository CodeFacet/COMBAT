## COMBAT overview

**COMBAT** is a simple and modern software solution for complex Automation Testing of GUI based Desktop (native Cocoa and Carbon) Applications on **Mac** OS X. *Mac Automation Testers will love this tool!!*

## Motivation

Tools available in market for Test Automation of Desktop applications are too expensive and also requires huge efforts on maintenance. For example most of these tools relies on screen coordinates or image comparisons for GUI object recognition or verifications. **COMBAT** relies on traditional addressing concept, every GUI object has identifier and same will be used to query for a given GUI object and an operation will be executed as per users request.

There is a brief [topic](https://sqaleaders.wordpress.com/GUIAutomationToolsforMACOSX.html) on various tools with their pros and cons.

## Code Example

1. Launching an application, Calculator as an example
  - `[dp query:@"op=launchapp&appname=Calculator”];`
2. Perform click operation on button “9”, button 9 has identifier value as”_NS:120”
  - `[dp query:@"op=clickuielement&appname=Calculator&controlidentifier=_NS:120”];`

### Detailed list of params supports

Detailed list of params [documetation](https://sqaleaders.wordpress.com/)

## Limitations

Not known as of now!

## Building COMBAT

Build the COMBAT in Xcode ver >= 5.x, (the tool has been tested on OS X 10.9), just run and see little animation on your screen!!! Calculator will be launched and button ‘9’ will be pressed four times. 

## Contributors

**COMBAT** yet to provide out of the box scriptability, we appreciate your feedback and contributions.

## License

License has been included in the project. License.txt