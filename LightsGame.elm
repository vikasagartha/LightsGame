module LightsGame exposing(Model, update, view, init)

import Html
import Html.Attributes
import Html.Events

type alias Model = 
    { isOn : Bool }

init = 
    { isOn = True }

type Msg = Toggle

update msg model = 
    case msg of
        Toggle ->
            { model | isOn = not model.isOn }

--View 

view model =
    Html.div [] 
        [ lightButton model.isOn 
        , lightButton model.isOn 
        , Html.hr [] []
        , Html.pre [] [ Html.text <| toString model.isOn ]
        ]

lightButton isOn = 
    Html.div
        [ Html.Attributes.style
            [ ("background-color"
              , if isOn then
                    "orange"
                else 
                    "grey"
              )
            , ("width", "80px")
            , ("height", "80px")
            , ("border-radius", "4px")
            , ("margin", "2px")
            ]
        , Html.Events.onClick Toggle
        ]
        []
