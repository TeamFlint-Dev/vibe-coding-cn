# color_alpha struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/colors/color_alpha
> **爬取时间**: 2025-12-27T01:19:43.549819

---

Represents colors as RGB triples in the ACES 2065-1 color space with an additional alpha channel A.
This reasons about the `Color` and alpha (`A`) as separate concepts instead of as a single concept.
All values are stored strictly as unopinionated floats but, when interpreted as a color with alpha,
ranges for `A` are `0.0` (transparent) to `1.0` (opaque). Color values are not premultiplied.
Component values are linear (i.e. `*gamma* = 1.0`).

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/Colors }` |

## Members

This struct has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Color` | `color` | `Color` component of this `color_alpha`. |
| `A` | `float` | Alpha component of this `color_alpha`. |
