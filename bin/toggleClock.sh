#!/usr/bin/env osascript

#### brew install tccutil; sudo tccutil --insert /usr/bin/osascript - no longer works due to SIP - https://github.com/univ-of-utah-marriott-library-apple/privacy_services_manager/issues/51


tell application "System Preferences"
    set current pane to pane id "com.apple.preference.datetime"
    tell application "System Events" to tell process "System Preferences"
        delay 0.5
    click checkbox "Show Date and Time in menu bar" of tab group 1 of window 1
    end tell
end tell
quit application "System Preferences"