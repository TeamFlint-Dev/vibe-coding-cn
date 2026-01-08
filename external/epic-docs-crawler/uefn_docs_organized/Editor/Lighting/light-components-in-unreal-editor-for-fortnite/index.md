# Light Components

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/light-components-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:43:43.922222

---

Components are basic building blocks that use data and logic to build your game. Use the **light component** to light a room or a dark part of your environment.

You can use this component alone to add light to a dark space or pair it with other components to make a more dynamic entity.

To add a component to your entity, check out [**Working with Entities and Components**](working-with-entites-and-components-in-unreal-editor-for-fortnite#addingacomponent). For more information on how to use lighting in your projects, check out the [Lighting section](https://dev.epicgames.com/documentation/en-us/uefn/lighting-in-unreal-editor-for-fortnite).

## Light Component Superclass

Each type of light component derives from the abstract `light_component` superclass. This class defines parameters and behaviors common to each light component.

All light components share the following common parameters:

### CastShadows

This option determines whether a light should cast any shadows.

![Default light](https://dev.epicgames.com/community/api/documentation/image/01f39ede-9bca-4a4e-86ed-5a0f757b8420?resizing_type=fit&width=1920&height=1080)

![Disabled shadows](https://dev.epicgames.com/community/api/documentation/image/1615b72f-d33d-4d8c-ad56-dc95d6a39bee?resizing_type=fit&width=1920&height=1080)

Default light

Disabled shadows

### ColorFilter

This option sets the filter color of the light and acts as a colored filter in front of the light source.

![Default light](https://dev.epicgames.com/community/api/documentation/image/15b8a9be-c301-49dc-b700-b9406087f21d?resizing_type=fit&width=1920&height=1080)

![Pink filter](https://dev.epicgames.com/community/api/documentation/image/6156c749-05fc-4c37-8faa-8919172e27ef?resizing_type=fit&width=1920&height=1080)

Default light

Pink filter

### SpecularScale

This option determines the radius of the source capsule shape, in meters.

![Default light](https://dev.epicgames.com/community/api/documentation/image/19bf018c-d61c-4eba-9e93-d7ac51f52860?resizing_type=fit&width=1920&height=1080)

![Specular set to 0](https://dev.epicgames.com/community/api/documentation/image/daa2bb17-2461-4b37-b97a-2f913efb6126?resizing_type=fit&width=1920&height=1080)

Default light

Specular set to 0

### DiffuseScale

This option determines the length of the source capsule shape, in meters.

![Default light](https://dev.epicgames.com/community/api/documentation/image/63243a04-2e4a-426c-b063-8ea1473284d9?resizing_type=fit&width=1920&height=1080)

![Diffuse set to 0](https://dev.epicgames.com/community/api/documentation/image/a733de28-9295-419f-bcc3-10b0783ec551?resizing_type=fit&width=1920&height=1080)

Default light

Diffuse set to 0

## Capsule Light Component

The **Capsule Light Component** adds a
Capsule lights emit light in all directions from a capsule-shaped source with a specified length and radius. Setting the length and radius to `0` makes this light act identically to a **[point light](https://dev.epicgames.com/documentation/en-us/unreal-engine/point-lights-in-unreal-engine)**. Capsule lights are best used when you want to simulate a shaped light that emits in all directions, such as a lightbulb or neon light bar.

[![Capsule light](https://dev.epicgames.com/community/api/documentation/image/729f310c-7196-4c71-af6a-e07f37801e2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/729f310c-7196-4c71-af6a-e07f37801e2e?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Intensity** | **5.0**, select a value. | Sets the visible light intensity emitted in SI unit Candela. Specified before **ColorFilter** (which multiplies each color component after the intensity calculation and can change the effective intensity of the light). |
| **AttenuationRadius** | **10.0**, select a value. | The bounds of the light's visible influence, in meters. Objects outside the **AttenuationRadius** are not affected by this light. The light falloff is based on the Inverse Square law. Towards the tail end of the AttenuationRadius, there is an additional smoothing factor to fade out the light contribution to `0` to avoid a hard cutoff. |
| **SourceRadius** | **0.1**, select a value. | The radius of the source capsule shape, in meters. |
| **SourceLength** | **0.5**, select a value. | The length of the source capsule shape, in meters. |

## Directional Light Component

The **Directional Light** simulates light that is being emitted from a source that is infinitely far away. This means that all shadows cast by this light will be parallel, making this the ideal choice for simulating sunlight.

![Direction 1](https://dev.epicgames.com/community/api/documentation/image/8dc6acec-7eb5-47a5-ac20-9891aef5aeeb?resizing_type=fit&width=1920&height=1080)

![Direction 2](https://dev.epicgames.com/community/api/documentation/image/6a7eb82b-4836-408d-a5b4-10b5d74fbaeb?resizing_type=fit&width=1920&height=1080)

Direction 1

Direction 2

| Option | Value | Description |
| --- | --- | --- |
| **Illuminance** | **10.0**, select a value. | The intensity of the light hitting the surface, in lux. |
| **SourceAngleDegrees** | **0.5357**, select a value. | The angle subtended by the light source in degrees. Defaults to `0.5357` which is the angle of the earth’s sun. |

## Rect Light Component

The **Rect Light** emits light into the scene from a rectangular plane with a defined width and height. Use the **rect light component** to light a large area evenly and generate diffuse shadows based on the area it covers. This component can complement other lighting components by acting as [fill lighting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#fill-light).

[![Rect light](https://dev.epicgames.com/community/api/documentation/image/806f8f77-26e2-4762-9af6-96612bec6858?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/806f8f77-26e2-4762-9af6-96612bec6858?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Intensity** | **5.0**, select a value. | Sets the visible light intensity emitted in SI unit Candela. Specified before **ColorFilter** (which multiplies each color component after the intensity calculation and can change the effective intensity of the light). |
| **AttenuationRadius** | **10.0**, select a value. | The bounds of the light's visible influence, in meters. Objects outside the **AttenuationRadius** are not affected by this light. The light falloff is based on the Inverse Square law. Towards the tail end of the AttenuationRadius, there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff. |
| **SourceWidth** | **0.64**, select a value. | The width of the light source rectangle, in meters. |
| **SourceHeight** | **0.64**, select a value. | The height of the light source rectangle, in meters. |
| **BarnDoorAngleDegrees** | **88.0**, select a value. | Barn doors are light modifiers that shape and direct light. This setting determines the angle of the barn doors in degrees attached to the light source rectangle. This value is clamped between `0.0` and `90.0`. |
| **BarnDoorLength** | **0.2**, select a value. | The length of the barn door attached to the light source rectangle, in meters. |

## Sphere Light Component

Similar to the rect light, the **Sphere Light** emits light into the scene from a spherical plane with a defined source radius and attenuation radius. This component can complement other lighting components by acting as [fill lighting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#fill-light).

[![Sphere light](https://dev.epicgames.com/community/api/documentation/image/202ab809-93d6-443a-88fc-e7caaf2475d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/202ab809-93d6-443a-88fc-e7caaf2475d8?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Intensity** | **5.0**, select a value. | Sets the visible light intensity emitted in SI unit Candela. Specified before **ColorFilter** (which multiplies each color component after the intensity calculation and can change the effective intensity of the light). |
| **AttenuationRadius** | **10.0**, select a value. | The bounds of the light's visible influence, in meters. Objects outside the **AttenuationRadius** are not affected by this light. The light falloff is based on the Inverse Square law. Towards the tail end of the AttenuationRadius, there is an additional smoothing factor to fade out the light contribution to `0` to avoid a hard cutoff. |
| **SourceRadius** | **0.1**, select a value. | The radius of the source sphere shape, in meters. |

## Spot Light

A **Spot Light** emits light from a single point in a cone shape. Users are given two cones to shape the light - the Inner Cone Angle and Outer Cone Angle. Within the Inner Cone Angle, the light achieves full brightness. As you go from the extent of the inner radius to the extents of the Outer Cone Angle, a falloff takes place, creating a penumbra, or softening around the Spot Light's disc of illumination. The Radius of the light defines the length of the cones. More simply, this will work like a flash light or stage can light.

[![Spot light](https://dev.epicgames.com/community/api/documentation/image/41519d4f-3c41-4c81-96ba-15701c3c825f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41519d4f-3c41-4c81-96ba-15701c3c825f?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Intensity** | **5.0**, select a value. | Sets the visible light intensity emitted in SI unit Candela. Specified before **ColorFilter** (which multiplies each color component after the intensity calculation and can change the effective intensity of the light). |
| **AttenuationRadius** | **10.0**, select a value. | The bounds of the light's visible influence, in meters. Objects outside the **AttenuationRadius** are not affected by this light. The light falloff is based on the Inverse Square law. Towards the tail end of the AttenuationRadius, there is an additional smoothing factor to fade out the light contribution to `0` to avoid a hard cutoff. |
| **SourceRadius** | **0.1**, select a value. | The radius of the source sphere shape, in meters. |
| **InnerConeAngleDegrees** | **0.0**, select a value. | The light’s inner cone-shaped angle in degrees. This value is clamped between `0.0` and `80.0`. |
| **OuterConeAngleDegrees.** | **44.0**, select a value. | The light’s outer cone-shaped angle in degrees. This value is clamped between `1.0` and `80.0`. |
