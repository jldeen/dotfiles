#!/usr/bin/env osascript

try
	if application "System Preferences" is running then do shell script "killall 'System Preferences'"
end try
repeat until application "System Preferences" is not running
	delay 0.1
end repeat
tell application "System Preferences"
	reveal anchor "Main" of pane id "com.apple.preference.dock"
end tell

tell application "System Events" to tell application process "System Preferences"
	repeat while not (exists of UI element "Automatically hide and show the menu bar" of window "Dock & Menu Bar")
		delay 0.1
	end repeat
	click UI element "Automatically hide and show the menu bar" of window "Dock & Menu Bar"
	repeat while not (exists of UI element "Automatically hide and show the menu bar" of window "Dock & Menu Bar")
		delay 0.1
	end repeat
end tell

try
	if application "System Preferences" is running then do shell script "killall 'System Preferences'"
end try