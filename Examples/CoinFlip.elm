module CoinFlip exposing (Model, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src, style)
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
    { side : String
    , number : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Heads" 0, Cmd.none )



--messges


type Msg
    = StartFlip
    | GenerateFlip Bool
    | GetNum
    | GenerateNum Int



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip (Random.weighted ( 50, True ) [ ( 50, False ) ]) )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )

        GetNum ->
            ( model, Random.generate GenerateNum (Random.int 1 100) )

        GenerateNum num ->
            ( { model | number = num }, Cmd.none )


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


getImage : Model -> Attribute msg
getImage model =
    let
        imgURL =
            if model.side == "heads" then
                "../images/heads.jpeg"

            else
                "../images/tails.jpeg"
    in
    src imgURL


view : Model -> Html Msg
view model =
    div
        [ style "fontsize" "4em"
        , style "textAlign" "center"
        ]
        [ img
            [ getImage model
            , style "height" "100px"
            , style "width" "150px"
            ]
            []
        , br [] []
        , text ("the result is:" ++ model.side)
        , div []
            [ button [ onClick StartFlip ] [ text "Flip" ]
            ]
        , div [] 
            [
                text ("random number is: " ++ String.fromInt model.number)
                , br [] [] 
                , button [onClick GetNum] [ text "Generate number"]
            ]
        ]
