module Books.Details exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, style)
import Html.Events exposing (onClick)
import Books.Messages exposing (..)
import Books.Models exposing (..)


view : Book -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Book -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listButton ]


listButton : Html Msg
listButton =
    button
        [ class "btn regular"
        , onClick ShowBooks
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]


form : Book -> Html Msg
form book =
    div [ class "m3" ]
        [ h1 [] [ text book.name ]
        , changeBookStateButton book
        , formLevel book
        ]


formLevel : Book -> Html Msg
formLevel book =
    div []
        [ showAuthors book
        , showState book
        , showHistoryList book.history
        ]


showAuthors : Book -> Html Msg
showAuthors book =
    div []
        [ h3 [] [ text "Authors" ]
        , div [] [ ul [] (List.map (\a -> li [] [ text a ]) book.authors) ]
        ]


showState : Book -> Html Msg
showState book =
    div []
        [ h3 [] [ text "State" ]
        , div [] [ text (toString book.state) ]
        ]


changeBookStateButton : Book -> Html Msg
changeBookStateButton book =
    div []
        [ button
            [ class "btn regular"
            , onClick (ChangeBookState book.id)
            ]
            [ i [ class "fa fa-book fa-fw" ] []
            , text
                (if (book.state == Available) then
                    "Borrow"
                 else
                    "Return"
                )
            ]
        ]


showHistoryList : Maybe (List History) -> Html Msg
showHistoryList historyList =
    case historyList of
        Just historyList ->
            div []
                [ h3 [] [ text "History" ]
                , table []
                    [ thead []
                        [ tr []
                            [ th [] [ text "Borrower" ]
                            , th [] [ text "Borrowed At" ]
                            , th [] [ text "Returned At" ]
                            ]
                        ]
                    , tbody [] (List.map showHistory historyList)
                    ]
                ]

        Nothing ->
            div [] []


showHistory : History -> Html Msg
showHistory history =
    tr []
        [ td [] [ text history.borrower ]
        , td [] [ text history.borrowedAt ]
        , td [] [ text history.returnedAt ]
        ]
