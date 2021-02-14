import { create } from 'core-js/fn/object'
import Service from '../service.js'
const resource = 'api/auth/v1/diagnostico'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async create (data) {
    const [diagnostico, saveDiagnosticoErr] = await handle(Service.post(resource, data))
    const result = diagnostico !== undefined
      ? [{ isSucces: true, data: diagnostico }]
      : [{ isSucces: false, error: saveDiagnosticoErr.response }]
    return result
  }
}
