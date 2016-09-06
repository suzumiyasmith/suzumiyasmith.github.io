module Main exposing (..)

import Html exposing (Html, div)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Markdown
import Note
import Note.N110816


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        angle =
            turns (Time.inMinutes model)

        handX =
            toString (50 + 40 * cos angle)

        handY =
            toString (50 + 40 * sin angle)
    in
        div []
            [ div [] []
            , svg [ viewBox "0 0 100 100", width "300px" ]
                [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
                , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                ]
            , text "hello"
            , Markdown.toHtml [] Note.content
            , Markdown.toHtml [] Note.N110816.content
            ]
