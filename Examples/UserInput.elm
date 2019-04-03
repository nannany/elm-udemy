module UserInput exposing (Model, main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, view = view, update = update }


type alias Model =
    { text : String }


init : Model
init =
    { text = "" }


type Msg
    = Text String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text txt ->
            { model | text = txt }



-- bigText : Attribute msg
-- bigText =
--     style "fontSize" "20em"
-- smallText : Attribute msg
-- smallText =
--     style "fontSize" "10em"
-- checkTextSize : String -> Attribute msg
-- checkTextSize str =
--     if String.length str < 8 then
--         bigText
--     else
--         smallText


adjustSize : Model -> Attribute msg
adjustSize { text } =
    let
        ( size, color ) =
            if String.length text < 8 then
                ( "20em", "goldenrod" )

            else
                ( "10em", "seashell" )
    in
    style "fontSize" size


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Type text heerwe", onInput Text ] []
        , div [ adjustSize model ] [ text model.text ]
        ]
