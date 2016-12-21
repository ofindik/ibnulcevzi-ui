module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Books.Update
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BooksMsg subMsg ->
            let
                ( updatedBooks, cmd ) =
                    Books.Update.update subMsg model.books
            in
                ( { model | books = updatedBooks }, Cmd.map BooksMsg cmd )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
