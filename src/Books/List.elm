module Books.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Books.Messages exposing (..)
import Books.Models exposing (Book)


view : List Book -> Html Msg
view books =
    div []
        [ nav books
        , list books
        ]


nav : List Book -> Html Msg
nav books =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Engineering Library" ] ]


list : List Book -> Html Msg
list books =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Authors" ]
                    , th [] [ text "State" ]
                    ]
                ]
            , tbody [] (List.map bookRow books)
            ]
        ]


bookRow : Book -> Html Msg
bookRow book =
    tr []
        [ td [] [ text book.id ]
        , td [] [ text book.name ]
        , td [] [ ul [] (List.map (\a -> li [] [ text a ]) book.authors) ]
        , td [] [ text book.state ]
        , td [] [ detailsButton book ]
        ]


detailsButton : Book -> Html Msg
detailsButton book =
    button
        [ class "btn regular"
        , onClick (ShowBook book.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Details" ]
