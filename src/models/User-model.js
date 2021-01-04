export default class User {
  constructor (name, email, password, passwordConfirmation, rememberToken) {
    this.name = name
    this.email = email
    this.password = password
    this.passwordConfirmation = passwordConfirmation
    this.rememberToken = rememberToken
  }
}
