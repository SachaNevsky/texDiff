var promise = (function () {
    var Promise = function () {
        this.callbacks = [];
        this.errbacks = [];
        this.resolved = false;
        this.rejected = false;
        this.result = undefined;
    };

    Promise.prototype.then = function (callback, errback) {
        if (this.resolved) {
            callback(this.result);
        } else if (this.rejected) {
            if (errback) errback(this.result);
        } else {
            this.callbacks.push(callback);
            if (errback) this.errbacks.push(errback);
        }
        return this;
    };

    Promise.prototype.done = function (result) {
        this.resolved = true;
        this.result = result;
        for (var i = 0; i < this.callbacks.length; i++) {
            this.callbacks[i](result);
        }
    };

    Promise.prototype.fail = function (error) {
        this.rejected = true;
        this.result = error;
        for (var i = 0; i < this.errbacks.length; i++) {
            this.errbacks[i](error);
        }
    };

    var chain = function (promises) {
        var p = new Promise();
        var results = [];

        var processNext = function (index) {
            if (index >= promises.length) {
                p.done(results);
                return;
            }

            var current = promises[index];
            if (typeof current === 'function') {
                var result = current();
                if (result && typeof result.then === 'function') {
                    result.then(function (res) {
                        results.push(res);
                        processNext(index + 1);
                    });
                } else {
                    results.push(result);
                    processNext(index + 1);
                }
            } else if (current && typeof current.then === 'function') {
                current.then(function (res) {
                    results.push(res);
                    processNext(index + 1);
                });
            } else {
                results.push(current);
                processNext(index + 1);
            }
        };

        processNext(0);
        return p;
    };

    return {
        Promise: Promise,
        chain: chain
    };
})();