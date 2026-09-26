{{flutter_js}}
{{flutter_build_config}}

// Flutter's own service worker only unregisters itself nowadays, so it is not
// registered here; offline support comes from sw.js (registered in index.html).
_flutter.loader.load();
