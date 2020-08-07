module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Random


type Model
    = NothingSelected
    | Loading
    | Selected Recipe


type alias Recipe =
    { vegetable : Vegetable
    , fruit : Fruit
    , crunch : Crunch
    , acid : Acid
    }


type alias Vegetable =
    String


type alias Crunch =
    String


type alias Fruit =
    String


type alias Acid =
    String


initialModel : a -> ( Model, Cmd Msg )
initialModel _ =
    ( NothingSelected, Cmd.none )


type Msg
    = Generate
    | SelectRecipe Recipe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Generate ->
            ( Loading, Random.generate SelectRecipe getRecipe )

        SelectRecipe recipe ->
            ( Selected recipe, Cmd.none )


view : Model -> Html Msg
view model =
    div
        [ Attr.style "text-align" "center"
        , Attr.style "font-family" "Helvetica, Arial"
        ]
        [ Html.h1 [] [ text "Yotam Ottolenghi Recipe Generator" ]
        , div []
            [ viewModel model ]
        ]


viewModel : Model -> Html Msg
viewModel model =
    case model of
        NothingSelected ->
            button [ onClick Generate ] [ text "Show me a recipe" ]

        Loading ->
            text "Loading..."

        Selected recipe ->
            div []
                [ viewRecipe recipe
                , Html.br [] []
                , button [ onClick Generate ] [ text "Show me another one" ]
                ]


viewRecipe : Recipe -> Html Msg
viewRecipe recipe =
    div []
        [ text "Take some "
        , text recipe.vegetable
        , Html.br [] []
        , text "Add some "
        , text recipe.fruit
        , Html.br [] []
        , text "Top with "
        , text recipe.crunch
        , text " and a dash of "
        , text recipe.acid
        , Html.br [] []
        , text "Sea salt and black pepper to taste"
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = initialModel
        , subscriptions = \_ -> Sub.none
        , view = view
        , update = update
        }



-- DATA


getRecipe : Random.Generator Recipe
getRecipe =
    Random.map4
        Recipe
        getVegetable
        getFruit
        getCrunch
        getAcid


getVegetable : Random.Generator Vegetable
getVegetable =
    Random.uniform
        "steamed tenderstem broccoli"
        [ "roasted cauliflower steaks"
        , "butternut squash, roasted"
        , "large red peppers"
        , "celery sticks, cut into 1cm cubes"
        , "smashed avocado"
        , "sweet potato, diced and roasted"
        , "roasted pumpkin wedges"
        , "small turnips, roasted"
        , "small aubergines"
        , "candy beetroot"
        ]


getFruit : Random.Generator Fruit
getFruit =
    Random.uniform
        "orange and mint salsa"
        [ "lemon zest (finely grated) and 1 tsp fresh lemon juice"
        , "lemon, parsely and mint salsa"
        , "pineapple and coriander salsa"
        , "diced apple"
        , "plum tomatoes, halved lengthways"
        , "pomegranate"
        , "very ripe strawberries, stems removed"
        ]


getCrunch : Random.Generator Crunch
getCrunch =
    Random.uniform
        "sesame seeds"
        [ "roughly chopped walnut halves, lightly toasted"
        , "roughly chopped hazelnuts"
        , "pine nuts, roughly chopped"
        , "cashew nuts, roughly chopped"
        , "cooked chestnuts"
        , "sliced almonds"
        , "peeled pistachios"
        , "black sesame seeds"
        , "roughly chopped pecan"
        ]


getAcid : Random.Generator Acid
getAcid =
    Random.uniform
        "balsamic vinegar"
        [ "pomegranate glaze"
        , "lime yoghurt"
        , "harissa paste"
        , "capers"
        , "feta"
        , "parmesan"
        , "kalamata olives"
        ]
