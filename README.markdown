##Background##
I was working on a rather simple video conversion tool, based around the ffmpeg tool, when I realized how painful interfacing with command line utility from Cocoa would be. I went through with development anyway, only to find my original expectations to be true. I briefly tried to simply use the libraries directly in the application, but soon found them to be impossibly messy.

##Goal##
The goal of the framework is to provide a full-featured Cocoa API, allowing developers to create feature-rich video converters, of both wide and narrow scope. CAConversionFramework is designed to be extensible as well as easy to understand.

##Important Points##

+	CAConversionFramework is not even close to being done. Currently it is basically useless.  
+	The prefix "CA" is used as they are my initials:  try not to get them confused with Apple's use of CA, to mean Core Animation.  
+	CAConversionFramework makes use of Grand Central Dispatch, which means it requires OS 10.6 or later.  
+	The "Vidiot" project is provided just as a test application.  

##Basic Layout##
The framework is centralized around CAConversion objects, which represent a video conversion:  either preparing to be run, running, or completed. CAConversion objects are monitored and managed by a shared class known as the CAConversionCenter (think of NSNotificationCenter, etc.) Each CAConversion object has many objects associated with it, including info objects, streams, etc. All of these can be accessed using simple getters and setters. A CAConversion object has a property known as progressInfo, which will provide a developer all the information they need to program a conversion progress bar, or other manner of displaying progress. Conversion objects also send out notifications thru NSNotificationCenter, allowing the developer to always know when to update their progress display.