export default class Paciente {
  constructor (tipoId, identificacion, nombres, apellidos, sexo, email, fechaNac) {
    this.tipoId = tipoId
    this.identificacion = identificacion
    this.nombres = nombres
    this.apellidos = apellidos
    this.sexo = sexo
    this.email = email
    this.fechaNac = fechaNac
  }
}
