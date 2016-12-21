module Books.Messages exposing (..)

import Http
import Books.Models exposing (BookId, Book)


type Msg
    = OnFetchAll (Result Http.Error (List Book))
    | ShowBooks
    | ShowBook BookId
    | ChangeBookState BookId
    | OnSave (Result Http.Error Book)
