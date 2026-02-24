import { defineConfig } from 'vite'

export default defineConfig({
    server: {
        port: 8443,
        host: true,
        allowedHosts: ['llm', 'localhost', '127.0.0.1'],
        proxy: {
            '/api': {
                target: 'http://localhost:1234',
                changeOrigin: true,
                secure: false,
                rewrite: (path) => path.replace(/^\/api/, '')
            }
        }
    }
}) 