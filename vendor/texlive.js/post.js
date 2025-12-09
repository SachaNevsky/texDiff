// post.js - Finalize Module configuration
// This must be loaded AFTER pdftex.js

// Ensure Module object exists
if (typeof Module === 'undefined') {
    console.warn('Module not defined in post.js, creating minimal version');
    var Module = {};
}

// Set status callback if not already defined
if (!Module.setStatus) {
    Module.setStatus = function (text) {
        if (text) {
            console.log('PDFTeX:', text);
        }
    };
}

// Signal that PDFTeX scripts are loaded
Module.setStatus('PDFTeX scripts loaded');

// Make PDFTeX available globally (if it's not already)
if (typeof PDFTeX !== 'undefined' && typeof window !== 'undefined') {
    window.PDFTeX = PDFTeX;
    console.log('PDFTeX constructor is now available');
}