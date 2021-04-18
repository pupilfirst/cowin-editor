type props = {
  categoryId: string,
  docId: option<string>,
  title: string,
  slug: string,
  excerpt: string,
  content: string,
}

let decodeProps = json => {
  open Json.Decode
  {
    docId: optional(field("docId", string), json),
    content: field("content", string, json),
    title: field("title", string, json),
    slug: field("slug", string, json),
    excerpt: field("excerpt", string, json),
    categoryId: field("categoryId", string, json),
  }
}

let props = DomUtils.parseJSONTag() |> decodeProps

switch ReactDOM.querySelector("#docs-editor") {
| Some(root) =>
  ReactDOM.render(
    <Editor
      docId=props.docId
      content=props.content
      title=props.title
      slug=props.slug
      excerpt=props.excerpt
      categoryId=props.categoryId
    />,
    root,
  )
| None => ()
}
