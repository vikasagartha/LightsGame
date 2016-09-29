
module Main exposing (..)

import ElmTest as ElmTest
import LightsGame
import Matrix exposing (Matrix)

singleLightBoard = 
    Matrix.fromList [ [True] ]
        |> Maybe.withDefault Matrix.empty

singleRowBoard =
    Matrix.fromList[ [False, False, False] ]
        |> Maybe.withDefault Matrix.empty

squareBoard =
    Matrix.fromList
        [ [False, False, False] 
        , [False, False, False] 
        , [False, False, False] 
        ]
        |> Maybe.withDefault Matrix.empty


all = 
    ElmTest.suite "LightsGame" 
        [   ElmTest.test "can toggle a light"
            ( LightsGame.init singleLightBoard
            |> LightsGame.update (LightsGame.Toggle { x=0, y=0 }) 
            |> .isOn
            |> Matrix.get 0 0 
            |> ElmTest.assertEqual (Just False)
            )
        ,   ElmTest.test "toggling a light toggles its right neighbor"
            ( LightsGame.init singleRowBoard 
            |> LightsGame.update (LightsGame.Toggle { x=0, y=0 })
            |> .isOn
            |> Matrix.get 1 0
            |> ElmTest.assertEqual (Just True)
            )
        ,   ElmTest.test "toggling a light toggles its left neighbor"
            ( LightsGame.init singleRowBoard 
            |> LightsGame.update (LightsGame.Toggle { x=2, y=0 })
            |> .isOn
            |> Matrix.get 1 0
            |> ElmTest.assertEqual (Just True)
            )
        ,   ElmTest.test "toggling a light toggles its upper neighbor"
            ( LightsGame.init squareBoard
            |> LightsGame.update (LightsGame.Toggle { x=1, y=2 })
            |> .isOn
            |> Matrix.get 1 1
            |> ElmTest.assertEqual (Just True)
            )
        ,   ElmTest.test "toggling a light toggles its lower neighbor"
            ( LightsGame.init squareBoard
            |> LightsGame.update (LightsGame.Toggle { x=1, y=1 })
            |> .isOn
            |> Matrix.get 1 0
            |> ElmTest.assertEqual (Just True)
            )
        ,   ElmTest.test "toggling a light does not toggle non neighbors"
            ( LightsGame.init squareBoard
            |> LightsGame.update (LightsGame.Toggle { x=1, y=1 })
            |> .isOn
            |> Matrix.get 0 0
            |> ElmTest.assertEqual (Just False)
            )
        , ElmTest.suite "isSolved"              
            [ ElmTest.test "True when all lights are off" 
                (LightsGame.init squareBoard
                    |> LightsGame.isSolved 
                    |> ElmTest.assertEqual True
                )
            , ElmTest.test "False when some lights are off" 
                (LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x=0, y=0 })
                    |> LightsGame.isSolved 
                    |> ElmTest.assertEqual False
                )
            ]
        ]

main = ElmTest.runSuiteHtml all

