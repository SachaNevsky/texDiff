self['postMessage'](JSON.stringify({ 'command': 'ready' }));
//shouldRunNow = true;
Module['calledRun'] = false;
Module['thisProgram'] = '/latex';

// Wrap FS operations in try-catch to suppress errors
try {
    if (typeof FS !== 'undefined' && FS.createDataFile) {
        FS.createDataFile("/", Module['thisProgram'], "dummy for kpathsea", true, true);
    }
} catch (e) {
    // Silently ignore FS errors during initialization
}