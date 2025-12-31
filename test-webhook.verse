# Test file to trigger webhook
# This file tests the automated PR build system

using { /Verse.org/Verse }

test_webhook_function := class:
    Message : string = "Hello from webhook test!"
    
    PrintMessage() : void =
        Print(Message)
