// Removes the loading screen on the first Flutter frame and registers the
// offline service worker (kept out of index.html so the CSP needs no inline JS).
window.addEventListener('flutter-first-frame', function () {
  var el = document.getElementById('cargando');
  if (el) el.remove();
});
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function () {
    navigator.serviceWorker.register('sw.js').catch(function () {});
  });
}
