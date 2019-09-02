module View exposing (view)

import Browser exposing (Document)
import Electron.WindowControl exposing (WindowControlAction(..))
import Html exposing (Html, div, nav, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Pages.All as All
import Pages.NotFound as NotFound
import Pages.Today as Today
import Route exposing (Route(..))
import Update exposing (Msg(..))


view : Model -> Document Msg
view model =
    { title = "Elm App"
    , body =
        [ titleBar
        , navigation model
        , viewPage model
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


navigation : Model -> Html Msg
navigation model =
    nav [] []


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Just route ->
            case route of
                Today ->
                    Today.view model

                All ->
                    All.view model

        Nothing ->
            NotFound.view
