using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
link_volume_to_shop_device := class(creative_device):

    @editable
    var ShopTemplate:shop_setup_device_template = shop_setup_device_template{}
    
    @editable
    var OfferVolume:volume_device = volume_device{}


    OnBegin<override>()<suspends>:void =          
        OfferVolume.AgentEntersEvent.Subscribe(OnVolumeEnter) 
   
    OnVolumeEnter(Agent:agent):void=
        if(Player:= player[Agent]):
            spawn:
                ShopTemplate.ShowArrayOfOffers(Player)  