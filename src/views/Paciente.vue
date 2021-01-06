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
                        <v-snackbar
                          :timeout="3000"
                          :value="isInvalid"
                          absolute
                          right
                          shaped
                          top>
                          {{ messages }}
                        </v-snackbar>
                        <v-col
                          cols="12"
                          sm="2"
                          md="2"
                        >
                          <v-select
                            v-model="paciente.tipoId"
                            :items="nacionalidades"
                            :error-messages="tipoIdErrors"
                            label="Nationality"
                            required
                            @change="$v.paciente.tipoId.$touch()"
                            @blur="$v.paciente.tipoId.$touch()">
                          </v-select>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="3"
                          md="3"
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
                      </v-row>
                    </v-container>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    text>
                    Cancel
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text>
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
          @click="editItem(item)">
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
      tipoId: { required },
      sexo: { required }
    }
  },
  data () {
    return {
      paciente: new Paciente('', '', '', '', '', '', new Date().toISOString().substr(0, 10)),
      search: '',
      isInvalid: false,
      dialog: false,
      editedIndex: -1,
      dialogDelete: false,
      messages: '',
      nacionalidades: ['V', 'E', 'P'],
      listSexo: ['M', 'F'],
      edad: '',
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
      console.log(this.$v.paciente.identificacion)
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
      if (!this.$v.paciente.tipoId.$dirty) return errors
      !this.$v.paciente.tipoId.required && errors.push('Nacionality is required')
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
    getitemcontrols () {
      return 'item.actions'
    },
    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.editedIndex = -1
      })
    },
    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedIndex = -1
      })
    },
    editItem () {},
    deleteItem () {},
    deleteItemConfirm () {},
    closeDatepicker () {
      const today = moment()
      const dia = today.diff(this.paciente.fechaNac, 'day')
      const mes = today.diff(this.paciente.fechaNac, 'month')
      const year = today.diff(this.paciente.fechaNac, 'year')
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
      this.edad = edad
      this.$refs.menu.save(this.paciente.fechaNac)
    }
  }
}
</script>
