import Service from '../service.js'
const resource = 'api/auth/v1/tipopersona'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listTipoPersona, listTipoPersonaErr] = await handle(Service.get(resource))
    const result = listTipoPersona !== undefined ? [
      { isSucces: true, data: listTipoPersona }] : [
      { isSucces: false, error: listTipoPersonaErr.response }]
    return result
  }
}
