export default class DatosPacineteEmg {
  constructor (id, emergenciaId, pacienteId, motivoingId, motivoIngreso, diagnosticoID, observaciones, dest, motivoIng, diagnostico) {
    this.id = id
    this.emergencia_id = emergenciaId
    this.paciente_id = pacienteId
    this.motivoing_id = motivoingId
    this.motivoIngreso = motivoIngreso
    this.diagnostico_id = diagnosticoID
    this.diagnostico = diagnostico
    this.observaciones = observaciones
    this.dest = dest
    this.motivoIng = motivoIng
    this.diagnostico = diagnostico
  }
}
