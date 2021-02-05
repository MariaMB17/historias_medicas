import { create } from 'core-js/fn/object'
import Service from '../service.js'
const resource = 'api/auth/v1/pacienteEmergencia'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default{
  async create() {
    const [pacienteEmg, pacienteEmgErr] = await handle(Service.post(resource, data))
    const result = pacienteEmg !== undefined ?
      [{ isSucces: true, data: pacienteEmg }] :
      [{ isSucces: false, error: pacienteEmgErr.response }]
    return result
  }
}
