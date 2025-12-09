// pre.js - Wrapper to handle PDFTeX worker initialization
// This file should be loaded BEFORE pdftex.js

(function () {
  // Store original Worker constructor
  var OriginalWorker = window.Worker;

  // Create a wrapper that adds better error handling
  window.Worker = function (scriptURL, options) {
    console.log('Creating worker with URL:', scriptURL);

    var worker = new OriginalWorker(scriptURL, options);

    // Wrap the onmessage handler to catch JSON parse errors
    var originalOnMessage = null;

    Object.defineProperty(worker, 'onmessage', {
      get: function () {
        return originalOnMessage;
      },
      set: function (handler) {
        originalOnMessage = function (event) {
          try {
            // Try to parse if it's a string
            if (typeof event.data === 'string') {
              try {
                var parsed = JSON.parse(event.data);
                // Create new event with parsed data
                var newEvent = {
                  data: JSON.stringify(parsed),
                  origin: event.origin,
                  lastEventId: event.lastEventId,
                  source: event.source,
                  ports: event.ports
                };
                handler.call(this, newEvent);
              } catch (parseError) {
                // If JSON parse fails, check if it's actually valid data
                console.warn('Worker message parse error (might be binary data):', parseError);
                // Pass through anyway - might be ArrayBuffer or other data
                handler.call(this, event);
              }
            } else {
              // Not a string, pass through as-is (ArrayBuffer, etc.)
              handler.call(this, event);
            }
          } catch (error) {
            console.error('Error in worker message handler:', error);
          }
        };
      }
    });

    // Add error handler
    worker.onerror = function (error) {
      console.error('Worker error:', error);
      console.error('Worker script URL:', scriptURL);
    };

    return worker;
  };

  // Preserve the original constructor properties
  window.Worker.prototype = OriginalWorker.prototype;
})();

// Initialize texlive configuration if not already set
if (!window.TEXLIVE_CONFIG) {
  window.TEXLIVE_CONFIG = {
    workerPath: './vendor/texlive.js/pdftex-worker.js'
  };
}