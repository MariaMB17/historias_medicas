export default class Paciente {
  constructor (id, tipoId, identificacion, nombres, apellidos, sexo, email, fechaNac, edad,
    direccion, especialidadId, areaId, tipoPersonaId, especialidadDescription, areaDescription,
    tipoPersonaDescription) {
    this.id = id
    //eslint-disable-line
    this.tipo_id = tipoId
    this.identificacion = identificacion
    this.nombres = nombres
    this.apellidos = apellidos
    this.sexo = sexo
    this.email = email
    //eslint-disable-line
    this.fecha_nac = fechaNac
    this.edad = edad
    this.direccion = direccion
    this.especialidad_id = especialidadId
    this.area_id = areaId
    this.tipo_persona_id = tipoPersonaId
    this.readonly_especialidadDescription = especialidadDescription
    this.readonly_areaDescription = areaDescription
    this.readonly_tipoPersonaDescription = tipoPersonaDescription
  }
}
