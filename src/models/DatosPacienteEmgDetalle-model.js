export default class DatosPacineteEmgDetalle {
  constructor (id, emergenciaId, pacienteId, motivoingId, motivoIngreso, diagnosticoID, diagnostico, dest, observaciones) {
    this.id = id
    this.emergencia_id = emergenciaId
    this.paciente_id = pacienteId
    this.motivoing_id = motivoingId
    this.motivoingreso = motivoIngreso
    this.diagnostico_id = diagnosticoID
    this.diagnostico = diagnostico
    this.dest = dest
    this.observaciones = observaciones
  }
}
