<template>
    <v-card>
        <v-card-title>
            <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Search"
                single-line
                hide-details>
            </v-text-field>
        </v-card-title>
        <v-data-table
            :headers="headers"
            :items="dataGridPersona"
            :search="search">
            <template v-slot:top>
              <v-snackbar
              :timeout="3000"
              v-model="isInvalid"
              :color="colorValue"
              absolute
              right
              shaped
              top>
              {{ messages }}
            </v-snackbar>
                <v-toolbar flat>
                    <v-toolbar-title>Personas</v-toolbar-title>
                    <v-divider
                        class="mx-4"
                        inset
                        vertical>
                    </v-divider>
                    <v-spacer></v-spacer>
                    <v-dialog
                        v-model="dialog"
                        content-class="dialog-emergencia"
                        transition="dialog-bottom-transition"
                        persistent>
                        <template v-slot:activator="{ on, attrs }">
                            <v-btn
                                color="primary"
                                dark
                                class="mb-2"
                                v-bind="attrs"
                                v-on="on">
                                Nuevo(a) paciente
                            </v-btn>
                        </template>
                        <v-card>
                            <v-toolbar flat
                                dark
                                color="primary">
                                <v-btn
                                    icon
                                    dark
                                    @click="close"
                                  >
                                    <v-icon>mdi-close</v-icon>
                                  </v-btn>
                                  <v-toolbar-title>
                                    {{ formTitle }}
                                  </v-toolbar-title>
                                  <v-spacer></v-spacer>
                                  <v-toolbar-items>
                                    <v-btn
                                      dark
                                      text
                                      @click="save"
                                    >
                                      Save
                                    </v-btn>
                                  </v-toolbar-items>
                            </v-toolbar>
                            <v-card-text style="background:#aeaeae; padding:10px;">
                                <v-form>
                                    <v-tabs
                                        v-model="tab"
                                        grow>
                                        <v-tab
                                            v-for="item in items"
                                            :key="item.name">
                                            <span v-bind:style="item.fondo"> {{ item.name }} </span>
                                        </v-tab>
                                    </v-tabs>
                                    <v-tabs-items v-model="tab" style="height:58vh; overflow: auto;">
                                        <v-tab-item>
                                            <v-card flat>
                                                <v-card-text>
                                                    <v-container class="grey lighten-5">
                                                        <v-row>
                                                            <v-col
                                                                cols="12"
                                                                sm="12"
                                                                md="12">
                                                                <v-autocomplete
                                                                    v-model="datosMedicos.persona_id"
                                                                    label="Nombre y apellidos"
                                                                    item-text="apellidosAndNombres"
                                                                    item-value="id"
                                                                    :items="listaMedicos"
                                                                    :loading="isLoading"
                                                                    :error-messages="medicoErrors"
                                                                    required
                                                                    @change="$v.datosMedicos.persona_id.$touch()"
                                                                    @blur="$v.datosMedicos.persona_id.$touch()"
                                                                    dense
                                                                    filled
                                                                >
                                                                </v-autocomplete>
                                                            </v-col>
                                                            <v-col
                                                                cols="12"
                                                                sm="3"
                                                                md="3">
                                                            <v-select
                                                                v-model="datosMedicos.turno"
                                                                :items="listTurnos"
                                                                label="Turno"
                                                                :error-messages="turnoErrors"
                                                                required
                                                                @change="$v.datosMedicos.turno.$touch()"
                                                                @blur="$v.datosMedicos.turno.$touch()">
                                                            </v-select>
                                                        </v-col>
                                                        <v-col
                                                            cols="12"
                                                            sm="4"
                                                            md="4">
                                                            <v-menu
                                                                ref='menu'
                                                                v-model='menu'
                                                                :close-on-content-click='false'
                                                                :return-value.sync='datosMedicos.fecha'
                                                                transition="scale-transition"
                                                                offset-y
                                                                min-width='290px'>
                                                                <template v-slot:activator="{ on, attrs }">
                                                                    <v-text-field
                                                                        v-model="datosMedicos.fecha"
                                                                        label="Fecha"
                                                                        prepend-icon="mdi-calendar"
                                                                        readonly
                                                                        v-bind="attrs"
                                                                        v-on="on">
                                                                    </v-text-field>
                                                                </template>
                                                                <v-date-picker
                                                                    v-model="datosMedicos.fecha"
                                                                    no-title scrollable>
                                                                <v-spacer></v-spacer>
                                                                <v-btn
                                                                    text
                                                                    color="primary"
                                                                    @click="menu = false">
                                                                    Cancel
                                                                </v-btn>
                                                                <v-btn
                                                                    text
                                                                    color="primary"
                                                                    @click="closeDatepicker">
                                                                    OK
                                                                </v-btn>
                                                                </v-date-picker>
                                                            </v-menu>
                                                        </v-col>
                                                        </v-row>
                                                    </v-container>
                                            </v-card-text>
                                        </v-card>
                                        </v-tab-item>
                                        <v-tab-item>
                                          <v-card flat>
                                            <v-card-text>
                                              <v-container class="grey lighten-5">
                                                <v-row>
                                                  <v-col
                                                    cols="12"
                                                    sm="12"
                                                    md="12">
                                                      <v-autocomplete
                                                        v-model="datosPacienteEmgDetalle.paciente_id"
                                                        label="Nombre y apellidos"
                                                        item-text="apellidosAndNombres"
                                                        item-value="id"
                                                        :items="listaPacientes"
                                                        :loading="isLoading"
                                                        dense
                                                        filled
                                                        @change="(event) => updatePciente(event, listaPacientes)">
                                                      </v-autocomplete>
                                                  </v-col>
                                                  <v-col
                                                    cols="12"
                                                    sm="3"
                                                    md="3">
                                                      <v-text-field
                                                        v-model="persona.identificacion"
                                                        label="Cedula"
                                                        disabled>
                                                      </v-text-field>
                                                  </v-col>
                                                   <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="persona.edad"
                                                        label="Edad"
                                                        disabled>
                                                      </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="persona.sexo"
                                                        label="sexo"
                                                        disabled>
                                                      </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="datosPacienteEmgDetalle.dest"
                                                        label="DEST"
                                                        :error-messages="destErrors"
                                                        required
                                                        @input="$v.datosPacienteEmgDetalle.dest.$touch()"
                                                        @blur="$v.datosPacienteEmgDetalle.dest.$touch()">
                                                      </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="12"
                                                      md="12">
                                                      <v-textarea
                                                        v-model="datosPacienteEmgDetalle.motivoingreso"
                                                        auto-grow
                                                        label="Motivo de ingreso"
                                                        rows="2"
                                                        row-height="20"
                                                        :error-messages="motivoingresoErrors"
                                                        required
                                                        @input="$v.datosPacienteEmgDetalle.motivoingreso.$touch()"
                                                        @blur="$v.datosPacienteEmgDetalle.motivoingreso.$touch()">
                                                      </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="12"
                                                      md="12">
                                                      <v-textarea
                                                        v-model="datosPacienteEmgDetalle.diagnostico"
                                                        auto-grow
                                                        label="Impresion diagnostica"
                                                        rows="2"
                                                        row-height="20"
                                                        :error-messages="diagnosticoErrors"
                                                        required
                                                        @input="$v.datosPacienteEmgDetalle.diagnostico.$touch()"
                                                        @blur="$v.datosPacienteEmgDetalle.diagnostico.$touch()">
                                                      </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="12"
                                                      md="12">
                                                      <v-textarea
                                                        v-model="datosPacienteEmgDetalle.observaciones"
                                                        auto-grow
                                                        label="Observaciones"
                                                        rows="2"
                                                        row-height="20"
                                                        :error-messages="observacionesErrors"
                                                        required
                                                        @input="$v.datosPacienteEmgDetalle.observaciones.$touch()"
                                                        @blur="$v.datosPacienteEmgDetalle.observaciones.$touch()">
                                                      </v-textarea>
                                                    </v-col>
                                                </v-row>
                                              </v-container>
                                            </v-card-text>
                                          </v-card>
                                        </v-tab-item>
                                        <v-tab-item>
                                          <v-card flat>
                                            <v-card-text>
                                              <v-container class="grey lighten-5">
                                                <v-row>
                                                  <v-col
                                                    cols="12"
                                                    sm="12"
                                                    md="12">
                                                    <v-autocomplete
                                                        v-model="datosMedicos.enfermera_id"
                                                        label="Nombre y apellidos"
                                                        item-text="apellidosAndNombres"
                                                        item-value="id"
                                                        :items="listaEnfermeros"
                                                        :loading="isLoading"
                                                        dense
                                                        filled>
                                                    </v-autocomplete>
                                                  </v-col>
                                                </v-row>
                                              </v-container>
                                            </v-card-text>
                                          </v-card>
                                        </v-tab-item>
                                    </v-tabs-items>
                                </v-form>
                            </v-card-text>
                        </v-card>
                    </v-dialog>
                    <v-dialog v-model="dialogDelete" max-width="800px">
                      <v-card>
                        <v-card-title class="headline">Estas seguro que quiere eliminar el registro?</v-card-title>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn
                            color="blue darken-1"
                            text
                            @click="closeDelete"
                          >
                            Cancel
                          </v-btn>
                          <v-btn
                            color="blue darken-1"
                            text
                            @click="deleteItemConfirm"
                          >
                            OK
                          </v-btn>
                          <v-spacer></v-spacer>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="item">
                <v-icon
                    small
                    class="mr-2"
                    @click="editPersona(item)">
                    mdi-pencil
                </v-icon>
                <v-icon
                    small
                    class="mr-2"
                    @click="deleteItem(item)">
                    mdi-delete
                </v-icon>
            </template>
        </v-data-table>
    </v-card>
