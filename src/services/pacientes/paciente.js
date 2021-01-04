import Service from '../service.js'
const resource = 'api/auth/v1/paciente'
const handle = (promise) => {
  return promise
    .then(data => ([data, undefined]))
    .catch(error => Promise.resolve([undefined, error]))
}
export default {
  async get () {
    try {
      const listarMarcas = 'nada'
      return [{ isSucces: true, response: listarMarcas }]
    } catch (error) {
      console.error(error)
      return [{ isSucces: false, error: error }]
    }
  },
  async create (data) {
    const newPaciente = {
      tipo_id: data.tipoId,
      identificacion: data.identificacion,
      nombres: data.nombres,
      apellidos: data.apellidos,
      sexo: data.sexo,
      email: data.email,
      fecha_nac: data.fechaNac
    }
    const [paciente, pacienteErr] = await handle(Service.post(resource, newPaciente))
    const result = paciente !== undefined ? [{ isSucces: true, data: paciente }] : [{ isSucces: false, error: pacienteErr.response }]
    return result
  },
  delete (id) {
    return Service.delete(resource, id)
  }
}
