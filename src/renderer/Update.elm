module Update exposing (Msg(..), update)

import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (load, pushUrl)
import Electron.WindowControl exposing (WindowControlAction, windowControl)
import Model exposing (Model)
import Route exposing (parseUrl)
import Url exposing (Url)


type Msg
    = LinkClicked UrlRequest
    | UrlChanged Url
    | WindowControl WindowControlAction
    | MenuToggle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, pushUrl model.key (Url.toString url) )

                External href ->
                    ( model, load href )

        UrlChanged url ->
            let
                route =
                    parseUrl url
            in
            ( { model | route = route }
            , Cmd.none
            )

        WindowControl windowControlAction ->
            ( model, windowControl windowControlAction )

        MenuToggle ->
            let
                ui =
                    model.ui

                updatedUiModel =
                    { ui | menuIsOpen = not model.ui.menuIsOpen }
            in
            ( { model | ui = updatedUiModel }, Cmd.none )
