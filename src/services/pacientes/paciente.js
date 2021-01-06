import Service from '../service.js'
const resource = 'api/auth/v1/paciente'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listPacientes, listpacienteErr] = await handle(Service.get(resource))
    const result = listPacientes !== undefined ? [{ isSucces: true, data: listPacientes }] : [{ isSucces: false, error: listpacienteErr.response }]
    return result
  },
  async create (data) {
    const [paciente, pacienteErr] = await handle(Service.post(resource, data))
    const result = paciente !== undefined ? [{ isSucces: true, data: paciente }] : [{ isSucces: false, error: pacienteErr.response }]
    return result
  },
  delete (id) {
    return Service.delete(resource, id)
  }
}
