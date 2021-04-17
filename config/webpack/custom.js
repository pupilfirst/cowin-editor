const webpack = require("webpack");
module.exports = {
  resolve: {
    alias: {
      React: "react",
      ReactDOM: "react-dom",
    },
  },
  plugins: [new webpack.IgnorePlugin(/^[^.]+$|\.(?!(re|res)$)([^.]+$)/)],
};
