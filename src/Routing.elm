module Routing exposing (..)

import Navigation exposing (Location)
import Books.Models exposing (BookId)
import UrlParser exposing (..)


type Route
    = BooksRoute
    | BookRoute BookId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map BooksRoute top
        , map BookRoute (s "books" </> string)
        , map BooksRoute (s "books")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
