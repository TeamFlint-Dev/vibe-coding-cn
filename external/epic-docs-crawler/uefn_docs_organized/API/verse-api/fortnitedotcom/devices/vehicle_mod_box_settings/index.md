# vehicle_mod_box_settings class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_mod_box_settings>
> **爬取时间**: 2025-12-27T01:47:20.128252

---

Settings for vehicle mod boxes, used with vehicle\_mod\_box\_spawner\_device.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `PaintColor` | `??color` | A custom paint color on the mod box.   - If the associated mod box uses default visuals, it becomes a blank box with that paint color. - Setting this value to `false` removes any custom paint color. |
| `Icon` | `??texture` | A custom icon on the mod box. Attempting to return this value will fail unless it's your own texture.   - If the associated mod box uses default visuals, it becomes a blank box with that icon. - Setting this value to `false` removes any custom icon. |
| `IconColor` | `??color` | The custom color of the icon on the mod box. This value has no effect if this entry's icon is not set.   - Setting this value to `false` removes any custom icon color. |
| `IconScale` | `?float` | The scale multiplier of the icon on the mod box, clamped between `0.1` and `2.0`. This value has no effect if this entry's icon is not set.   - This value defaults to `1.0`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ApplyDefaultVisuals`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/vehicle_mod_box_settings/applydefaultvisuals) | Reset visual settings and make the associated mod box use its default non-customized visuals.   - Fails if this is a custom list entry set to `Empty Slot`. |
