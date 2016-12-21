module Books.Update exposing (..)

import Books.Messages exposing (Msg(..))
import Books.Models exposing (Book, BookId, BookState(..))
import Books.Commands exposing (save)
import Navigation


update : Msg -> List Book -> ( List Book, Cmd Msg )
update message books =
    case message of
        OnFetchAll (Ok newBooks) ->
            ( newBooks, Cmd.none )

        OnFetchAll (Err error) ->
            ( books, Cmd.none )

        ShowBooks ->
            ( books, Navigation.newUrl "#books" )

        ShowBook id ->
            ( books, Navigation.newUrl ("#books/" ++ id) )

        ChangeBookState id ->
            ( books, changeStateCommand id books |> Cmd.batch )

        OnSave (Ok updatedBook) ->
            ( updateBook updatedBook books, Cmd.none )

        OnSave (Err error) ->
            ( books, Cmd.none )


changeStateCommand : BookId -> List Book -> List (Cmd Msg)
changeStateCommand bookId books =
    let
        cmdForBook existingBook =
            if existingBook.id == bookId then
                save
                    { existingBook
                        | state =
                            (if existingBook.state == Borrowed then
                                Available
                             else
                                Borrowed
                            )
                    }
            else
                Cmd.none
    in
        List.map cmdForBook books


updateBook : Book -> List Book -> List Book
updateBook updatedBook books =
    let
        select existingBook =
            if existingBook.id == updatedBook.id then
                updatedBook
            else
                existingBook
    in
        List.map select books
