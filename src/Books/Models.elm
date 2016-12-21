module Books.Models exposing (..)


type alias BookId =
    String


type alias Book =
    { id : BookId
    , name : String
    , authors : List String
    , state : String
    , history : Maybe (List History)
    }


type alias History =
    { borrower : String
    , borrowedAt : String
    , returnedAt : String
    }


new : Book
new =
    { id = "0"
    , name = ""
    , authors = [ "" ]
    , state = ""
    , history = Nothing
    }
