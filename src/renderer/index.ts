import { ipcRenderer } from "electron";
import "./index.scss";
import { Elm } from "./Main.elm";
import { IPC_WINDOW_CONTROL, WindowControlAction } from "../common";

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
