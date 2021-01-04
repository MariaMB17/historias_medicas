export default function authHeader () {
  const user = JSON.parse(localStorage.getItem('user'))
  console.log(user)
  if (user && user.access_token) {
    return {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + user.access_token
    }
  } else {
    return {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }
  }
}
