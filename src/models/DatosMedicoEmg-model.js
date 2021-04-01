export default class DatosMedicosEmg {
  constructor (id, personaId, turno, fecha, enfermeraId, detalle) {
    this.id = id
    //eslint-disable-line
    this.persona_id = personaId
    this.turno = turno
    this.enfermera_id = enfermeraId
    this.fecha = fecha
    this.detalle = detalle
  }
}
