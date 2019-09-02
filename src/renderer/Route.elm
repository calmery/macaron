module Route exposing (Route(..), parseUrl)

import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


parseUrl : Url -> Maybe Route
parseUrl =
    parse route



-- Routing


type Route
    = Today
    | All


route : Parser (Route -> Route) Route
route =
    oneOf
        [ map Today top
        , map All (s "all")
        ]
