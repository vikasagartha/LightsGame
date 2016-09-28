
module Main exposing (..)

import Legacy.ElmTest as ElmTest

all = 
    ElmTest.suite "LightsGame" []

main = ElmTest.runSuiteHtml all


