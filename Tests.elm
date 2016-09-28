
module Main exposing (..)

import Legacy.ElmTest as ElmTest
import LightsGame

all = 
    ElmTest.suite "LightsGame" 
        [   ElmTest.test "can toggle a light"
            ( LightsGame.init [True]
            |> LightsGame.update (LightsGame.Toggle 0) 
            |> .isOn
            |> List.head
            |> ElmTest.assertEqual (Just False)
            )
        ,   ElmTest.test "toggling a light toggles its right neighbor"
            ( LightsGame.init [False, False, False]
            |> LightsGame.update (LightsGame.Toggle 0)
            |> .isOn
            |> ElmTest.assertEqual [True, True, False] 
            )
        ,   ElmTest.test "toggling a light toggles its left neighbor"
            ( LightsGame.init [False, False, False]
            |> LightsGame.update (LightsGame.Toggle 2)
            |> .isOn
            |> ElmTest.assertEqual [False, True, True] 
            )
        ]

main = ElmTest.runSuiteHtml all


