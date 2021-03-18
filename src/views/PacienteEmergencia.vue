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
                        max-width="800px">
                        <template v-slot:activator="{ on, attrs }">
                            <v-btn
                                color="primary"
                                dark
                                class="mb-2"
                                v-bind="attrs"
                                v-on="on">
                                Nueva paciente
                            </v-btn>
                        </template>
                        <v-card height="570px">
                            <v-toolbar flat>
                                <v-toolbar-title>
                                    <div class="tittle-form">
                                        Nuevo paciente
                                    </div>
                                </v-toolbar-title>
                            </v-toolbar>
                            <v-card-text style="background:#aeaeae; padding:10px;">
                                <v-form>
                                    <v-tabs
                                        v-model="tab"
                                        grow>
                                        <v-tab
                                            v-for="item in items"
                                            :key="item">
                                            {{ item }}
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
                                                                label="Turno">
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
                                                        label="Cedula">
                                                      </v-text-field>
                                                  </v-col>
                                                   <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="persona.edad"
                                                        label="Edad"
                                                        readonly>
                                                      </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="persona.sexo"
                                                        label="sexo"
                                                        readonly>
                                                      </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="3"
                                                      md="3">
                                                      <v-text-field
                                                        v-model="datosPacienteEmgDetalle.dest"
                                                        label="DEST">
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
                                                        row-height="20">
                                                      </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                      cols="12"
                                                      sm="12"
                                                      md="12">
                                                      <v-textarea
                                                        v-model="datosPacienteEmgDetalle.dignostico"
                                                        auto-grow
                                                        label="Impresion diagnostica"
                                                        rows="2"
                                                        row-height="20">
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
                                                        row-height="20">
                                                      </v-textarea>
                                                    </v-col>
                                                </v-row>
                                              </v-container>
                                            </v-card-text>
                                          </v-card>
                                        </v-tab-item>
                                        <v-tab-item></v-tab-item>
                                    </v-tabs-items>
                                </v-form>
                            </v-card-text>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="close">
                                    Cancel
                                </v-btn>
                                <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="save">
                                    Save
                                </v-btn>
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
import Persona from '../models/Persona-model.js'
import Diagnostico from '../models/Diagnostico-model.js'
import MotivoIngreso from '../models/motivoIngreso-model.js'
import DatosMedicoEmg from '../models/DatosMedicoEmg-model.js'
import DatosPacienteEmgDetalle from '../models/DatosPacienteEmgDetalle-model.js'
export default {
  mixins: [validationMixin],
  validations: {
    datosPacienteEmgDetalle: {}
  },
  data () {
    return {
      persona: new Persona(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '',
        '', 0, 0, 0, '', '', '', '', 0),
      datosMedicos: new DatosMedicoEmg(-1, -1, '', new Date().toISOString().substr(0, 10)),
      datosPacienteEmgDetalle: new DatosPacienteEmgDetalle(-1, -1, -1, '', '', '', '', '', ''),
      diagnostico: new Diagnostico(-1, ''),
      motivoIngreso: new MotivoIngreso(-1, ''),
      search: '',
      dialog: false,
      tab: null,
      menu: false,
      listaMedicos: [],
      listaPacientes: [],
      isLoading: false,
      editedIndex: -1,
      value: '',
      items: [
        'Datos del médico', 'Datos del Paciente', 'Enfermeras'
      ],
      listTurnos: ['M', 'T', 'N'],
      headers: [
        {
          text: 'Id',
          value: 'id'
        },
        {
          text: 'Tipo',
          value: 'tipo_id'
        },
        {
          text: 'Identificación',
          value: 'identificacion'
        },
        {
          text: 'Apellidos',
          value: 'apellidos'
        },
        {
          text: 'Nombres',
          value: 'nombres'
        },
        {
          text: 'Email',
          value: 'email'
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
  methods: {
    async save () {
      alert('save')
      if (this.editedIndex === -1) {
        let dataResult = []
        let dataResultDetalle = []
        dataResult = await pacienteEmergencia.create(this.datosMedicos)
        if (dataResult[0].isSucces) {
          const idPacienteEmergencia = dataResult[0].data.data.data.id
          this.datosPacienteEmgDetalle.emergencia_id = idPacienteEmergencia
          dataResultDetalle = await pacienteEmergencia.createDetalle(this.datosPacienteEmgDetalle)
          if (dataResultDetalle[0].isSucces) {
            console.log(dataResultDetalle[0].error.data.message)
          } else {}
        } else {}
      } else {}
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
      this.$nextTick(() => {})
    },
    editPersona (item) {
      this.dialog = true
    },
    deleteItem (item) {},
    async initialize () {
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
      const result = await personaService.getList()
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
</style>
