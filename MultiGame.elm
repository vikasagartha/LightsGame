module MultiGame exposing (..)

import LightsGame
import Html
import Html.App

type alias Model =
    { boards : List LightsGame.Model }

init : Model
init =
    { boards =
        [ LightsGame.initWithDefaultBoard "orange"
        , LightsGame.initWithDefaultBoard "blue"
        , LightsGame.initWithDefaultBoard "green"
        ]
    }


--Update 

type Msg = 
    BoardMsg { boardNumber : Int, msg : LightsGame.Msg }


update : Msg -> Model -> Model
update msg model =
    case msg of 
        BoardMsg { boardNumber, msg } ->
            { model |
                boards = updateBoard boardNumber msg model.boards
            }

updateBoard : Int -> LightsGame.Msg -> List LightsGame.Model -> List LightsGame.Model
updateBoard boardNumber msg boards =
    List.indexedMap 
        (\i board ->
            if i == boardNumber then
                LightsGame.update msg board
            else 
                board
        )
        boards

--View 

view : Model -> Html.Html Msg
view model =
    model.boards
        |> List.indexedMap 
            (\i board -> LightsGame.view board 
                |> Html.App.map (\msg -> BoardMsg { boardNumber = i, msg = msg })
            )
        |> Html.div []
