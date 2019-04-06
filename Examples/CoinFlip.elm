module CoinFlip exposing (Model, main)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



--model


type alias Model =
    { side : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Heads", Cmd.none )



--messges


type Msg
    = StartFlip
    | GenerateFlip Bool



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip (Random.weighted ( 50, True ) [ ( 50, False ) ]) )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )


generateSide : Bool -> String
generateSide bool =
    if bool then
        "heads"

    else
        "tails"



--subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- veiw


view : Model -> Html Msg
view model =
    div []
        [ text ("the result is:" ++ model.side)
        , div []
            [ button [ onClick StartFlip ] [ text "Flip" ]
            ]
        ]
