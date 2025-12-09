// Simple Promise polyfill for the library's expected API
var promise = {
  Promise: function () {
    var resolveCallback;
    var rejectCallback;
    var isDone = false;
    var result;
    var isError = false;

    var p = new Promise(function (resolve, reject) {
      resolveCallback = resolve;
      rejectCallback = reject;
    });

    p.done = function (value) {
      if (!isDone) {
        isDone = true;
        result = value;
        isError = false;
        console.log('Promise.done called with:', value);
        if (resolveCallback) {
          setTimeout(function () { resolveCallback(value); }, 0);
        }
      }
      return p;
    };

    p.fail = function (error) {
      if (!isDone) {
        isDone = true;
        result = error;
        isError = true;
        console.error('Promise.fail called with:', error);
        if (rejectCallback) {
          setTimeout(function () { rejectCallback(error); }, 0);
        }
      }
      return p;
    };

    return p;
  },

  chain: function (functions) {
    var p = new promise.Promise();

    var runNext = function (index) {
      if (index >= functions.length) {
        console.log('promise.chain: All functions completed');
        p.done(true);
        return;
      }

      console.log('promise.chain: Running function', index);
      try {
        var result = functions[index]();
        if (result && typeof result.then === 'function') {
          result.then(function () {
            runNext(index + 1);
          }).catch(function (err) {
            console.error('promise.chain: Error in function', index, err);
            p.fail(err);
          });
        } else {
          runNext(index + 1);
        }
      } catch (err) {
        console.error('promise.chain: Exception in function', index, err);
        p.fail(err);
      }
    };

    setTimeout(function () { runNext(0); }, 0);
    return p;
  }
};

var PDFTeX = function (opt_workerPath) {
  if (!opt_workerPath) {
    // Check for global config first
    if (window.TEXLIVE_CONFIG && window.TEXLIVE_CONFIG.workerPath) {
      opt_workerPath = window.TEXLIVE_CONFIG.workerPath;
    } else {
      // Default to correct path in vendor directory
      opt_workerPath = './vendor/texlive.js/pdftex-worker.js';
    }
  }
  var worker = new Worker(opt_workerPath);
  var self = this;
  var initialized = false;

  self.on_stdout = function (msg) {
    console.log(msg);
  }

  self.on_stderr = function (msg) {
    console.log(msg);
  }


  worker.onmessage = function (ev) {
    var data = JSON.parse(ev.data);
    var msg_id;

    if (!('command' in data))
      console.log("missing command!", data);
    switch (data['command']) {
      case 'ready':
        onready.done(true);
        break;
      case 'stdout':
      case 'stderr':
        self['on_' + data['command']](data['contents']);
        break;
      default:
        //console.debug('< received', data);
        msg_id = data['msg_id'];
        if (('msg_id' in data) && (msg_id in promises)) {
          promises[msg_id].done(data['result']);
        }
        else
          console.warn('Unknown worker message ' + msg_id + '!');
    }
  }

  var onready = new promise.Promise();
  var promises = [];
  var chunkSize = undefined;

  var sendCommand = function (cmd) {
    var p = new promise.Promise();
    var msg_id = promises.push(p) - 1;

    onready.then(function () {
      cmd['msg_id'] = msg_id;
      //console.debug('> sending', cmd);
      worker.postMessage(JSON.stringify(cmd));
    });

    return p;
  };

  var determineChunkSize = function () {
    var size = 1024;
    var max = undefined;
    var min = undefined;
    var delta = size;
    var success = true;
    var buf;

    while (Math.abs(delta) > 100) {
      if (success) {
        min = size;
        if (typeof (max) === 'undefined')
          delta = size;
        else
          delta = (max - size) / 2;
      }
      else {
        max = size;
        if (typeof (min) === 'undefined')
          delta = -1 * size / 2;
        else
          delta = -1 * (size - min) / 2;
      }
      size += delta;

      success = true;
      try {
        buf = String.fromCharCode.apply(null, new Uint8Array(size));
        sendCommand({
          command: 'test',
          data: buf,
        });
      }
      catch (e) {
        success = false;
      }
    }

    return size;
  };


  var createCommand = function (command) {
    self[command] = function () {
      var args = [].concat.apply([], arguments);

      return sendCommand({
        'command': command,
        'arguments': args,
      });
    }
  }
  createCommand('FS_createDataFile'); // parentPath, filename, data, canRead, canWrite
  createCommand('FS_readFile'); // filename
  createCommand('FS_unlink'); // filename
  createCommand('FS_createFolder'); // parent, name, canRead, canWrite
  createCommand('FS_createPath'); // parent, name, canRead, canWrite
  createCommand('FS_createLazyFile'); // parent, name, canRead, canWrite
  createCommand('FS_createLazyFilesFromList'); // parent, list, parent_url, canRead, canWrite
  createCommand('set_TOTAL_MEMORY'); // size

  var curry = function (obj, fn, args) {
    return function () {
      return obj[fn].apply(obj, args);
    }
  }

  self.compile = function (source_code) {
    var p = new promise.Promise();

    self.compileRaw(source_code).then(function (binary_pdf) {
      if (binary_pdf === false)
        return p.done(false);

      pdf_dataurl = 'data:application/pdf;charset=binary;base64,' + window.btoa(binary_pdf);

      return p.done(pdf_dataurl);
    });
    return p;
  }

  self.compileRaw = function (source_code) {
    if (typeof (chunkSize) === "undefined")
      chunkSize = determineChunkSize();

    var commands;
    if (initialized)
      commands = [
        curry(self, 'FS_unlink', ['/input.tex']),
      ];
    else
      commands = [
        curry(self, 'FS_createDataFile', ['/', 'input.tex', source_code, true, true]),
        curry(self, 'FS_createLazyFilesFromList', ['/', 'texlive.lst', './texlive', true, true]),
      ];

    var sendCompile = function () {
      initialized = true;
      return sendCommand({
        'command': 'run',
        'arguments': ['-interaction=nonstopmode', '-output-format', 'pdf', 'input.tex'],
        //        'arguments': ['-debug-format', '-output-format', 'pdf', '&latex', 'input.tex'],
      });
    };

    var getPDF = function () {
      console.log(arguments);
      return self.FS_readFile('/input.pdf');
    }

    return promise.chain(commands)
      .then(sendCompile)
      .then(getPDF);
  };
};