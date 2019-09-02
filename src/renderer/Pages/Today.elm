module Pages.Today exposing (view)

import Html exposing (Html, a, main_, text)
import Html.Attributes exposing (alt, href, src, style)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    main_ []
        [ a [ href "/#/all" ] [ text "All" ]
        ]
