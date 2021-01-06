export default class Paciente {
  constructor (tipoId, identificacion, nombres, apellidos, sexo, email, fechaNac) {
    //eslint-disable-line
    this.tipo_id = tipoId
    this.identificacion = identificacion
    this.nombres = nombres
    this.apellidos = apellidos
    this.sexo = sexo
    this.email = email
    //eslint-disable-line
    this.fecha_nac = fechaNac
  }
}
