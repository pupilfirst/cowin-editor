let str = React.string

@react.component
let make = (~docId, ~markdown) => {
  <div> {str("Foo")} </div>
}
