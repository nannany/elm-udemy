module MouseClicker exposing (main)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Events exposing (onClick)
import Json.Decode exposing (..)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 0, Cmd.none )



-- decoder


decoder : Decoder MouseMoveData
decoder =
    map2 MouseMoveData
        (at [ "pageX" ] int)
        (at [ "pageY" ] int)


type alias MouseMoveData =
    { pageX : Int
    , pageY : Int
    }



-- Messages


type Msg
    = MouseMessage MouseMoveData



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMessage position ->
            ( { model | x = position.x, y = position.y }, Cmd.none )



-- subscription


subscriptions : Sub Msg
subscriptions =
    onClick MouseMessage



--view


view : Model -> Html Msg
view model =
    div []
        [ text
            ("position x is : "
                ++ String.fromInt model.x
                ++ " and Y is : "
                ++ String.fromInt model.y
            )
        ]
