module View exposing (view)

import Browser exposing (Document)
import Electron.WindowControl exposing (WindowControlAction(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Pages.Example as Example
import Pages.NotFound as NotFound
import Pages.Top as Top
import Route exposing (Route(..))
import Update exposing (Msg(..))


view : Model -> Document Msg
view model =
    { title = "Elm App"
    , body =
        [ titleBar
        , container <| viewPage model
        ]
    }


titleBar : Html Msg
titleBar =
    div
        [ id "title-bar" ]
        [ div [ class "window-control-button close", onClick <| WindowControl Close ] []
        , div [ class "window-control-button dock", onClick <| WindowControl Dock ] []
        , div [ class "window-control-button scale", onClick <| WindowControl Scale ] []
        ]


container : Html Msg -> Html Msg
container html =
    div [ id "container" ] [ html ]


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Just route ->
            case route of
                Top ->
                    Top.view model

                Example ->
                    Example.view model

        Nothing ->
            NotFound.view
