import Service from '../service.js'
const resource = 'api/auth/v1/persona'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listPersonas, listPersonaErr] = await handle(Service.get(resource))
    const result = listPersonas !== undefined ? [{ isSucces: true, data: listPersonas }] : [{ isSucces: false, error: listPersonaErr.response }]
    return result
  },
  async create (data) {
    const [persona, listPersonaErr] = await handle(Service.post(resource, data))
    const result = persona !== undefined ? [{ isSucces: true, data: persona }] : [{ isSucces: false, error: listPersonaErr.response }]
    return result
  },
  async update (data) {
    const [persona, listPersonaErr] = await handle(Service.put(resource + '/' + data.id, data))
    const result = persona !== undefined ? [{ isSucces: true, data: persona }] : [{ isSucces: false, error: listPersonaErr.response }]
    return result
  },
  async delete (id) {
    const [persona, listPersonaErr] = await handle(Service.delete(resource + '/' + id))
    const result = persona !== undefined ? [{ isSucces: true, data: persona }] : [{ isSucces: false, error: listPersonaErr.response }]
    return result
  },
  async getListMedicos () {
    const [listPersonas, listPersonaErr] = await handle(Service.get(resource))
    if (listPersonas) {
      const resultData = listPersonas.data.data
      const resultDataMedicos = resultData.filter(function (item) {
        item.apellidosAndNombres = item.apellidos + ' ' + item.nombres
        return item.tipo_persona_id === 1
      })
      return [{ isSucces: true, data: resultDataMedicos }]
    } else {
      return [{ isSucces: false, error: listPersonaErr.response }]
    }
  },
  async getListPacientes () {
    const [listPersonas, listPersonaErr] = await handle(Service.get(resource))
    if (listPersonas) {
      const resultData = listPersonas.data.data
      const resultDataPacientes = resultData.map(function (item) {
        item.apellidosAndNombres = item.apellidos + ' ' + item.nombres
        return item
      })
      console.log(resultDataPacientes)
      return [{ isSucces: true, data: resultDataPacientes }]
    } else {
      return [{ isSucces: false, error: listPersonaErr.response }]
    }
  }
}
