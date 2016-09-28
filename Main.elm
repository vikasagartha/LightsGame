module Main exposing (..)

import Html.App
import LightsGame exposing(view, init, update, defaultBoard)

main : Program Never
main = Html.App.beginnerProgram 
  { model = init defaultBoard
  , view = view
  , update = update
  }
