// webpack/client_only.js
// any packages that depend specifically on the DOM go here
// for example the webpack css loader generates code that will break prerendering
require('bootstrap/dist/css/bootstrap.css');
console.log('client_and_server.js loaded');
