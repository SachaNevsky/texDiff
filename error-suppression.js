// error-suppression.js - Must be loaded before other scripts
(function () {
    // Global error handler
    window.addEventListener('error', function (event) {
        const message = event.message || '';
        const filename = event.filename || '';

        if (message.includes('JSON.parse: unexpected character') ||
            message.includes('FS is not defined') ||
            message.includes('Could not create') ||
            message.includes('mkdir failed') ||
            filename.includes('pre.js') ||
            filename.includes('post.js') ||
            filename.includes('perlrunner.html') ||
            filename.includes('pdftex-worker.js')) {
            event.preventDefault();
            event.stopPropagation();
            return false;
        }
    }, true);

    // Unhandled promise rejections
    window.addEventListener('unhandledrejection', function (event) {
        const reason = String(event.reason || '');

        if (reason.includes('Invalid PDF structure') ||
            reason.includes('InvalidPDFException') ||
            reason.includes('JSON.parse') ||
            reason.includes('FS is not defined')) {
            event.preventDefault();
            return false;
        }
    });

    // Console overrides
    const originalError = console.error;
    console.error = function (...args) {
        const message = String(args[0] || '');
        if (message.includes('Could not create') ||
            message.includes('mkdir failed') ||
            message.includes('FS is not defined') ||
            message.includes('JSON.parse') ||
            message.includes('Invalid PDF') ||
            message.includes('InvalidPDFException')) {
            return;
        }
        originalError.apply(console, args);
    };

    const originalWarn = console.warn;
    console.warn = function (...args) {
        const message = String(args[0] || '');
        if (message.includes('asm.js is deprecated') ||
            message.includes('Invalid absolute docBaseUrl') ||
            message.includes('Indexing all PDF objects') ||
            message.includes('Warning:')) {
            return;
        }
        originalWarn.apply(console, args);
    };

    const originalLog = console.log;
    console.log = function (...args) {
        const message = String(args[0] || '');
        if (message.includes('Could not create') ||
            message.includes('mkdir failed') ||
            message.includes('asm.js is deprecated') ||
            message.includes('LazyFiles on gzip') ||
            message.includes('This is pdfTeX') ||
            message.includes('restricted \\write18') ||
            message.includes('entering extended mode') ||
            message.includes('LaTeX2e') ||
            message.includes('Document Class:') ||
            message.includes('//texmf-dist/') ||
            message.includes('./input.tex') ||
            message.includes('Successfully compiled asm.js') ||
            message.includes('No file input.aux') ||
            message.includes('[Loading MPS to PDF converter') ||
            message.includes('Output written on input.pdf') ||
            message.includes('Transcript written on input.log') ||
            message.match(/^\([\/\.]/) ||
            message.match(/^\)/) ||
            message === '<empty string>') {
            return;
        }
        originalLog.apply(console, args);
    };
})();