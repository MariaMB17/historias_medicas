import Service from './service.js'
import authHeader from './auth-header.js'
const resource = 'api/auth/'
export default {
  async getUser () {
    return Service.get(resource + 'user', {
      headers: authHeader()
    }).then(response => {
      if (response) {
        localStorage.setItem('userNane', JSON.stringify(response))
      }
      return response
    })
  },
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
