const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = 3000; // Porta em que o servidor proxy irá rodar

app.use('/img', (req, res) => {
    console.log('Solicitação recebida:', req.originalUrl);
    createProxyMiddleware({
      target: 'https://flowgames.gg',
      changeOrigin: true,
      pathRewrite: {
        '^/img/': '/',
      }
    })(req, res);
  });
  

app.listen(port, () => {
  console.log(`Servidor proxy rodando em http://localhost:${port}`);
});
