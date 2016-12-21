module Books.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Books.Models exposing (..)
import Books.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/books"


collectionDecoder : Decode.Decoder (List Book)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Book
memberDecoder =
    Decode.map5 Book
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "authors" authorsDecoder)
        (field "state" Decode.string)
        (field "history" historyDecoder)


authorsDecoder : Decode.Decoder (List String)
authorsDecoder =
    Decode.list Decode.string


historyDecoder : Decode.Decoder (Maybe (List History))
historyDecoder =
    Decode.maybe (Decode.list historyElementDecoder)


historyElementDecoder : Decode.Decoder History
historyElementDecoder =
    Decode.map3 History
        (field "borrower" Decode.string)
        (field "borrowedAt" Decode.string)
        (field "returnedAt" Decode.string)


saveUrl : BookId -> String
saveUrl bookId =
    "http://localhost:4000/books/" ++ bookId


saveRequest : Book -> Http.Request Book
saveRequest book =
    Http.request
        { body = memberEncoded book |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl book.id
        , withCredentials = False
        }


save : Book -> Cmd Msg
save book =
    saveRequest book
        |> Http.send OnSave


memberEncoded : Book -> Encode.Value
memberEncoded book =
    let
        list =
            [ ( "id", Encode.string book.id )
            , ( "name", Encode.string book.name )
            , ( "state", Encode.string book.state )
            ]
    in
        list
            |> Encode.object
