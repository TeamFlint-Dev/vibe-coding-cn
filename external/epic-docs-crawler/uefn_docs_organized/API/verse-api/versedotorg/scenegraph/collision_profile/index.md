# collision_profile class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collision_profile>
> **爬取时间**: 2025-12-27T00:54:52.381768

---

A collision profile determines how a volume interacts with other volumes for Overlap queries, Sweep queries, and physics simulation. When two volumes are being tested to see how they interact, the algorithm looks like this:
GetInteraction(A:collision\_profile, B:collision\_profile):collision\_interaction =
InteractionA = B.GetChannelInteraction(A.Channel)
InteractionB = A.GetChannelInteraction(B.Channel)
return Min(InteractionA, InteractionB)

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Members

This class has data members, but no functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Channel` | `collision_channel` | The collision channel for the owning object. |
| `GetChannelInteraction` | (`collision_channel`):`collision_interaction` | How the owning object should interact with other objects.GetChannelInteraction is a function which maps a collision\_channel to a collision\_interaction. It can be implemented as an simple sequence of if statements. For example, to block all channels except camera: BlockAllIgnoreCamera(Channel:collision\_channel):collision\_interaction = if (CollisionChannels.camera[Channel]): return collision\_interaction.Ignore return collision\_interaction.Block MyProfile:collision\_profile = MakeCollisionProfile(CollisionChannels.dynamic, BlockAllIgnoreCamera) |
