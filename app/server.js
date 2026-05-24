const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 80;

app.get('/', (req, res) => {
  res.send(`
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>Simple Web App</title>
        <style>
          body { font-family: Arial, sans-serif; background: #f4f6fb; color: #102a43; margin: 0; padding: 2rem; }
          .container { max-width: 720px; margin: auto; background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 12px 40px rgba(16,42,67,.08); }
          h1 { margin-top: 0; }
          pre { background: #f0f4f8; padding: 1rem; border-radius: 8px; }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Simple Web App</h1>
          <p>This app is running in AKS and pulling its container image from ACR.</p>
          <p><strong>Host:</strong> ${os.hostname()}</p>
          <p><strong>Time:</strong> ${new Date().toISOString()}</p>
          <p>Use <code>/health</code> to verify readiness.</p>
        </div>
      </body>
    </html>
  `);
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', hostname: os.hostname(), timestamp: new Date().toISOString() });
});

app.listen(port, () => {
  console.log(`Simple web app listening on port ${port}`);
});
