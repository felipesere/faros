import Html exposing (..)
import Html.Attributes exposing (..)
import String

port csrf : String

main : Html
main =
  let
    welcome =
      [ section
          []
          [ h1 [] [ text "Welcome to Faros" ]
          , p [] [ text "Life is hard..." ]
          ]
      ]
  in
    layout welcome

layout : List Html -> Html
layout inner =
  div
    []
    [ header
    , main' [] inner
    ]

menuItems : List (String, String)
menuItems =
  [("☀", "/"), ("Books", "/books"), ("Papers", "/papers")]

header : Html
header =
  let
    toA = \(name, link) -> a [ href link ] [ text name ]
    toLi = \x -> li [] [ x ]
    lis = List.map (toA >> toLi) menuItems
  in
    Html.header
     []
     [ nav [] [ ul [] lis ]
     , searchForm
     ]

searchForm : Html
searchForm =
  Html.form
    [ action "/search"
    , method "POST"
    ]
    [ input
        [ placeholder "To search, press s"
        , name "query"
        ]
        []
    , input
        [ type' "hidden"
        , name "_csrf_token"
        , value csrf
        ]
        []
    , button [] [ text "Go" ]
    ]
