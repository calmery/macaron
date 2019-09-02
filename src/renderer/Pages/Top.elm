module Pages.Top exposing (view)

import Html exposing (Html, main_, text)
import Html.Attributes exposing (alt, href, src, style)
import Model exposing (Model)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    -- https://dequeuniversity.com/rules/axe/2.2/bypass?application=lighthouse
    main_ []
        [ text "Hello World"
        ]
