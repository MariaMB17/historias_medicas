import Service from './service.js'
const resource = 'api/auth/'
export default {
  async login (user) {
    return Service.post(resource + 'login', {
      email: user.email,
      password: user.password
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
    })
  }
}
