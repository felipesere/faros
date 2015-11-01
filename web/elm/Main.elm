import Html exposing (..)
import Html.Attributes exposing (..)
import String

port csrf : String

main : Html
main =
  div
    []
    [ navigation
    , main'
      []
      [ section
        []
        [ h1 [] [ text "Welcome to Faros" ]
        , p [] [ text "Life is hard..." ]
        ]
      ]
    ]

navigation : Html
navigation =
  header
    []
    [ a [] [ text "☀" ]
    , nav [] [ ulFrom ["Books", "Papers"] ]
    , Html.form
      [ action "/search"
      , method "POST" ]
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
    ]

ulFrom : List String -> Html
ulFrom elements =
  let
    toA = \x -> a [ href <| asLink x ] [ text x]
    toLi = \x -> li [] [ toA x ]
    lis = List.map toLi elements
  in
    ul [] lis

asLink : String -> String
asLink name =
  "/" ++ (String.toLower name)
