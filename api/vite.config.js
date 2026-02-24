import { defineConfig } from 'vite'

export default defineConfig({
    plugins: [
        {
            name: 'require-apikey-header',
            configureServer(server) {
                server.middlewares.use((req, res, next) => {
                    try {
                        if (req.url && req.url.startsWith('/api')) {
                            const expected = process.env.LM_API_KEY
                            if (!expected) {
                                res.statusCode = 500
                                res.setHeader('content-type', 'text/plain; charset=utf-8')
                                res.end('Server misconfigured: LM_API_KEY not set')
                                return
                            }

                            const apikey = req.headers['apikey'] || req.headers['x-api-key']
                            const auth = req.headers['authorization']

                            let provided = undefined

                            if (apikey) {
                                provided = String(apikey).trim()
                            } else if (typeof auth === 'string' && auth.trim().toLowerCase().startsWith('bearer ')) {
                                provided = auth.trim().slice(7).trim()
                                if (!provided) {
                                    res.statusCode = 401
                                    res.setHeader('content-type', 'text/plain; charset=utf-8')
                                    res.end('Empty Bearer token')
                                    return
                                }
                            } else {
                                res.statusCode = 401
                                res.setHeader('content-type', 'text/plain; charset=utf-8')
                                res.end('Missing apikey or Authorization: Bearer <token> header')
                                return
                            }

                            if (provided !== expected) {
                                res.statusCode = 403
                                res.setHeader('content-type', 'text/plain; charset=utf-8')
                                res.end('Forbidden: invalid API key')
                                return
                            }
                        }
                    } catch (err) {
                        res.statusCode = 500
                        res.end('Server error')
                        return
                    }
                    next()
                })
            }
        }
    ],
    server: {
        port: 8443,
        host: true,
        allowedHosts: ['llm', 'localhost', '127.0.0.1', 'lms.ubva.com.br'],
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