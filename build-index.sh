#!/bin/bash
OUT="/Users/Dani/PROYECTOS CLOUDE/CONTABILIDAD CASA/pwa/index.html"
SRC="/Users/Dani/Downloads/gastos-casa (1).jsx"

# Get component body (skip import line 1, keep everything from line 3, remove export default)
COMPONENT_BODY=$(sed -n '3,$p' "$SRC" | sed 's/^export default function App/function App/')

cat > "$OUT" << 'HEADER'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Control Hogar — Gastos Casa</title>
  <meta name="description" content="Panel de control de gastos del hogar para autónomos"/>
  <meta name="theme-color" content="#04080f"/>
  <meta name="apple-mobile-web-app-capable" content="yes"/>
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
  <meta name="apple-mobile-web-app-title" content="CtrlHogar"/>
  <link rel="manifest" href="manifest.json"/>
  <link rel="icon" href="icon.svg" type="image/svg+xml"/>
  <link rel="apple-touch-icon" href="icon.svg"/>
  <script src="https://unpkg.com/react@18/umd/react.production.min.js" crossorigin></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js" crossorigin></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
  <style>body{margin:0;padding:0}</style>
</head>
<body>
  <div id="root"></div>
  <script>
    window.storage = {
      get: function(key) { return Promise.resolve({ value: localStorage.getItem(key) }); },
      set: function(key, val) { localStorage.setItem(key, val); return Promise.resolve(); }
    };
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('sw.js').catch(function(e) { console.log('SW error:', e); });
    }
  </script>
  <script type="text/babel">
    const { useState, useEffect, useCallback } = React;
HEADER

echo "$COMPONENT_BODY" >> "$OUT"

cat >> "$OUT" << 'FOOTER'

    ReactDOM.createRoot(document.getElementById("root")).render(React.createElement(App));
  </script>
</body>
</html>
FOOTER

echo "DONE $(wc -l < "$OUT") lines"
