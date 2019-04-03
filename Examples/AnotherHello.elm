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


renderList : List String -> Html msg
renderList lst =
    lst
        |> List.map (\l -> li [] [ text l ])
        |> ul []


createLi : String -> Html msg
createLi str =
    li [] [ text str ]


main =
    div []
        [ h1 [] [ text "List of statuses:" ]
        , renderList statusChecks
        ]
