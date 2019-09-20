module View exposing (view)

import Browser exposing (Document)
import Electron.WindowControl exposing (WindowControlAction(..))
import Html exposing (Html, a, div, nav, span, text)
import Html.Attributes exposing (class, href, id)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Pages.All as All
import Pages.NotFound as NotFound
import Pages.Today as Today
import Pages.Trash as Trash
import Route exposing (Route(..))
import Update exposing (Msg(..))


view : Model -> Document Msg
view model =
    { title = "Elm App"
    , body =
        [ div
            [ class
                (if model.ui.menuIsOpen then
                    ""

                 else
                    "menu-hidden"
                )
            ]
            [ titleBar
            , navigation model
            , viewPage model
            ]
        ]
    }


titleBar : Html Msg
titleBar =
    div
        [ id "title-bar" ]
        [ div [ class "window-control-button close", onClick <| WindowControl Close ] []
        , div [ class "window-control-button dock", onClick <| WindowControl Dock ] []
        , div [ class "window-control-button scale", onClick <| WindowControl Scale ] []
        , div [ class "menu-control-button", onClick MenuToggle ]
            [ div [ class "icon" ]
                []
            , div
                [ class "text" ]
                [ text "Today" ]
            ]
        ]


navigation : Model -> Html Msg
navigation model =
    nav
        []
        [ menu (model.route == Just Today) "/#/" "e" "Today"
        , menu (model.route == Just All) "/#/all" "d" "All"
        , separater
        , menu (model.route == Just Trash) "/#/trash" "l" "Trash"
        , addTodo
        ]


separater =
    div [ class "separater" ] []


menu active url icon string =
    a [ href url ]
        [ div
            [ class
                ("menu"
                    ++ (if active then
                            " active"

                        else
                            ""
                       )
                )
            ]
            [ span [] [ text icon ], text string ]
        ]


addTodo : Html Msg
addTodo =
    div
        [ class "menu add-task" ]
        [ span [] [ text "ï" ], text "Add Task" ]


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Just route ->
            case route of
                Today ->
                    Today.view model

                All ->
                    All.view model

                Trash ->
                    Trash.view model

        Nothing ->
            NotFound.view
