export default class DatosPacineteEmg {
  constructor (id, emergenciaId, pacienteId, motivoingId, diagnosticoID, observaciones, dest, motivoIng, diagnostico) {
    this.id = id
    this.emergencia_id = emergenciaId
    this.paciente_id = pacienteId
    this.motivoing_id = motivoingId
    this.diagnostico_id = diagnosticoID
    this.observaciones = observaciones
    this.dest = dest
    this.motivoIng = motivoIng
    this.diagnostico = diagnostico
  }
}
