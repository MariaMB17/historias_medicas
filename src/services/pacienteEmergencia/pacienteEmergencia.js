import Service from '../service.js'
import authHeader from '../auth-header.js'
const resource = 'api/auth/v1/emergencia'
const resourceDetalle = 'api/auth/v1/pacienteEmergenciaDetalle'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async create (data) {
    const [pacienteEmg, pacienteEmgErr] = await handle(Service.post(resource, data, { headers: authHeader() }))
    const result = pacienteEmg !== undefined
      ? [{ isSucces: true, data: pacienteEmg }]
      : [{ isSucces: false, error: pacienteEmgErr.response }]
    return result
  },
  async createDetalle (data) {
    const [pacienteEmgDetalle, pacienteEmgDetalleErr] = await handle(Service.post(resourceDetalle, data, { headers: authHeader() }))
    const result = pacienteEmgDetalle !== undefined
      ? [{ isSucces: true, data: pacienteEmgDetalle }]
      : [{ isSucces: false, error: pacienteEmgDetalleErr.response }]
    return result
  }
}
