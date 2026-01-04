# Grouping

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/grouping-in-verse
> **爬取时间**: 2025-12-26T23:49:46.822305

---

**Grouping expressions** is a way to specify [order of evaluation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#order-of-evaluation), which is useful if you need to work around [operator](operators-in-verse) precedence.

You can group [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) by using `()`.

For example, the expressions `(y2 - y1)` and `(x2 - x1)` below are evaluated before dividing the numbers.

```verse
(y2 - y1) / (x2 - x1)
```

As an example, take an in-game explosion that scales its damage based on the distance from the player, but where the player's armor can reduce the total damage:

```verse
BaseDamage : float = 100
Armor : float = 15

# Scale by square distance between the player and the explosion. 1.0 is the minimum
DistanceScaling : float = Max(1.0, Pow(PlayerDistance, 2.0))

# The farther the explosion is, the less damage the player takes
var ExplosionDamage : float = BaseDamage / DistanceScaling

# Reduce the damage by armor
set ExplosionDamage -= Armor 

# Avoid negative damage values so that explosions can't heal very high armor players.
set ExplosionDamage = Max(0.0, ExplosionDamage)
```

Using grouping, you could rewrite the example above as:

```verse
BaseDamage : float = 100
Armor : float = 15
DistanceScaling : float = Max(1.0, Pow(PlayerDistance, 2.0))
ExplosionDamage : float = Max(0.0, (BaseDamage / DistanceScaling) - Armor)
```

Grouping expressions can also improve the readability of your code.
