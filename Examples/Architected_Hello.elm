module ArchitectedHello exposing (main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, view = view, update = update }



-- this is what our model should look like


type alias Model =
    { text : String }


init : Model
init =
    { text = "hello world" }



-- only need one kind of message


type Msg
    = Text



-- update function only has to worry about one possible case


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }


myStyle : Attribute msg
myStyle =
    style "color" "teal" 



--view


view : Model -> Html Msg
view model =
    div []
        [ div [ myStyle ] [ text model.text ]
        , button [ onClick Text ] [ text "add exclamation mark" ]
        ]
