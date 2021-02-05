import Service from '../service.js'
const resource = 'api/auth/v1/persona'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default{}