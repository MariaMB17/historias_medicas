export default class DatosMedicosEmg {
  constructor (id, personaId, turno, fecha, detalle) {
    this.id = id
    //eslint-disable-line
    this.persona_id = personaId
    this.turno = turno
    this.fecha = fecha
    this.detalle = detalle
  }
}
