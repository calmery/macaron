import { defineCustomElements } from "@ionic/core/loader";
import { ipcRenderer } from "electron";
import "./index.scss";
import "@ionic/core/css/ionic.bundle.css";
import { Elm } from "./Main.elm";
import { IPC_WINDOW_CONTROL, WindowControlAction } from "../common";

// https://github.com/ionic-team/ionic/blob/bf2953cf85c078b0fd567e51208eacd5dc9b87cd/packages/react/src/components/index.ts#L51
defineCustomElements(window);

export const flags = {
  message: "Hello World"
};

const elm = Elm.Main.init({
  flags: JSON.stringify(flags)
});

if (elm.ports !== undefined) {
  (elm.ports.windowControl as Elm.Ports.Subscribable).subscribe(
    (windowControlAction: WindowControlAction) => {
      ipcRenderer.send(IPC_WINDOW_CONTROL, windowControlAction);
    }
  );
}

// eslint-disable-next-line no-console
console.log(process.env.NODE_ENV);
