module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Books.Details
import Books.List
import Books.Models exposing (BookId)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        BooksRoute ->
            Html.map BooksMsg (Books.List.view model.books)

        BookRoute id ->
            bookDetailsPage model id

        NotFoundRoute ->
            notFoundView


bookDetailsPage : Model -> BookId -> Html Msg
bookDetailsPage model bookid =
    let
        maybeBook =
            model.books
                |> List.filter (\book -> book.id == bookid)
                |> List.head
    in
        case maybeBook of
            Just book ->
                Html.map BooksMsg (Books.Details.view book)

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
