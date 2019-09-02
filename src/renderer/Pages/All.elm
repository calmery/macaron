module Pages.All exposing (view)

import Html exposing (Html, a, main_, text)
import Html.Attributes exposing (href)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    main_
        []
        [ a [ href "/#/" ] [ text "Today" ]
        ]
