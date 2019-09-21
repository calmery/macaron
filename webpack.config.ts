import autoprefixer from "autoprefixer";
import CopyWebpackPlugin from "copy-webpack-plugin";
import HtmlWebpackPlugin from "html-webpack-plugin";
import MiniCssExtractPlugin from "mini-css-extract-plugin";
import OptimizeCSSAssetsPlugin from "optimize-css-assets-webpack-plugin";
import * as path from "path";
import ScriptExtHtmlWebpackPlugin from "script-ext-html-webpack-plugin";
import UglifyJsPlugin from "uglifyjs-webpack-plugin";
import {
  Configuration,
  HotModuleReplacementPlugin,
  DefinePlugin
} from "webpack";
import merge from "webpack-merge";
import WriteFileWebpackPlugin from "write-file-webpack-plugin";

const isProduction = process.env.NODE_ENV === "production";

const common: Configuration = {
  mode: isProduction ? "production" : "development",
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: "ts-loader"
      }
    ]
  },
  plugins: [
    new DefinePlugin({
      "process.env": {
        NODE_ENV: JSON.stringify(isProduction ? "production" : "development")
      }
    })
  ],
  resolve: {
    extensions: [".ts", ".js"]
  }
};

const main: Configuration = merge(common, {
  entry: path.resolve(__dirname, "src/main/index.ts"),
  node: {
    __dirname: false
  },
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "build/main")
  },
  target: "electron-main"
});

const renderer: Configuration = merge(common, {
  entry: path.resolve(__dirname, "src/renderer/index.ts"),
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: "elm-webpack-loader",
          options: {
            optimize: isProduction,
            verbose: true
          }
        }
      },
      {
        test: /\.s?css$/,
        loader: [
          isProduction ? MiniCssExtractPlugin.loader : "style-loader",
          {
            loader: "css-loader",
            options: {
              sourceMap: true,
              url: false
            }
          },
          {
            loader: "postcss-loader",
            options: {
              ident: "postcss",
              plugins: [autoprefixer]
            }
          },
          {
            loader: "sass-loader",
            options: {
              sourceMap: true
            }
          }
        ]
      }
    ]
  },
  output: {
    filename: isProduction ? "[contenthash].js" : "index.js",
    path: path.resolve(__dirname, "build/renderer")
  },
  plugins: [
    new CopyWebpackPlugin([
      {
        from: path.resolve(__dirname, "src/renderer/assets"),
        to: path.resolve(__dirname, "build/renderer/assets")
      }
    ]),
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, "src/renderer/index.html"),
      minify: {
        collapseWhitespace: isProduction
      }
    }),
    new ScriptExtHtmlWebpackPlugin({
      defaultAttribute: "defer"
    })
  ],
  target: "electron-renderer"
});

const rendererDevelopment: Configuration = merge(renderer, {
  devtool: "cheap-module-source-map",
  mode: "development",
  plugins: [new HotModuleReplacementPlugin(), new WriteFileWebpackPlugin()]
});

const rendererProduction: Configuration = merge(renderer, {
  devtool: "source-map",
  mode: "production",
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        sourceMap: true,
        uglifyOptions: {
          mangle: true,
          compress: {
            passes: 2,
            unsafe: true,
            unsafe_comps: true, // eslint-disable-line @typescript-eslint/camelcase
            keep_fargs: false, // eslint-disable-line @typescript-eslint/camelcase
            pure_getters: true, // eslint-disable-line @typescript-eslint/camelcase
            // eslint-disable-next-line @typescript-eslint/camelcase
            pure_funcs: [
              "F2",
              "F3",
              "F4",
              "F5",
              "F6",
              "F7",
              "F8",
              "F9",
              "A2",
              "A3",
              "A4",
              "A5",
              "A6",
              "A7",
              "A8",
              "A9"
            ]
          }
        }
      })
    ],
    splitChunks: {
      chunks: "all"
    }
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "[contenthash].css"
    }),
    new OptimizeCSSAssetsPlugin({
      cssProcessorOptions: {
        map: {
          annotation: true,
          inline: false
        }
      }
    })
  ]
});

export default [main, isProduction ? rendererProduction : rendererDevelopment];
