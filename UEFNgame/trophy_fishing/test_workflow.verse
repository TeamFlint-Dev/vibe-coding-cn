# test_workflow - Basic Hello World Test Class
# Version: 1.1
# Source: Test file for trophy-fishing workflow
# Update: Fixed Verse syntax - changed to final_super for component inheritance

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# Hello World test class for trophy-fishing workflow
hello_world_test<public> := class<final_super>(component):
    @editable
    var Message<public>:string = "Hello, World!"
    
    var IsActive<private>:logic = false
    
    # Initialize the component
    OnSimulationBegin<public>():void =
        set IsActive = true
        PrintMessage()
    
    # Print the hello world message
    PrintMessage<public>():void =
        Print("Trophy Fishing Workflow: {Message}")
    
    # Get the current message
    GetMessage<public>():string = Message
    
    # Set a new message
    SetMessage<public>(NewMessage:string):void =
        set Message = NewMessage
    
    # Check if component is active
    IsComponentActive<public>():logic = IsActive
