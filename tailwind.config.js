module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: "#fff4f1",
          100: "#ffe8e2",
          200: "#ffddd4",
          300: "#ffc7b7",
          400: "#ffb09a",
          500: "#ff997d",
          600: "#ff8e6e",
          700: "#e68063",
          800: "#cc7258",
          900: "#b3634d",
        },
      },
    },
  },
  purge: {
    content: ["./app/**/*.html.erb", "./app/**/*.res"],
  },
};
