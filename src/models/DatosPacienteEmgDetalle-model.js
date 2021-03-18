export default class DatosPacineteEmgDetalle {
  constructor (id, emergenciaId, pacienteId, motivoingId, motivoIngreso, diagnosticoID, diagnostico, observaciones, dest) {
    this.id = id
    this.emergencia_id = emergenciaId
    this.paciente_id = pacienteId
    this.motivoing_id = motivoingId
    this.motivoingreso = motivoIngreso
    this.diagnostico_id = diagnosticoID
    this.dignostico = diagnostico
    this.observaciones = observaciones
    this.dest = dest
  }
}
