module Main exposing (..)

import Html.App
import LightsGame exposing(view, init, update)

main = Html.App.beginnerProgram 
  { model = init
  , view = view
  , update = update
  }
