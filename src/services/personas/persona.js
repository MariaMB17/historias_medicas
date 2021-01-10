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
  }
}
