module Main exposing (..)

import Html.App
import LightsGame exposing(view, update, initWithDefaultBoard)

main : Program Never
main = Html.App.beginnerProgram 
  { model = initWithDefaultBoard
  , view = view
  , update = update
  }
