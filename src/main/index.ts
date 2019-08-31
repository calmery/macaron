import { app, BrowserWindow } from "electron";
import * as http from "http";
import * as path from "path";
import serveHandler from "serve-handler";
import { AddressInfo } from "net";

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
    height: 600
  });

  browserWindow.setMinimumSize(400, 236);

  if (address !== null && typeof address !== "string") {
    browserWindow.loadURL(`http://localhost:${(address as AddressInfo).port}`);
  } else {
    app.exit(1);
  }
});
