module Pages.Trash exposing (view)

import Html exposing (Html, main_, text)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    main_
        []
        [ text "Trash"
        ]
