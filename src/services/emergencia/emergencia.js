import Service from '../service.js'
import authHeader from '../auth-header.js'
const resource = 'api/auth/v1/emergencia'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listEmergencia, listEmergenciaErr] = await handle(Service.get(resource, { headers: authHeader() }))
    const result = listEmergencia !== undefined ? [
      { isSucces: true, data: listEmergencia }] : [
      { isSucces: false, error: listEmergenciaErr.response }]
    return result
  },
  async create (data) {
    const [emergencia, listEmergenciaErr] = await handle(Service.post(resource, data, { headers: authHeader() }))
    const result = emergencia !== undefined ? [{ isSucces: true, data: emergencia }] : [{ isSucces: false, error: listEmergenciaErr.response }]
    return result
  },
}
