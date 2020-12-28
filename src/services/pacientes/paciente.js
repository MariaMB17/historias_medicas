import Service from '../service.js'
const resource = 'currentprice.json'
export default {
  async get () {
    try {
      const listarMarcas = await Service.get(resource)
      console.log(listarMarcas)
      return [{ isSucces: true, response: listarMarcas }]
    } catch (error) {
      console.error(error)
      return [{ isSucces: false, error: error }]
    }
  },
  create (data) {
    return Service.post(resource, data)
  },
  delete (id) {
    return Service.delete(resource, id)
  }
}
