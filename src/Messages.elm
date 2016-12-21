module Messages exposing (..)

import Navigation exposing (Location)
import Books.Messages


type Msg
    = BooksMsg Books.Messages.Msg
    | OnLocationChange Location
