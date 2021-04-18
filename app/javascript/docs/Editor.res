let str = React.string
type state = {
  title: string,
  slug: string,
  excerpt: string,
  content: string,
  saving: bool,
}

type action =
  | UpdateTitle(string)
  | UpdateSlug(string)
  | UpdateExcerpt(string)
  | UpdateContent(string)
  | SetSaving
  | ClearSaving

let reducer = (state, action) =>
  switch action {
  | UpdateTitle(string) => {
      ...state,
      title: string,
    }
  | UpdateSlug(slug) => {
      ...state,
      slug: slug,
    }
  | UpdateExcerpt(excerpt) => {
      ...state,
      excerpt: excerpt,
    }
  | UpdateContent(content) => {
      ...state,
      content: content,
    }
  | SetSaving => {...state, saving: true}
  | ClearSaving => {...state, saving: true}
  }

let setPayload = (authenticityToken, state) => {
  let payload = Js.Dict.empty()

  Js.Dict.set(payload, "authenticity_token", authenticityToken |> Js.Json.string)
  Js.Dict.set(payload, "title", Js.Json.string(state.title))
  Js.Dict.set(payload, "excerpt", Js.Json.string(state.excerpt))
  Js.Dict.set(payload, "slug", Js.Json.string(state.slug))
  Js.Dict.set(payload, "content", Js.Json.string(state.content))
  payload
}

let handleResponseCB = (update, send, json) => {
  let id = json |> {
    open Json.Decode
    field("id", string)
  }

  let statusText = update ? "Doc updated successfully." : "Doc created successfully."
  Notification.success("Success", statusText)

  DomUtils.redirect("/docs/" ++ id)
  send(ClearSaving)
}

let createDoc = (categoryId, state, send) => {
  send(SetSaving)

  let handleErrorCB = () => send(ClearSaving)
  let url = "/categories/" ++ categoryId ++ "/docs"

  Api.create(
    url,
    setPayload(AuthenticityToken.fromHead(), state),
    handleResponseCB(false, send),
    handleErrorCB,
  )
}

let updateDoc = (docId, state, send) => {
  send(SetSaving)

  let handleErrorCB = () => send(ClearSaving)
  let url = "/docs/" ++ docId ++ "/"
  Api.update(
    url,
    setPayload(AuthenticityToken.fromHead(), state),
    handleResponseCB(true, send),
    handleErrorCB,
  )
}

let isValid = state => {
  state.content !== "" && state.slug !== "" && state.excerpt !== "" && state.title !== ""
}

@react.component
let make = (~docId, ~title, ~slug, ~content, ~excerpt, ~categoryId) => {
  let (state, send) = React.useReducer(
    reducer,
    {title: title, slug: slug, content: content, excerpt: excerpt, saving: false},
  )
  <div>
    <div className="mt-4">
      <label
        className="text required block text-sm font-medium text-gray-700 mb-2" htmlFor="doc_title">
        {str("Enter Doc Name")}
      </label>
      <input
        className="string required shadow-sm focus:ring-primary-500 focus:border-primary-500 block w-full sm:text-sm border-gray-300 rounded-md h-12"
        type_="text"
        value=state.title
        onChange={event => send(UpdateTitle(ReactEvent.Form.target(event)["value"]))}
        name="doc[excerpt]"
        id="doc_title"
      />
    </div>
    <div className="mt-4">
      <label
        className="text required block text-sm font-medium text-gray-700 mb-2" htmlFor="doc_slug">
        {str("Filename")}
      </label>
      <input
        className="string required shadow-sm focus:ring-primary-500 focus:border-primary-500 block w-full sm:text-sm border-gray-300 rounded-md h-12"
        type_="text"
        value=state.slug
        onChange={event => send(UpdateSlug(ReactEvent.Form.target(event)["value"]))}
        name="doc[sluf]"
        id="doc_slug"
      />
    </div>
    <div className="mt-4">
      <label
        className="text required block text-sm font-medium text-gray-700 mb-2"
        htmlFor="doc_excerpt">
        {str("Excerpt (Short description)")}
      </label>
      <input
        className="string required shadow-sm focus:ring-primary-500 focus:border-primary-500 block w-full sm:text-sm border-gray-300 rounded-md h-12"
        type_="text"
        value=state.excerpt
        onChange={event => send(UpdateExcerpt(ReactEvent.Form.target(event)["value"]))}
        name="doc[excerpt]"
        id="doc_excerpt"
      />
    </div>
    <div className="mt-4">
      <label
        className="text required block text-sm font-medium text-gray-700 mb-2"
        htmlFor="doc_content">
        {str("Contents(Markdown)")}
      </label>
      <MarkdownEditor
        tabIndex=2
        textareaId="description"
        onChange={m => send(UpdateContent(m))}
        value=state.content
        placeholder="Type target group description"
        profile=Markdown.Permissive
        maxLength=10000
        fileUpload=true
      />
    </div>
    <div>
      {switch docId {
      | Some(id) =>
        <button
          disabled={!isValid(state)}
          onClick={_ => updateDoc(id, state, send)}
          className="mt-4 inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-gray-900 hover:bg-gray-800 focus:outline-none focus:border-gray-700 focus:shadow-outline-indigo active:bg-gray-700 transition ease-in-out duration-150">
          {str("Update Doc")}
        </button>
      | None =>
        <button
          disabled={!isValid(state)}
          onClick={_ => createDoc(categoryId, state, send)}
          className="mt-4 inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-gray-900 hover:bg-gray-800 focus:outline-none focus:border-gray-700 focus:shadow-outline-indigo active:bg-gray-700 transition ease-in-out duration-150">
          {str("Create Doc")}
        </button>
      }}
    </div>
  </div>
}
