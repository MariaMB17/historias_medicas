<template>
  <v-card class="change-color">
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
      :items="dataGrid"
      :search="search">
      <template v-slot:top>
        <v-snackbar
          :timeout="3000"
          :value="isInvalid"
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
            max-width="820px"
            content-class="dialog-persona"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on">
                  Nueva persona
                </v-btn>
              </template>
              <v-card height="590px">
                <v-toolbar flat>
                  <v-toolbar-title>
                    <div class="tittle-form">
                      {{ formTitle }}
                    </div>
                  </v-toolbar-title>
                </v-toolbar>
                <v-card-text style="background:#aeaeae; padding:10px;">
                  <v-form>
                    <v-tabs fixed-tabs>
                      <v-tab>
                        Datos Personales
                      </v-tab>
                      <v-tab
                        :disabled="isDisableTabEmpleado">
                        Empleados
                      </v-tab>
                      <v-tab
                        :disabled="isDisabledTabMedico">
                        Datos médicos
                      </v-tab>

                      <v-tab-item style="height:58vh; overflow: auto;">
                      <v-card flat>
                        <v-card-text>
                          <v-container class="grey lighten-5">
                          <v-row>
                            <v-col
                                cols="12"
                                sm="3"
                                md="3">
                                <v-select
                                    v-model="persona.tipo_id"
                                    :items="nacionalidades"
                                    :error-messages="tipoIdErrors"
                                    label="Nationality"
                                    required
                                    @change="$v.persona.tipo_id.$touch()"
                                    @blur="$v.persona.tipo_id.$touch()">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.identificacion"
                                  label="Cedula"
                                  :error-messages="identificacionErrors"
                                  :counter="10"
                                  @input="$v.persona.identificacion.$touch()"
                                  @blur="$v.persona.identificacion.$touch()">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="5"
                                md="5">
                                <v-text-field
                                  v-model="persona.nombres"
                                  label="Firts name"
                                  :error-messages="nombresErrors"
                                  :counter="255"
                                  @input="$v.persona.nombres.$touch()"
                                  @blur="$v.persona.nombres.$touch()">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="5"
                                md="5">
                                  <v-text-field
                                    v-model="persona.apellidos"
                                    label="Second Name"
                                    :error-messages="apellidosErrors"
                                    :counter="255"
                                    @input="$v.persona.apellidos.$touch()"
                                    @blur="$v.persona.apellidos.$touch()">
                                  </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-menu
                                  ref='menu'
                                  v-model='menu'
                                  :close-on-content-click='false'
                                  :return-value.sync='persona.fecha_nac'
                                  transition="scale-transition"
                                  offset-y
                                  min-width='290px'>
                                  <template v-slot:activator="{ on, attrs }">
                                    <v-text-field
                                      v-model="persona.fecha_nac"
                                      label="Birthdate"
                                      prepend-icon="mdi-calendar"
                                      readonly
                                      v-bind="attrs"
                                      v-on="on">
                                    </v-text-field>
                                  </template>
                                  <v-date-picker
                                    v-model="persona.fecha_nac"
                                    no-title scrollable
                                    @click="functionEvents">
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
                                sm="6"
                                md="6">
                                  <v-text-field
                                    v-model="persona.email"
                                    :error-messages="emailErrors"
                                    label="E-mail"
                                    required
                                    @input="$v.persona.email.$touch()"
                                    @blur="$v.persona.email.$touch()">
                                  </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                  v-model="persona.tipo_persona_id "
                                  :items="dataTipoPersona"
                                  item-text="descripcion"
                                  item-value="id"
                                  label="Tipo de persona"
                                  @change="activarTabPersona">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-select
                                  v-model="persona.sexo"
                                  :items="listSexo"
                                  :error-messages="sexoErrors"
                                  label="Sexo"
                                  required
                                  @change="$v.persona.sexo.$touch()"
                                  @blur="$v.persona.sexo.$touch()">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.talla"
                                  label="Talla">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.peso"
                                  label="Peso">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="12"
                                md="12">
                                <v-textarea
                                  v-model="persona.direccion"
                                  auto-grow
                                  label="Direccion"
                                  rows="2"
                                  row-height="20">
                                </v-textarea>
                              </v-col>
                            </v-row>
                          </v-container>
                          </v-card-text>
                        </v-card>
                      </v-tab-item>
                      <v-tab-item style="height:58vh;overflow: auto;">
                        <v-card flat>
                          <v-card-text>
                          <v-container class="grey lighten-5">
                            <v-row>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                  v-model="persona.area_id"
                                  :items="dataArea"
                                  item-text="descripcion"
                                  item-value="id"
                                  label="Area">
                                </v-select>
                              </v-col>
                            </v-row>
                          </v-container>
                          </v-card-text>
                        </v-card>
                      </v-tab-item>
                      <v-tab-item style="height:58vh;overflow: auto;">
                        <v-card flat>
                          <v-card-text>
                          <v-container class="grey lighten-5">
                            <v-row>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                v-model="persona.especialidad_id"
                                :items="dataEspecialidad"
                                item-text="descripcion"
                                item-value="id"
                                label="Especialidad">
                              </v-select>
                            </v-col>
                          </v-row>
                        </v-container>
                        </v-card-text>
                      </v-card>
                    </v-tab-item>
                    </v-tabs>
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
      <template v-slot:no-data></template>
    </v-data-table>
  </v-card>
