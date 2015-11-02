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

header : Html
header =
  let
    menuItems = ["Books", "Papers"]
    asLink = \x -> "/" ++ (String.toLower x)
    toA = \x -> a [ href <| asLink x ] [ text x]
    toLi = \x -> li [] [ toA x ]
  in
    Html.header
     []
     [ a [] [ text "☀" ]
     , nav
         []
         [ ul [] List.map toLi menuItems ]
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
