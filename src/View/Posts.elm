module View.Posts exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, href, id, checked, selected, type_)
import Html.Events
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time
import Util.Time


{-| Show posts as a HTML [table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)

Relevant local functions:

  - Util.Time.formatDate
  - Util.Time.formatTime
  - Util.Time.formatDuration (once implemented)
  - Util.Time.durationBetween (once implemented)

Relevant library functions:

  - [Html.table](https://package.elm-lang.org/packages/elm/html/latest/Html#table)
  - [Html.tr](https://package.elm-lang.org/packages/elm/html/latest/Html#tr)
  - [Html.th](https://package.elm-lang.org/packages/elm/html/latest/Html#th)
  - [Html.td](https://package.elm-lang.org/packages/elm/html/latest/Html#td)

-}
postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable config now posts =
    let
        filtered =
            filterPosts config posts

        header =
            Html.tr []
                [ Html.th [] [ text "Score" ]
                , Html.th [] [ text "Title" ]
                , Html.th [] [ text "Type" ]
                , Html.th [] [ text "Posted" ]
                , Html.th [] [ text "Link" ]
                ]

        row post =
            Html.tr []
                [ Html.td [ class "post-score" ] [ text (String.fromInt post.score) ]
                , Html.td [ class "post-title" ] [ text post.title ]
                , Html.td [ class "post-type" ] [ text post.type_ ]
                , Html.td [ class "post-time" ]
                    [ let
                          absolute =
                            Util.Time.formatTime Time.utc post.time

                          relative =
                            case Util.Time.durationBetween post.time now of
                                Nothing ->
                                  ""

                                Just d ->
                                  " (" ++ Util.Time.formatDuration d ++ ")"
                      in
                      text (absolute ++ relative)
                    ]
                , Html.td [ class "post-url" ]
                    [ Html.a [ href (Maybe.withDefault "#" post.url) ] [ text "link" ] ]
                ]
    in
    Html.table []
        (header :: List.map row filtered)



{-| Show the configuration options for the posts table

Relevant functions:

  - [Html.select](https://package.elm-lang.org/packages/elm/html/latest/Html#select)
  - [Html.option](https://package.elm-lang.org/packages/elm/html/latest/Html#option)
  - [Html.input](https://package.elm-lang.org/packages/elm/html/latest/Html#input)
  - [Html.Attributes.type\_](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_)
  - [Html.Attributes.checked](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#checked)
  - [Html.Attributes.selected](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#selected)
  - [Html.Events.onCheck](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onCheck)
  - [Html.Events.onInput](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onInput)

-}
postsConfigView : PostsConfig -> Html Msg
postsConfigView config =
    Html.div []
        [ Html.label [] [ text "Posts per page: " ]
        , Html.select 
            [ Html.Attributes.id "select-posts-per-page" 
            , Html.Events.onInput (\v -> ConfigChanged (ChangePostsToShow (String.toInt v |> Maybe.withDefault 10)))
            ]
            [ Html.option [ Html.Attributes.selected (config.postsToShow == 10) ] [ text "10" ]
            , Html.option [ Html.Attributes.selected (config.postsToShow == 25) ] [ text "25" ]
            , Html.option [ Html.Attributes.selected (config.postsToShow == 50) ] [ text "50" ]
            ]

        , Html.div [] []

        , Html.label [] [ text "Sort by: " ]
        , Html.select
            [ Html.Attributes.id "select-sort-by" 
            , Html.Events.onInput (\v ->
                case sortFromString v of 
                     Just s ->
                         ConfigChanged (ChangeSortBy s)

                     Nothing ->
                         ConfigChanged (ChangeSortBy None)
                 )
            ]
            (List.map
                (\sort ->
                    Html.option
                        [ Html.Attributes.selected (sort == config.sortBy) ]
                        [ text (sortToString sort) ]
                )
                sortOptions
            )

        , Html.div [] []

        , Html.label []
            [ Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "checkbox-show-job-posts"
                , Html.Attributes.checked config.showJobs
                , Html.Events.onCheck (\flag -> ConfigChanged (ChangeShowJobs flag))
                ]
                []
            , text " Show job posts"
            ]

        , Html.div [] []

        , Html.label []
            [ Html.input
                [ Html.Attributes.type_ "checkbox"
                , Html.Attributes.id "checkbox-show-text-only-posts"
                , Html.Attributes.checked config.showTextOnly
                , Html.Events.onCheck (\flag -> ConfigChanged (ChangeShowTextOnly flag))
                ]
                []
            , text " Show text-only posts"
            ]
        ]
