import Service from './service.js'
import authHeader from './auth-header.js'
const resource = 'api/auth/'
export default {
  async login (user) {
    return Service.post(resource + 'login', {
      email: user.email,
      password: user.password
    }, {
      headers: authHeader()
    }).then(response => {
      if (response.data.access_token) {
        localStorage.setItem('user', JSON.stringify(response.data))
      }
      return response.data
    })
  },
  async logout (user) {
    return Service.post(resource + 'logout', {}, {
      headers: authHeader()
    }).then(response => {
      return response.data
    })
  },
  async getUserInf () {
    return Service.get(resource + 'user', {
      headers: authHeader()
    }).then(response => {
      localStorage.setItem('userNane', JSON.stringify(response.data))
      return response.data
    })
  },

  register (user) {
    return Service.post(resource + 'signup', {
      name: user.name,
      email: user.email,
      password: user.password,
      password_confirmation: user.passwordConfirmation
    }, {
      headers: authHeader()
    })
  }
}
