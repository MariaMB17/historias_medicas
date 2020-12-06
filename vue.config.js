var path = require('path')
module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
    ? '/store-frontend/'
    : '/',
  transpileDependencies: [
    'vuetify'
  ]
}
