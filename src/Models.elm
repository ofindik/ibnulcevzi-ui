module Models exposing (..)

import Books.Models exposing (Book)
import Routing


type alias Model =
    { books : List Book
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { books = []
    , route = route
    }
