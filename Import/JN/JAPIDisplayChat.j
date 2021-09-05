library JAPIDisplayChat
globals
    constant integer CHAT_RECIPIENT_ALL       = 0
    constant integer CHAT_RECIPIENT_ALLIES    = 1
    constant integer CHAT_RECIPIENT_OBSERVERS = 2
    constant integer CHAT_RECIPIENT_PRIVATE   = 3
endglobals

native EXDisplayChat takes player p, integer chat_recipient, string message returns nothing

function JNDisplayChatMessage takes player whichPlayer, integer recipient, string message returns nothing
    call EXDisplayChat(whichPlayer, recipient, message)
endfunction
endlibrary