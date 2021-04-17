let randomId = () => {
  let randomComponent = Js.Math.random() |> Js.Float.toString |> Js.String.substr(~from=2)
  "markdown-block-" ++ randomComponent
}

@react.component
let make = (~markdown, ~className=?, ~profile) => {
  let (id, _setId) = React.useState(() => randomId())

  <article
    className="prose prose-xl"
    id
    dangerouslySetInnerHTML={"__html": markdown |> Markdown.parse(profile)}
  />
}
