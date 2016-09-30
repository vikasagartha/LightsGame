module Main exposing (..)

import Html.App
import MultiGame

main : Program Never
main = Html.App.beginnerProgram 
  { model = MultiGame.init
  , view = MultiGame.view
  , update = MultiGame.update
  }
