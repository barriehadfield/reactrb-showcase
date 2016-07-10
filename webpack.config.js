var path = require("path");

module.exports = {
    context: __dirname,
    entry: {
        client_only:  "./webpack/client_only.js",
        client_and_server: "./webpack/client_and_server.js"
    },
    // externals: {
    //     "react": "React",
    //     "react-dom": "ReactDOM"
    // },
    output: {
        path: path.join(__dirname, 'app', 'assets', 'javascripts', 'webpack'),
        filename: "[name].js",
        publicPath: "/js/"
    },
    module: {
        loaders: [
          // add any loaders here
        ]
    },
    resolve: {
      root: path.join(__dirname, '..', 'webpack')
    },
};
