import Html exposing (Html, button, div, text, input, li, ul)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)

main =
    Html.beginnerProgram {
    model = model
    , update = update
    , view = view
    }

-- MODEL
type alias Model = {
    todo: String    
    ,todos: List String
}

-- Our default state is
-- an empty todo list, with an empty input box.
model : Model
model = 
    {
    todo = ""
    , todos = []
    }

-- UPDATE

stylesheet =
    let
        tag =
            "link"
        attrs =
            [ attribute "Rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
            ]

        children =
            []
    in
        Html.node tag attrs children

type Msg = 
    UpdateTodo String | AddTodo | RemoveItem String | ClearList

update : Msg -> Model -> Model
update msg model = 
    case msg of 
        UpdateTodo text ->
            {model | todo = text}
        AddTodo ->
            {model | todos = model.todo :: model.todos, todo = ""}
        ClearList ->
            {model | todos = []}
        RemoveItem text ->
            {model | todos = List.filter(\x -> x /= text) model.todos}


-- VIEW

todoItem : String -> Html Msg
todoItem todo  = 
       li [class "list-group-item"] [text todo, button [onClick (RemoveItem todo), class "btn btn-info mx-2"] [text "Done"]]

todoList : List String -> Html Msg
todoList todos = 
    let 
        child = 
            List.map todoItem todos
    in 
        ul [class "list-group" ] child

view model =
  div [class "jumbotron"]
    [ stylesheet
    , input [ type_ "text", onInput UpdateTodo, value model.todo, class "form-control"] []
    ,button [onClick AddTodo, class "btn  btn-primary mx-2 mt-1"] [text "Add Todo"]
    ,button [onClick ClearList, class "btn  btn-primary mx-2 mt-1"] [text "Clear Todo List"]
    ,div [] [todoList model.todos]
    ]