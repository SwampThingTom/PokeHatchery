# PokéHatchery

PokéHatchery is a [Monte Carlo](https://en.wikipedia.org/wiki/Monte_Carlo_method) simulation of
[Pokémon Go](http://www.pokemongo.com) egg hatching. It simulates hatching 10km eggs to determine
the probability curve for how many species of Pokémon remain unhatched.

## Inputs

- **Simulations:** The number of times to run the Monte Carlo simulation. Larger numbers take more time but provide more accurate results.
- **Total Eggs:** The total number of eggs to simulate hatching. This can **either** be the total number of eggs of all distances to hatch as determined by looking at the Breeder achievement; **OR** the total number of 10km eggs to hatch.
- **Egg Drop %:** The percentage of the total eggs hatched that are 10km eggs. Enter 100% for this value if you enter the exact number of 10km eggs to hatch for *Total Eggs*.

Note that the default **Egg Drop %** is based loosely on the data collected in the
[Silph Road's Drop Rate on 10km Eggs](https://www.reddit.com/r/TheSilphRoad/comments/4zhj58/drop_rate_on_10km_eggs/).
It is currently in the 5-6% range.
My personal 10km drop rate is *much* higher.
Since I have been keeping track of egg hatchings, I have hatched 24 10km eggs out of 248 total eggs for a drop rate of almost 10%.

The odds for hatching a given Pokémon from a 10km egg were taken from [Nether Fable's PGO Egg Hatch Distribution](https://netherfable.com/pgo-egg-hatch-distribution/) data in late August 2016.
The data was taken before the changes Niantic made to egg hatching in November.
This should make the data accurate for most of the eggs most long-time Pokémon Go players have hatched
but not for players who started shortly before or after those changes were made.

## Assumptions

- The data collected by Nether Fable accurately represents actual egg hatching.
- Odds for hatching Pokémon of a given species is fixed and not tied to the player's level or the region where the egg is found or hatched.

## Future Enhancements

- Support for 2km and 5km eggs
- Configure the likelihood of hatching a Pokémon of a given species
