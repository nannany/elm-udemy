module Guess exposing (Model, main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, view = view, update = update }


type alias RevealedWord =
    { pos : Int, text : String }


type alias Result =
    { text : String, isCorrect : Bool }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : RevealedWord
    , result : Result
    , wordList : List String
    }


initialWordList : List String
initialWordList =
    [ "Banana", "Kitten", "paperclip", "orangutan", "italic", "afternoo" ]


init : Model
init =
    Model "Saturday" "" { pos = 2, text = "S" } { text = "", isCorrect = False } initialWordList


type Msg
    = Answer String
    | Reveal
    | Check
    | Another


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealAndIncrement model }

        Check ->
            { model | result = checkResult model }

        Another ->
            let
                newWord =
                    getNewWord model
            in
            { model
                | word = newWord
                , guess = ""
                , revealedWord = { pos = 2, text = String.slice 0 1 newWord }
                , wordList = List.drop 1 model.wordList
            }


getNewWord : Model -> String
getNewWord {wordList, word} =
    wordList 
        |>  List.filter (\a -> a /= word) 
        |> List.take 1
        |> String.concat


checkResult : Model -> Result
checkResult { word, guess, result } =
    if String.toLower word == String.toLower guess then
        { result | text = "you got it ", isCorrect = True }

    else
        { result | text = "nope", isCorrect = False }


revealAndIncrement : Model -> RevealedWord
revealAndIncrement { revealedWord, word } =
    if revealedWord.text == word then
        revealedWord

    else
        { revealedWord | pos = revealedWord.pos + 1, text = String.slice 0 revealedWord.pos word }


genResult : Model -> Html Msg
genResult { result } =
    if String.isEmpty result.text then
        div [] []

    else
        let
            color =
                if result.isCorrect then
                    "tomato"

                else
                    "forestgreen"
        in
        div [ style "color" color ] [ text result.text ]


mainStyle : Attribute msg
mainStyle =
    style "fontFamily" "monospace"


view : Model -> Html Msg
view model =
    div [ mainStyle ]
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
        , p []
            [ button [ onClick Reveal ] [ text "hint button" ]
            , button [ onClick Check ] [ text "submit answer" ]
            , button [ onClick Another ] [ text "another word " ]
            ]
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
