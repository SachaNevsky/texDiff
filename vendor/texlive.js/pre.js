// pre.js - Initialize Module object for texlive.js
// This must be loaded BEFORE pdftex.js

// Create Module object that pdftex.js expects
var Module = {
  preRun: [],
  postRun: [],
  print: function (text) {
    console.log('PDFTeX stdout:', text);
  },
  printErr: function (text) {
    console.error('PDFTeX stderr:', text);
  },
  setStatus: function (text) {
    if (text) {
      console.log('PDFTeX status:', text);
    }
  },
  totalDependencies: 0,
  monitorRunDependencies: function (left) {
    this.totalDependencies = Math.max(this.totalDependencies, left);
    Module.setStatus(left ? 'Preparing... (' + (this.totalDependencies - left) + '/' + this.totalDependencies + ')' : 'All downloads complete.');
  }
};

// Store original Worker constructor for later wrapping
var OriginalWorker = window.Worker;

// Create a wrapper that adds better error handling
window.Worker = function (scriptURL, options) {
  console.log('Creating worker with URL:', scriptURL);

  var worker = new OriginalWorker(scriptURL, options);

  // Add error handler
  worker.onerror = function (error) {
    console.error('Worker error:', error);
    console.error('Worker script URL:', scriptURL);
  };

  return worker;
};

// Preserve the original constructor properties
window.Worker.prototype = OriginalWorker.prototype;

// Initialize texlive configuration if not already set
if (!window.TEXLIVE_CONFIG) {
  window.TEXLIVE_CONFIG = {
    workerPath: './vendor/texlive.js/pdftex-worker.js'
  };
}