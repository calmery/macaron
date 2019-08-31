port module Electron.WindowControl exposing (WindowControlAction(..), windowControl)

import Electron.Ports as Ports


type WindowControlAction
    = Close
    | Dock
    | Scale


toStringWindowControlAction : WindowControlAction -> String
toStringWindowControlAction windowControlAction =
    case windowControlAction of
        Close ->
            "close"

        Dock ->
            "dock"

        Scale ->
            "scale"


windowControl : WindowControlAction -> Cmd msg
windowControl =
    Ports.windowControl << toStringWindowControlAction
