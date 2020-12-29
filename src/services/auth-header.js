export default function authHeader () {
  const user = JSON.parse(localStorage.getItem('user'))
  if (user && user.accessToken) {
    return {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + user.accessToken
    }
  } else {
    return {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }
  }
}
