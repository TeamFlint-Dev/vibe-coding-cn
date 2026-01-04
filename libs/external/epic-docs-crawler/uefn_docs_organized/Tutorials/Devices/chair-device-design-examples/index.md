# Chair Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/chair-device-design-examples
> **爬取时间**: 2025-12-26T23:04:29.000834

---

You can use the Chair device to create places for players to sit on your island. But this simple device has other capabilities that let you build all sorts of unexpected things!

## Eject That Player!

This design example showcases the Chair device's basic features, along with how to make a fun ejector seat.

[![](https://dev.epicgames.com/community/api/documentation/image/0e2bc73b-feb7-409e-8043-be377f8c8121?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e2bc73b-feb7-409e-8043-be377f8c8121?resizing_type=fit)

### Devices Used

- 1 x [Chair](https://dev.epicgames.com/documentation/en-us/fortnite/using-chair-devices-in-fortnite-creative) device
- 1 x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device

### Place the Chair Device and Customize It

The **Chair** device can be customized to use a number of different models. Pick the one you like the best.

1. Place the **Chair** device.
2. Customize it using the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/38523f2a-c335-437c-87ca-3cbbff8becc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38523f2a-c335-437c-87ca-3cbbff8becc6?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/b173c8ca-8343-427a-9437-1d41420e5196?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b173c8ca-8343-427a-9437-1d41420e5196?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/f07bd087-7a2e-40ea-8d97-c22d79691a26?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f07bd087-7a2e-40ea-8d97-c22d79691a26?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Chair Model | COMFYCHAIR |
   | Player Exit Enabled | OFF |
   | Dismount Direction | FORWARD |
   | Dismount Force | 4000 CM/S |
   | Dismount Upward Force | 300 CM/S |

### Place the Prop Mover Device

1. Place the **Prop Mover** device, making sure that it touches the Chair device and turns green when it does. This ensures that the prop mover will affect the chair when it activates.

   [![](https://dev.epicgames.com/community/api/documentation/image/0c71f74b-2c76-46a6-98f1-dba254f257a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c71f74b-2c76-46a6-98f1-dba254f257a0?resizing_type=fit)
2. Remember that the arrow on the device indicates the direction that the chair will move. Rotate the Prop Mover to determine where the chair will go when it moves!

   [![](https://dev.epicgames.com/community/api/documentation/image/82a1fa2e-a8b4-4289-bc09-0359d7425196?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82a1fa2e-a8b4-4289-bc09-0359d7425196?resizing_type=fit)

### Customize the Prop Mover

1. Customize the Prop Mover as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/3075890a-5720-43fe-8b15-56febd1d8b8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3075890a-5720-43fe-8b15-56febd1d8b8c?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/afad6b2d-add0-401c-b2e4-c721aa06cf73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/afad6b2d-add0-401c-b2e4-c721aa06cf73?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | On Player Collision | CONTINUE |
   | Player Damage on Collision | 0 |
   | On Prop Collision Behavior | CONTINUE |
   | Prop Collision Damage | 10 |
   | Enable Device Activation on Move | ON |
   | \*Should Move From Start | OFF |
   | Allow Reverse Past Start | OFF |
2. Configure the Prop Mover **functions**:

   [![](https://dev.epicgames.com/community/api/documentation/image/f6c3e44e-edd1-4192-babb-92f40be2da5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6c3e44e-edd1-4192-babb-92f40be2da5d?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Enable When Receiving From | Chair Device | On Player Seated |
   | Start When Receiving From | Chair Device | On Player Seated |
3. Configure the events:

   [![](https://dev.epicgames.com/community/api/documentation/image/2a1f0378-5972-4951-a34f-90b44ced3337?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a1f0378-5972-4951-a34f-90b44ced3337?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/4a52a6cd-5008-4a29-a1fc-5ae0f176b2e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a52a6cd-5008-4a29-a1fc-5ae0f176b2e7?resizing_type=fit)

   | Event | Select Device | Select Event |
   | --- | --- | --- |
   | On Movement Finish Send Event to | Chair Device | Eject Player |
   | On Player Hit Send Event to | Chair Device | Eject Player |

## Design Tip

Play with the Prop Mover orientation and speed to create different effects, or vary the ejection strength on the chair to send players flying even further!
