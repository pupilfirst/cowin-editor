type props = {
  docId: string,
  markdown: option<string>,
}

let decodeProps = json => {
  open Json.Decode
  {
    docId: json |> field("docId", string),
    markdown: json |> optional(field("markdown", string)),
  }
}

let props = DomUtils.parseJSONTag() |> decodeProps

switch ReactDOM.querySelector("#docs-editor") {
| Some(root) => ReactDOM.render(<Editor docId=props.docId markdown=props.markdown />, root)
| None => ()
}
