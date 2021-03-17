/* istanbul ignore file */

/*
O monitoramento está em arquivo apartado (logger.js), e não no 'app.js',
para não ser afetado pelo teste de mutação.

Esse arquivo está marcado para ser ignorado no arquivo stryker.conf.js
*/

const moesif = require('moesif-nodejs')

const { version } = require('../../package.json')
const { formaDeExecucao } = require('./ambiente')

const ehAmbienteDeDesenvolvimento = process.env.NODE_ENV === 'serverest-development'
const ehAmbienteDeTestes = process.env.NODE_ENV === 'serverest-test'

module.exports = async app => {
  if (ehAmbienteDeDesenvolvimento || ehAmbienteDeTestes) {
    return
  }
  const moesifMiddleware = moesif({
    applicationId: 'eyJhcHAiOiIxNTA6MTU1MCIsInZlciI6IjIuMCIsIm9yZyI6IjQ5MToxMTIxIiwiaWF0IjoxNTk4OTE4NDAwfQ.e0E6Qhz1o1Jjs5prulHDYEBlv0juruWs_btjq2mong8',
    identifyUser: (req, res) => { return formaDeExecucao() },
    identifyCompany: (req, res) => { return version },
    skip: (req, res) => {
      if (req.path === '/favicon.ico' || req.path === '/version' || req.path === '/socket.io' || (formaDeExecucao() === 'serverest.dev' && req.path === '/') || req.path === '/__messages__' || req.headers.monitor) {
        return true
      }
    },
    noAutoHideSensitive: true
  })
  app.use(moesifMiddleware)
}