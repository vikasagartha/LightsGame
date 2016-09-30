module LightsGame exposing(Msg(..), Model, update, view, init, isSolved, initWithDefaultBoard)

import Array
import Matrix exposing (Matrix)
import Html
import Html.Attributes
import Html.Events

type alias Model = 
    { isOn : Matrix (Maybe Bool) }

init : Matrix (Maybe Bool) -> Model
init startingBoard = 
    { isOn = startingBoard }
        |> update (Toggle {x=0,y=0})
        |> update (Toggle {x=0,y=0})
        |> update (Toggle {x=0,y=0})
        |> update (Toggle {x=0,y=0})

initWithDefaultBoard : Model 
initWithDefaultBoard = 
    { isOn = 
        Matrix.repeat 6 6 (Just False) 
            |> Matrix.set 4 3 Nothing     
            |> Matrix.set 2 2 Nothing     
    }
        |> update (Toggle {x=0,y=0})
        |> update (Toggle {x=2,y=0})
        |> update (Toggle {x=1,y=4})
        |> update (Toggle {x=4,y=2})
        |> update (Toggle {x=5,y=0})
        |> update (Toggle {x=0,y=2})
        |> update (Toggle {x=1,y=1})

isSolved : Model -> Bool
isSolved model =
    let 
        isOn maybeIsOn =
            maybeIsOn
                |> Maybe.withDefault False
        onLights = Matrix.filter isOn model.isOn
    in 
        Array.isEmpty onLights

--Update

type alias LightIndex = 
    { x : Int, y : Int }

type Msg = 
    Toggle LightIndex 

update : Msg -> Model -> Model
update msg model = 
    case msg of
        Toggle indexToToggle ->
            { model | isOn = toggleLight indexToToggle model.isOn }

toggleLight : LightIndex -> Matrix (Maybe Bool) -> Matrix (Maybe Bool)
toggleLight indexToToggle matrix =
    let 
        toggleMaybeBool maybeBool =
            Maybe.map not maybeBool
    in
        matrix
            |> Matrix.update indexToToggle.x indexToToggle.y toggleMaybeBool
            |> Matrix.update (indexToToggle.x + 1) indexToToggle.y toggleMaybeBool
            |> Matrix.update (indexToToggle.x - 1) indexToToggle.y toggleMaybeBool
            |> Matrix.update indexToToggle.x (indexToToggle.y + 1) toggleMaybeBool
            |> Matrix.update indexToToggle.x (indexToToggle.y - 1) toggleMaybeBool

--View 

view : Model -> Html.Html Msg
view model =
    Html.div [] 
        [ if isSolved model then 
            Html.text "You're a winner"
          else 
              gameView model
        , Html.hr [] []
        , Html.p [] [ Html.text <| toString model.isOn ]
        ]

gameView : Model -> Html.Html Msg
gameView model =
    model.isOn 
        |> Matrix.indexedMap lightButton
        |> matrixToDivs

matrixToDivs : Matrix (Html.Html Msg) -> Html.Html Msg
matrixToDivs matrix = 
    let 
        makeRow y = 
            Matrix.getRow y matrix
                |> Maybe.map (Array.toList) 
                |> Maybe.withDefault [] 
                |> Html.div [] 
        height = Matrix.height matrix
    in
        List.map makeRow [0..height]
            |> Html.div []

lightButton : Int -> Int -> Maybe Bool -> Html.Html Msg
lightButton x y isOn = 
    case isOn of 
        Nothing ->
            Html.div
                [ Html.Attributes.style
                    [ ("width", "40px")
                    , ("height", "40px")
                    , ("border-radius", "4px")
                    , ("margin", "2px")
                    , ("display", "inline-block")
                    ]
                ]
                []
        Just isOn ->
            Html.div
                [ Html.Attributes.style
                    [ ("background-color"
                      , if isOn then
                            "orange"
                        else 
                            "grey"
                      )
                    , ("width", "40px")
                    , ("height", "40px")
                    , ("border-radius", "4px")
                    , ("margin", "2px")
                    , ("display", "inline-block")
                    ]
                , Html.Events.onClick (Toggle { x = x, y = y})
                ]
                []
