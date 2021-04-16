module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: "#E6FFF2",
          100: "#DCFEEC",
          200: "#AFFDD4",
          300: "#84FBBC",
          400: "#5AFBA6",
          500: "#0AD66A",
          600: "#0CB65C",
          700: "#0F954E",
          800: "#157F48",
          900: "#0B512C",
        },
        secondary: {
          50: "#EBFBFF",
          100: "#C4F3FD",
          200: "#A5EDFD",
          300: "#64DCF7",
          400: "#13CEF8",
          500: "#0AB5DB",
          600: "#0B93B1",
          700: "#0E758B",
          800: "#0F5B6C",
          900: "#0B4451",
        },
        tertiary: {
          50: "#eaf8f8",
          100: "#ccf7f2",
          200: "#99f2e1",
          300: "#23eddc",
          400: "#19d9b1",
          500: "#07c48e",
          600: "#07ab71",
          700: "#0c8d5f",
          800: "#106e4e",
          900: "#105a41",
        },
        gray: {
          50: "#F6F7F8",
          100: "#EEEFF2",
          200: "#DADDE2",
          300: "#C0C4CE",
          400: "#A7ACB9",
          500: "#7C8498",
          600: "#5E6678",
          700: "#474D5C",
          800: "#343A46",
          900: "#21252E",
        },
      },
    },
  },
  purge: {
    content: ["./app/**/*.html.erb", "./app/**/*.res"],
  },
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
