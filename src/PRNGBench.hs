module PRNGBench
 where

import System.Random (RandomGen)

import Criterion.Main (Benchmark, defaultMain)

import PRNGBench.GenList (SomeGen(SG), AnnotatedGen, AnnotatedGenList)

import PRNGBench.SimpleBattery
import PRNGBench.MC

benchGroups :: [AnnotatedGenList -> Benchmark]
benchGroups = [manyRandomsBenchGroup, manySplitsBenchGroup, runCircleMCBattery]

genToAnnotatedGen :: RandomGen g => String -> g -> AnnotatedGen
genToAnnotatedGen name g = (name, SG g)

runGroups :: AnnotatedGenList -> IO ()
runGroups gens = defaultMain $ map (\b -> b gens) benchGroups
