module Guess exposing (Model, main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, view = view, update = update }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : { pos : Int, text : String }
    , result : String
    }


init : Model
init =
    Model "Saturday" "" { pos = 2, text = "S" } ""


type Msg
    = Answer String
    | Reveal
    | Check


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealAndIncrement model }

        Check ->
            { model | result = checkResult model }


checkResult : Model -> String
checkResult { word, guess } =
    if word == guess then
        "you got it"

    else
        "nope"


revealAndIncrement : Model -> { pos : Int, text : String }
revealAndIncrement { revealedWord, word } =
    if revealedWord.text == word then
        revealedWord

    else
        { revealedWord | pos = revealedWord.pos + 1, text = String.slice 0 revealedWord.pos word }


genResult : Model -> Html Msg
genResult { result } =
    if String.length result < 1 then
        div [] []

    else if result == "nope" then
        div [ style "color" "tomato" ] [ text result ]

    else
        div [ style "color" "forestgreen" ] [ text result ]


view : Model -> Html Msg
view model =
    div []
        [ h2 []
            [ text
                ("im thinking of a word that starts with"
                    ++ model.revealedWord.text
                    ++ " that has "
                    ++ String.fromInt (String.length model.word)
                    ++ " letters."
                )
            ]
        , input [ placeholder "type yorr guess", onInput Answer ] []
        , button [ onClick Reveal ] [ text "hint button" ]
        , button [ onClick Check ] [ text "submit answer" ]
        , genResult model
        ]



-- revealLetter : Model -> String
-- revealLetter model =
--     if String.length model.word == String.length model.revealedWord then
--         model.word
--     else
--         String.slice 0 model.revealedPos model.word
-- checkIfCorrect : Model -> String -> Bool
-- checkIfCorrect model txt =
--     if txt == model.word then
--         True
--     else
--         False
-- generateResult : Model -> Html Msg
-- generateResult { isCorrect, revealedWord, word } =
--     let
--         txt =
--             if revealedWord.text == word then
--                 "yout didnt guess"
--             else if isCorrect then
--                 "You got it"
--             else
--                 "Nope"
--     in
--     text txt
