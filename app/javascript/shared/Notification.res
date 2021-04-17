let jsNotify = (title, text, status) => Js.log(title ++ text ++ status)

let success = (title, text) => jsNotify(title, text, "success")
let error = (title, text) => jsNotify(title, text, "error")
let notice = (title, text) => jsNotify(title, text, "notice")
let warn = notice
