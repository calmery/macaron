import "./index.scss";
import { Elm } from "./Main.elm";

export const flags = {
  message: "Hello World"
};

Elm.Main.init({
  flags: JSON.stringify(flags),
  node: document.body
});

// eslint-disable-next-line no-console
console.log(process.env.NODE_ENV);
