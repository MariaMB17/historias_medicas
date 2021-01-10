import Service from '../service.js'
const resource = 'api/auth/v1/especialidad'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listEspecialidad, listEspecialidadErr] = await handle(Service.get(resource))
    const result = listEspecialidad !== undefined ? [
      { isSucces: true, data: listEspecialidad }] : [
      { isSucces: false, error: listEspecialidadErr.response }]
    return result
  }
}
