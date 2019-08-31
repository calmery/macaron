import { app, BrowserWindow, ipcMain } from "electron";
import * as http from "http";
import * as path from "path";
import serveHandler from "serve-handler";
import { AddressInfo } from "net";
import { IPC_WINDOW_CONTROL, WindowControlAction } from "../common";

const address = http
  .createServer((request, response) => {
    return serveHandler(request, response, {
      public: path.resolve(__dirname, "../renderer/")
    });
  })
  .listen()
  .address();

app.on("ready", () => {
  const browserWindow = new BrowserWindow({
    frame: false,
    fullscreen: false,
    width: 800,
    height: 600,
    vibrancy: "appearance-based",
    webPreferences: {
      nodeIntegration: true
    }
  });

  browserWindow.setMinimumSize(400, 236);

  ipcMain.on(
    IPC_WINDOW_CONTROL,
    (event, windowControlAction: WindowControlAction) => {
      switch (windowControlAction) {
        case "close":
          browserWindow.close();
          app.exit(1);
          break;

        case "dock":
          if (browserWindow.isMinimized()) {
            browserWindow.restore();
          } else {
            browserWindow.minimize();
          }
          break;

        case "scale":
          if (browserWindow.isMaximized()) {
            browserWindow.unmaximize();
          } else {
            browserWindow.maximize();
          }
          break;
      }
    }
  );

  if (address !== null && typeof address !== "string") {
    browserWindow.loadURL(`http://localhost:${(address as AddressInfo).port}`);
  } else {
    app.exit(1);
  }
});
