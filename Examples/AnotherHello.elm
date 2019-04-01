module AnotherHello exposing (checkStatus, main, statusChecks)

import Html exposing (..)


checkStatus : Int -> String
checkStatus status =
    if status == 200 then
        "you got it, dude"
    else if status == 404 then
        "page not found"
    else
        "unknown ereponse"


statusChecks : List String
statusChecks =
    [ checkStatus 200
    , checkStatus 404
    , checkStatus 418
    ]


main =
    statusChecks
        |> List.foldl (\n str -> str ++ n) ""
        |> text
