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
          <v-toolbar-title>Pacientes</v-toolbar-title>
          <v-divider
            class="mx-4"
            inset
            vertical>
          </v-divider>
          <v-spacer></v-spacer>
          <v-dialog
            v-model="dialog"
            max-width="800px"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on">
                  Nuevo Paciente
                </v-btn>
              </template>
              <v-card>
                <v-card-title>
                  <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-form>
                    <v-container class="grey lighten-5">
                      <v-row>
                        <v-col
                          cols="12"
                          sm="2"
                          md="2"
                        >
                          <v-select
                            v-model="paciente.tipo_id"
                            :items="nacionalidades"
                            :error-messages="tipoIdErrors"
                            label="Nationality"
                            required
                            @change="$v.paciente.tipo_id.$touch()"
                            @blur="$v.paciente.tipo_id.$touch()">
                          </v-select>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="4"
                          md="4"
                        >
                          <v-text-field
                            v-model="paciente.identificacion"
                            label="Cedula"
                            :error-messages="identificacionErrors"
                            :counter="10"
                            @input="$v.paciente.identificacion.$touch()"
                            @blur="$v.paciente.identificacion.$touch()">
                          </v-text-field>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="6"
                          md="6">
                          <v-text-field
                            v-model="paciente.nombres"
                            label="Firts name"
                            :error-messages="nombresErrors"
                            :counter="255"
                            @input="$v.paciente.nombres.$touch()"
                            @blur="$v.paciente.nombres.$touch()">
                          </v-text-field>
                        </v-col>
                         <v-col
                          cols="12"
                          sm="6"
                          md="6">
                            <v-text-field
                              v-model="paciente.apellidos"
                              label="Second Name"
                              :error-messages="apellidosErrors"
                              :counter="255"
                              @input="$v.paciente.apellidos.$touch()"
                              @blur="$v.paciente.apellidos.$touch()">
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
                              :return-value.sync='paciente.fecha_nac'
                              transition="scale-transition"
                              offset-y
                              min-width='290px'>
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="paciente.fecha_nac"
                                  label="Birthdate"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on">
                                </v-text-field>
                              </template>
                              <v-date-picker
                                v-model="paciente.fecha_nac"
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
                          sm="2"
                          md="2">
                            <v-text-field
                              v-model="paciente.edad"
                              label="Edad"
                              readonly>
                            </v-text-field>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="2"
                          md="2">
                          <v-select
                            v-model="paciente.sexo"
                            :items="listSexo"
                            :error-messages="sexoErrors"
                            label="Sexo"
                            required
                            @change="$v.paciente.sexo.$touch()"
                            @blur="$v.paciente.sexo.$touch()">
                          </v-select>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="4"
                          md="4">
                            <v-text-field
                              v-model="paciente.email"
                              :error-messages="emailErrors"
                              label="E-mail"
                              required
                              @input="$v.paciente.email.$touch()"
                              @blur="$v.paciente.email.$touch()">
                            </v-text-field>
                        </v-col>
                      </v-row>
                    </v-container>
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
                <v-card-title class="headline">Estas seguro que quiere eliminar el paciente?</v-card-title>
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
          @click="editPaciente(item)">
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
import Paciente from '../models/Paciente-model.js'
import pacienteService from '../services/pacientes/paciente.js'
import { required, maxLength, email } from 'vuelidate/lib/validators'
export default {
  mixins: [validationMixin],
  validations: {
    paciente: {
      identificacion: { required, maxLength: maxLength(10) },
      nombres: { required, maxLength: maxLength(255) },
      apellidos: { required, maxLength: maxLength(255) },
      email: { required, email },
      tipo_id: { required },
      sexo: { required }
    }
  },
  data () {
    return {
      paciente: new Paciente(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), ''),
      search: '',
      isInvalid: false,
      dialog: false,
      editedIndex: -1,
      dialogDelete: false,
      messages: '',
      nacionalidades: ['V', 'E', 'P'],
      listSexo: ['M', 'F'],
      menu: false,
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
      dataGrid: []
    }
  },
  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Nuevo paciente' : 'Editar paciente'
    },
    identificacionErrors () {
      const errors = []
      if (!this.$v.paciente.identificacion.$dirty) return errors
      !this.$v.paciente.identificacion.maxLength && errors.push('Cedula must be at most 10 characters long')
      !this.$v.paciente.identificacion.required && errors.push('Cedula is required.')
      return errors
    },
    nombresErrors () {
      const errors = []
      if (!this.$v.paciente.nombres.$dirty) return errors
      !this.$v.paciente.nombres.maxLength && errors.push('First name must be at most 10 characters long')
      !this.$v.paciente.nombres.required && errors.push('First name is required.')
      return errors
    },
    apellidosErrors () {
      const errors = []
      if (!this.$v.paciente.apellidos.$dirty) return errors
      !this.$v.paciente.apellidos.maxLength && errors.push('Second name must be at most 10 characters long')
      !this.$v.paciente.apellidos.required && errors.push('Second name is required.')
      return errors
    },
    emailErrors () {
      const errors = []
      if (!this.$v.paciente.email.$dirty) return errors
      !this.$v.paciente.email.email && errors.push('Must be valid e-mail')
      !this.$v.paciente.email.required && errors.push('E-mail is required')
      return errors
    },
    tipoIdErrors () {
      const errors = []
      if (!this.$v.paciente.tipo_id.$dirty) return errors
      !this.$v.paciente.tipo_id.required && errors.push('Nacionality is required')
      return errors
    },
    sexoErrors () {
      const errors = []
      if (!this.$v.paciente.sexo.$dirty) return errors
      !this.$v.paciente.sexo.required && errors.push('Sexo is required')
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
  },
  methods: {
    async initialize () {
      const result = await pacienteService.getList()
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
          dataResult = await pacienteService.create(this.paciente)
        } else {
          dataResult = await pacienteService.update(this.paciente)
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
      })
    },
    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedIndex = -1
      })
    },
    editPaciente (item) {
      const itemSelect = item.item
      this.editedIndex = this.dataGrid.findIndex(paciente => paciente.id === itemSelect.id)
      itemSelect.edad = this.calcularEdad(itemSelect.fecha_nac)
      this.paciente = itemSelect
      this.dialog = true
    },
    deleteItem (item) {
      const itemSelect = item.item
      this.paciente = itemSelect
      this.editedIndex = this.dataGrid.findIndex(paciente => paciente.id === itemSelect.id)
      this.dialogDelete = true
    },
    async deleteItemConfirm () {
      const idPaciente = this.paciente.id
      const dataResult = await pacienteService.delete(idPaciente)
      if (!dataResult[0]?.isSucces) {
        this.isInvalid = true
        this.messages = dataResult[0].error.data.message
      } else {
        this.dataGrid.splice(this.editedIndex, 1)
      }
      this.closeDelete()
    },
    closeDatepicker () {
      this.paciente.edad = this.calcularEdad(this.paciente.fecha_nac)
      this.$refs.menu.save(this.paciente.fecha_nac)
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
      this.paciente = new Paciente(-1, '', '', '', '', '', '', new Date().toISOString().substr(0, 10), '')
    }
  }
}
</script>
