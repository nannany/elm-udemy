module ArchitectedHello exposing (main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }



-- this is what our model should look like


type alias Model =
    { text : String
    , size : Int
    }


init : Model
init =
    { text = "hello world"
    , size = 1
    }



-- only need one kind of message


type Msg
    = Text
    | SizeUp
    | SizeDown
    | RemoveExcl



-- update function only has to worry about one possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }

        SizeUp ->
            { model
                | size = model.size + 1
            }

        SizeDown ->
            { model
                | size = sizeChecker model.size
            }

        RemoveExcl ->
            { model
                | text = exclChecker model.text
            }


exclChecker : String -> String
exclChecker txt =
    if String.endsWith "!" txt then
        String.dropRight 1 txt

    else
        txt


sizeChecker : Int -> Int
sizeChecker size =
    if size <= 1 then
        size

    else
        size - 1


myStyle : Int -> Attribute msg
myStyle size =
    style "fontSize" (String.fromInt size ++ "em")



--view


view : Model -> Html Msg
view model =
    div []
        [ div [ myStyle model.size ] [ text model.text ]
        , button [ onClick Text ] [ text "add exclamation mark" ]
        , button [ onClick RemoveExcl ] [ text "Remove excl mark" ]
        , button [ onClick SizeUp ] [ text "+" ]
        , button [ onClick SizeDown ] [ text "-" ]
        ]
