module Pages.Today exposing (view)

import Html exposing (Html, a, div, h1, h2, main_, text)
import Html.Attributes exposing (alt, class, href, src, style)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    main_ []
        [ h1
            []
            [ text "Today" ]
        , div [ class "container hidden" ]
            [ div [ class "header" ]
                [ div [ class "toggle" ] []
                , h2
                    []
                    [ text "Ready" ]
                ]
            , div
                [ class "todo expired" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Reply to an email" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            , div
                [ class "todo" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Take the minutes" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            , div
                [ class "todo" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Write a blog" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            ]
        , div [ class "container" ]
            [ div [ class "header" ]
                [ div [ class "toggle" ] []
                , h2
                    []
                    [ text "Doing" ]
                ]
            , div
                [ class "todo" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Make meeting materials" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            ]
        , div [ class "container" ]
            [ div [ class "header" ]
                [ div [ class "toggle" ] []
                , h2
                    []
                    [ text "Done" ]
                ]
            , div
                [ class "todo done" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Call a business partner" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            , div
                [ class "todo expired done" ]
                [ div [ class "strike" ] []
                , div [ class "warning" ] [ text "Expired" ]
                , div [ class "text" ] [ text "Set up new desktop computer" ]
                , div [ class "priority" ] [ text "è" ]
                ]
            ]
        ]
