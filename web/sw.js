// Offline support for the web version (PWA).
// - Navigation, index.html and version.json: network first, cache as fallback.
// - Everything else from this origin: stale-while-revalidate, so a new deploy
//   is picked up on the next visit without serving stale files forever.
const CACHE = 'peuc-v1';

self.addEventListener('install', () => self.skipWaiting());

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    for (const key of await caches.keys()) {
      if (key !== CACHE) await caches.delete(key);
    }
    await self.clients.claim();
  })());
});

self.addEventListener('fetch', (event) => {
  const request = event.request;
  const url = new URL(request.url);
  if (request.method !== 'GET' || url.origin !== self.location.origin) return;

  const networkFirst = request.mode === 'navigate' || url.pathname.endsWith('/index.html') || url.pathname.endsWith('/version.json');
  event.respondWith((async () => {
    const cache = await caches.open(CACHE);
    if (networkFirst) {
      try {
        const response = await fetch(request);
        if (response.ok) cache.put(request, response.clone());
        return response;
      } catch (error) {
        return (await cache.match(request)) || (await cache.match('./')) || Response.error();
      }
    }
    const cached = await cache.match(request);
    const refresh = fetch(request).then((response) => {
      if (response.ok) cache.put(request, response.clone());
      return response;
    });
    if (cached) {
      event.waitUntil(refresh.catch(() => undefined));
      return cached;
    }
    return refresh;
  })());
});