</template>
<script>
import moment from 'moment'
import { validationMixin } from 'vuelidate'
import personaService from '../services/personas/persona.js'
import pacienteEmergencia from '../services/pacienteEmergencia/pacienteEmergencia.js'
import emergenciaServices from '../services/emergencia/emergencia'
import Persona from '../models/Persona-model.js'
import Diagnostico from '../models/Diagnostico-model.js'
import MotivoIngreso from '../models/motivoIngreso-model.js'
import DatosMedicoEmg from '../models/DatosMedicoEmg-model.js'
import DatosPacienteEmgDetalle from '../models/DatosPacienteEmgDetalle-model.js'
import { required } from 'vuelidate/lib/validators'
export default {
  mixins: [validationMixin],
  validations: {
    datosMedicos: {
      persona_id: { required },
      turno: { required }
    },
    datosPacienteEmgDetalle: {
      dest: { required },
      motivoingreso: { required },
      diagnostico: { required },
      observaciones: { required }
    }
  },
  data () {
    return {
      persona: new Persona(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '',
        '', 0, 0, 0, '', '', '', '', 0),
      datosMedicos: new DatosMedicoEmg(-1, -1, '', new Date().toISOString().substr(0, 10), -1, []),
      datosPacienteEmgDetalle: new DatosPacienteEmgDetalle(-1, -1, -1, '', '', '', '', '', ''),
      diagnostico: new Diagnostico(-1, ''),
      motivoIngreso: new MotivoIngreso(-1, ''),
      isInvalid: false,
      dialogDelete: false,
      search: '',
      dialog: false,
      tab: null,
      colorValue: 'success',
      menu: false,
      listaMedicos: [],
      listaPacientes: [],
      listaEnfermeros: [],
      isLoading: false,
      messages: '',
      editedIndex: -1,
      value: '',
      items: [
        {
          name: 'Datos del médico',
          fondo: {
            color: 'black'
          }
        },
        {
          name: 'Datos del paciente',
          fondo: {
            color: 'black'
          }
        },
        {
          name: 'Enfermeras',
          fondo: {
            color: 'black'
          }
        }
      ],
      listTurnos: ['M', 'T', 'N'],
      headers: [
        {
          text: 'Id',
          value: 'id'
        },
        {
          text: 'Apellidos (paciente)',
          value: 'detalle[0].paciente.apellidos'
        },
        {
          text: 'Nombres (paciente)',
          value: 'detalle[0].paciente.nombres'
        },
        {
          text: 'Apellidos (médico)',
          value: 'medico.apellidos'
        },
        {
          text: 'Nombres (médico)',
          value: 'medico.nombres'
        },
        {
          text: 'Actions',
          value: 'actions',
          sortable: false
        }
      ],
      dataGridPersona: []
    }
  },
  watch: {
    dialog (val) {
      val || this.close()
    },
    dialogDelete (val) {
      val || this.closeDelete()
    }
  },
  created () {
    this.initialize()
  },
  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Nueva emergencia' : 'Editar emergencia'
    },
    medicoErrors () {
      const errors = []
      if (!this.$v.datosMedicos.persona_id.$dirty) return errors
      !this.$v.datosMedicos.persona_id.required && errors.push('Doctor is required.')
      return errors
    },
    turnoErrors () {
      const errors = []
      if (!this.$v.datosMedicos.turno.$dirty) return errors
      !this.$v.datosMedicos.turno.required && errors.push('Turno is required')
      return errors
    },
    destErrors () {
      const errors = []
      if (!this.$v.datosPacienteEmgDetalle.dest.$dirty) return errors
      !this.$v.datosPacienteEmgDetalle.dest.required && errors.push('Dest. is required')
      return errors
    },
    motivoingresoErrors () {
      const errors = []
      if (!this.$v.datosPacienteEmgDetalle.motivoingreso.$dirty) return errors
      !this.$v.datosPacienteEmgDetalle.motivoingreso.required && errors.push('Reason for admission is required')
      return errors
    },
    diagnosticoErrors () {
      const errors = []
      if (!this.$v.datosPacienteEmgDetalle.diagnostico.$dirty) return errors
      !this.$v.datosPacienteEmgDetalle.diagnostico.required && errors.push('Diagnostic is required')
      return errors
    },
    observacionesErrors () {
      const errors = []
      if (!this.$v.datosPacienteEmgDetalle.observaciones.$dirty) return errors
      !this.$v.datosPacienteEmgDetalle.observaciones.required && errors.push('Observation is required')
      return errors
    }
  },
  methods: {
    async save () {
      this.$v.$touch()
      const formDatosPacienteEmgDetalle = this.$v.datosPacienteEmgDetalle
      const pacienteEmgDetalleErrors = Object.keys(formDatosPacienteEmgDetalle).filter(
        function (key) {
          return formDatosPacienteEmgDetalle[key]?.$error === true
        })
      const formDatosMedicos = this.$v.datosMedicos
      const datosMedicosErrors = Object.keys(formDatosMedicos).filter(
        function (key) {
          return formDatosMedicos[key]?.$error === true
        })
      if (this.$v.$invalid) {
        this.colorValue = 'error'
        this.isInvalid = true
        this.messages = 'DEBE LLENAR TODOS LOS CAMPOS OBLIGATORIOS'
        if (datosMedicosErrors.length > 0 && pacienteEmgDetalleErrors.length > 0) {
          this.changeColorTabItem(2, true)
        } else if (datosMedicosErrors.length > 0 && pacienteEmgDetalleErrors.length === 0) {
          this.this.changeColorTabItem(0)
        } else if (datosMedicosErrors.length === 0 && pacienteEmgDetalleErrors.length > 0) {
          this.changeColorTabItem(1)
        } else {
          this.changeColorTabItem(-1)
        }
      } else {
        this.changeColorTabItem(-1)
        this.isInvalid = false
        let dataResult = []
        const detalle = []
        detalle.push(this.datosPacienteEmgDetalle)
        this.datosMedicos.detalle = detalle
        if (this.editedIndex === -1) {
          dataResult = await pacienteEmergencia.create(this.datosMedicos)
        } else {
          dataResult = await pacienteEmergencia.update(this.datosMedicos)
        }
        if (!dataResult[0]?.isSucces) {
          this.colorValue = 'error'
          const errores = dataResult[0].error.data.errors
          let mensaje = ''
          if (errores) {
            mensaje = Object.keys(errores).map(function (key, index) {
              return errores[key][index]
            })[0]
          } else {
            mensaje = dataResult[0].error.data.message
          }
          this.messages = mensaje
          this.isInvalid = true
        } else {
          this.colorValue = 'success'
          this.isInvalid = true
          this.messages = dataResult[0].data.data.message
          this.$v.$reset()
          if (this.editedIndex === -1) {
            this.clearFormulario()
          }
        }
      }
    },
    changeColorTabItem (indexChange = -1, menor = false) {
      const tabsForm = this.items
      if (indexChange === -1) {
        Object.keys(tabsForm).map(
          function (key) {
            tabsForm[key].fondo.color = 'black'
            return tabsForm[key]
          })
      } else {
        if (!menor) {
          Object.keys(tabsForm).map(
            function (key, index) {
              tabsForm[key].fondo.color = index === indexChange ? 'red' : 'black'
              return tabsForm[key]
            })
        } else {
          Object.keys(tabsForm).map(
            function (key, index) {
              tabsForm[key].fondo.color = index < indexChange ? 'red' : 'black'
              return tabsForm[key]
            })
        }
      }
    },
    updatePciente (e, i) {
      const dataPaciente = i.filter((item) => item.id === e)
      if (dataPaciente.length > 0) {
        this.persona.identificacion = dataPaciente[0].identificacion
        this.persona.sexo = dataPaciente[0].sexo
        this.persona.edad = this.calcularEdad(dataPaciente[0].fecha_nac)
        this.datosPacienteEmgDetalle.id = dataPaciente[0].id
      }
    },
    calcularEdad (fechaNac) {
      const today = moment()
      const dia = today.diff(fechaNac, 'day')
      const mes = today.diff(fechaNac, 'month')
      const year = today.diff(fechaNac, 'year')
      let edad = '0'
      if (dia > 0 && mes > 0 && year < 5) {
        edad = year + 'A ' + mes + 'M '
      } else if (dia > 0 && mes > 0 && year > 5) {
        edad = year + 'A'
      } else if (dia > 0 && mes === 0 && year === 0) {
        edad = dia + 'D'
      } else if (dia > 0 && mes > 0 && year === 0) {
        edad = mes + 'M ' + dia + ' D'
      }
      return edad
    },
    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.clearFormulario()
      })
    },

    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedIndex = -1
      })
    },
    async deleteItemConfirm () {
      const idEmergencia = this.datosMedicos.id
      this.isInvalid = false
      const dataResult = await pacienteEmergencia.delete(idEmergencia)
      if (!dataResult[0]?.isSucces) {
        this.isInvalid = true
        this.messages = dataResult[0].error.data.message
      } else {
        this.isInvalid = true
        this.messages = dataResult[0].data.data.message
        this.dataGridPersona.splice(this.editedIndex, 1)
      }
      this.closeDelete()
    },
    clearFormulario () {
      this.persona = new Persona(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '',
        '', 0, 0, 0, '', '', 0)
      this.datosMedicos = new DatosMedicoEmg(-1, -1, '', new Date().toISOString().substr(0, 10), -1, [])
      this.datosPacienteEmgDetalle = new DatosPacienteEmgDetalle(-1, -1, -1, '', '', '', '', '', '')
    },
    editPersona (item) {
      const itemSelect = item.item
      this.editedIndex = this.dataGridPersona.findIndex(emergencia => emergencia.id === itemSelect.id)
      this.datosMedicos = itemSelect
      this.datosPacienteEmgDetalle = itemSelect.detalle[0]
      itemSelect.detalle[0].paciente.edad = this.calcularEdad(itemSelect.detalle[0].paciente.fecha_nac)
      this.persona = itemSelect.detalle[0].paciente
      this.dialog = true
    },
    deleteItem (item) {
      console.log(item)
      const itemSelect = item.item
      this.datosMedicos = itemSelect
      this.datosPacienteEmgDetalle = itemSelect.detalle[0]
      this.persona = itemSelect.detalle[0].paciente
      this.editedIndex = this.dataGridPersona.findIndex(emergencia => emergencia.id === itemSelect.id)
      this.dialogDelete = true
    },
    async initialize () {
      const resultEnfermeros = await personaService.getListEnfermeros()
      if (resultEnfermeros[0].isSucces) {
        this.listaEnfermeros = resultEnfermeros[0].data
      } else {
        this.listaEnfermeros = []
      }
      const resultPacientes = await personaService.getListPacientes()
      if (resultPacientes[0].isSucces) {
        this.listaPacientes = resultPacientes[0].data
      } else {
        this.listaPacientes = []
      }
      const resultMedicos = await personaService.getListMedicos()
      if (resultMedicos[0].isSucces) {
        this.listaMedicos = resultMedicos[0].data
      } else {
        this.listaMedicos = []
      }
      const result = await emergenciaServices.getList()
      if (result[0].isSucces) {
        this.dataGridPersona = result[0].data.data.data
      } else {
        this.dataGridPersona = []
      }
    },
    closeDatepicker () {
      this.$refs.menu.save(this.date)
    }
  }
}
</script>
<style lang="scss">
  @import '../assets/main.scss';
  .v-card {
    display: flex !important;
    flex-direction: column;
  }
  .v-card__text {
    flex-grow: 1;
    overflow: auto;
  }
  .v-toolbar__title {
    width: 100%;
  }
  .tittle-form {
    justify-content: center;
    display: flex;
    background: blue;
    color: white;
    width: 100%;
    height: 100%;
    padding: 10px;
  }
  .v-window__container {
    height: 394px;
  }
  .v-snack--absolute {
    z-index: 999;
  }
</style>