</template>
<script>
import moment from 'moment'
import { validationMixin } from 'vuelidate'
import Persona from '../models/Persona-model.js'
import personaService from '../services/personas/persona.js'
import especialidadService from '../services/especialidad/especialidad.js'
import tipoPersonaService from '../services/tipoPersona/tipoPersona.js'
import areaService from '../services/area/area.js'
import { required, maxLength, email } from 'vuelidate/lib/validators'
export default {
  mixins: [validationMixin],
  validations: {
    persona: {
      identificacion: { required, maxLength: maxLength(10) },
      nombres: { required, maxLength: maxLength(255) },
      apellidos: { required, maxLength: maxLength(255) },
      email: { required, email },
      tipo_id: { required },
      sexo: { required },
      especialidad_id: { required }
    }
  },
  data () {
    return {
      persona: new Persona(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '',
        '', 0, 0, 0, '', '', '', '', 0),
      search: '',
      isInvalid: false,
      dialog: false,
      editedIndex: -1,
      dialogDelete: false,
      messages: '',
      nacionalidades: ['V', 'E', 'P'],
      listSexo: ['M', 'F'],
      menu: false,
      isDisabledTabMedico: true,
      isDisableTabEmpleado: true,
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
      dataGrid: [],
      dataArea: [],
      dataTipoPersona: [],
      dataEspecialidad: []
    }
  },
  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Nueva persona' : 'Editar persona'
    },
    identificacionErrors () {
      const errors = []
      if (!this.$v.persona.identificacion.$dirty) return errors
      !this.$v.persona.identificacion.maxLength && errors.push('Cedula must be at most 10 characters long')
      !this.$v.persona.identificacion.required && errors.push('Cedula is required.')
      return errors
    },
    nombresErrors () {
      const errors = []
      if (!this.$v.persona.nombres.$dirty) return errors
      !this.$v.persona.nombres.maxLength && errors.push('First name must be at most 10 characters long')
      !this.$v.persona.nombres.required && errors.push('First name is required.')
      return errors
    },
    apellidosErrors () {
      const errors = []
      if (!this.$v.persona.apellidos.$dirty) return errors
      !this.$v.persona.apellidos.maxLength && errors.push('Second name must be at most 10 characters long')
      !this.$v.persona.apellidos.required && errors.push('Second name is required.')
      return errors
    },
    emailErrors () {
      const errors = []
      if (!this.$v.persona.email.$dirty) return errors
      !this.$v.persona.email.email && errors.push('Must be valid e-mail')
      !this.$v.persona.email.required && errors.push('E-mail is required')
      return errors
    },
    tipoIdErrors () {
      const errors = []
      if (!this.$v.persona.tipo_id.$dirty) return errors
      !this.$v.persona.tipo_id.required && errors.push('Nacionality is required')
      return errors
    },
    sexoErrors () {
      const errors = []
      if (!this.$v.persona.sexo.$dirty) return errors
      !this.$v.persona.sexo.required && errors.push('Sexo is required')
      return errors
    },
    especialidadErrors () {
      const errors = []
      if (!this.$v.persona.especialidad_id.$dirty) return errors
      !this.$v.persona.especialidad_id.required && errors.push('Especility is required')
      return errors
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
    this.initializeArea()
    this.initializeEspecilidad()
    this.initializeTipoPersona()
  },
  methods: {
    async initializeEspecilidad () {
      const resultEspec = await especialidadService.getList()
      this.dataEspecialidad = []
      if (resultEspec[0].isSucces) {
        this.dataEspecialidad = resultEspec[0].data.data.data
      }
    },
    async initializeArea () {
      const resultArea = await areaService.getList()
      this.dataArea = []
      this.persona.area_id = 2
      if (resultArea[0].isSucces) {
        this.dataArea = resultArea[0].data.data.data
      }
    },
    async initializeTipoPersona () {
      const resultTipoPersona = await tipoPersonaService.getList()
      this.dataTipoPersona = []
      if (resultTipoPersona[0].isSucces) {
        this.dataTipoPersona = resultTipoPersona[0].data.data.data
      }
    },
    async initialize () {
      const result = await personaService.getList()
      if (result[0].isSucces) {
        this.dataGrid = result[0].data.data.data
      } else {
        this.dataGrid = []
      }
    },
    async save () {
      this.$v.$touch()
      if (this.$v.$invalid) {
        this.isInvalid = true
        this.messages = 'DEBE LLENAR TODOS LOS CAMPOS OBLIGATORIOS'
      } else {
        this.isInvalid = false
        let dataResult = []
        if (this.editedIndex === -1) {
          dataResult = await personaService.create(this.persona)
        } else {
          dataResult = await personaService.update(this.persona)
        }
        if (!dataResult[0]?.isSucces) {
          this.isInvalid = true
          this.messages = dataResult[0].error.data.message
        } else {
          this.isInvalid = true
          this.messages = dataResult[0].data.data.message
          const newData = dataResult[0].data.data.data
          if (this.editedIndex === -1) {
            this.dataGrid.push(newData)
          } else {
            Object.assign(this.dataGrid[this.editedIndex], newData)
          }
          this.close()
        }
      }
    },
    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.editedIndex = -1
        this.$v.$reset()
        this.clearFormulario()
        this.isDisabledTabMedico = true
        this.isDisableTabEmpleado = true
      })
    },
    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedIndex = -1
        this.isDisabledTabMedico = true
        this.isDisableTabEmpleado = true
      })
    },
    editPersona (item) {
      const itemSelect = item.item
      this.editedIndex = this.dataGrid.findIndex(persona => persona.id === itemSelect.id)
      itemSelect.edad = this.calcularEdad(itemSelect.fecha_nac)
      this.persona = itemSelect
      this.dialog = true
    },
    deleteItem (item) {
      const itemSelect = item.item
      this.persona = itemSelect
      this.editedIndex = this.dataGrid.findIndex(persona => persona.id === itemSelect.id)
      this.dialogDelete = true
    },
    activarTabPersona (typePerson) {
      this.isDisabledTabMedico = true
      this.isDisableTabEmpleado = true
      this.persona.especialidad_id = 2
      this.persona.area_id = 2
      if (typePerson === 1) {
        this.isDisabledTabMedico = false
        this.isDisableTabEmpleado = false
        this.persona.especialidad_id = 2
      } else if (typePerson !== 3) {
        this.isDisableTabEmpleado = false
        this.persona.area_id = 2
      }
    },
    async deleteItemConfirm () {
      const idPersona = this.persona.id
      const dataResult = await personaService.delete(idPersona)
      if (!dataResult[0]?.isSucces) {
        this.isInvalid = true
        this.messages = dataResult[0].error.data.message
      } else {
        this.dataGrid.splice(this.editedIndex, 1)
      }
      this.closeDelete()
    },
    closeDatepicker () {
      this.persona.edad = this.calcularEdad(this.persona.fecha_nac)
      this.$refs.menu.save(this.persona.fecha_nac)
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
    functionEvents (date) {
      console.log(this.date)
    },
    clearFormulario () {
      this.persona = new Persona(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '',
        '', 0, 0, 0, '', '', 0)
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
