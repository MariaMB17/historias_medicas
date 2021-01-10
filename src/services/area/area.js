import Service from '../service.js'
const resource = 'api/auth/v1/area'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async getList () {
    const [listAreas, listAreaErr] = await handle(Service.get(resource))
    const result = listAreas !== undefined ? [
      { isSucces: true, data: listAreas }] : [
      { isSucces: false, error: listAreaErr.response }]
    return result
  }
}
