<template>
<v-container>
  <v-row no-gutters>
    <v-col cols="12" style="margin-bottom:12px;">
      <v-toolbar dense>
        <v-btn icon @click="submit">
          <v-icon>mdi-checkbox-marked-circle</v-icon>
        </v-btn>
        <v-btn icon @click="clear">
          <v-icon>mdi-delete-circle</v-icon>
        </v-btn>
      </v-toolbar>
    </v-col>
  </v-row>
  <v-form>
    <v-container class="grey lighten-5">
      <v-row>
        <v-snackbar :timeout="3000"
        :value="isInvalid"
        absolute
        right
        shaped
        top
        >
         {{ messages }}
        </v-snackbar>
        <v-col
          cols="12"
          sm="2"
          md="2"
        >
          <v-select v-model="paciente.tipoId"
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
          <v-text-field v-model="paciente.identificacion" label="Cedula"
          :error-messages="identificacionErrors"
          :counter="10"
          @input="$v.paciente.identificacion.$touch()"
          @blur="$v.paciente.identificacion.$touch()"
          ></v-text-field>
        </v-col>
        <v-col
          cols="1"></v-col>
         <v-col
          cols="12"
          sm="5"
          md="5"
        >
          <v-text-field v-model="paciente.nombres" label="Firts name"
          :error-messages="nombresErrors"
          :counter="255"
          @input="$v.paciente.nombres.$touch()"
          @blur="$v.paciente.nombres.$touch()"></v-text-field>
        </v-col>
        <v-col
          cols="12"
          sm="5"
          md="5"
        >
          <v-text-field v-model="paciente.apellidos" label="Second Name"
          :error-messages="apellidosErrors"
          :counter="255"
          @input="$v.paciente.apellidos.$touch()"
          @blur="$v.paciente.apellidos.$touch()"
          ></v-text-field>
        </v-col>
        <v-col
          sm="1" md="1"></v-col>
        <v-col
          cols="12"
          sm="2"
          md="2"
        >
        <v-menu ref='menu' v-model='menu'
          :close-on-content-click='false'
          :return-value.sync='paciente.fechaNac'
          transition="scale-transition"
          offset-y
          min-width='290px'>
          <template v-slot:activator="{ on, attrs }">
            <v-text-field v-model="paciente.fechaNac"
              label="Birthdate"
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
        </template>
        <v-date-picker v-model="paciente.fechaNac" no-title scrollable
            @click="functionEvents"
          >
          <v-spacer></v-spacer>
            <v-btn text color="primary" @click="menu = false">
             Cancel
            </v-btn>
            <v-btn text color="primary"
              @click="closeDatepicker"
            >
              OK
            </v-btn>
          </v-date-picker>
        </v-menu>
        </v-col>
        <v-col
          sm="1" md="1">
        </v-col>
         <v-col
          cols="12"
          sm="2"
          md="2"
        >
          <v-text-field v-model="edad" label="Edad" readonly></v-text-field>
        </v-col>
        <v-col
          cols="12"
          sm="2"
          md="2"
        >
         <v-select v-model="paciente.sexo"
          :items="listSexo"
          :error-messages="tipoIdErrors"
          label="Sexo"
          required
          @change="$v.paciente.sexo.$touch()"
          @blur="$v.paciente.sexo.$touch()">
          </v-select>
        </v-col>
        <v-col
          cols="12"
          sm="3"
          md="3"
        >
        <v-text-field v-model="paciente.email" :error-messages="emailErrors"
        label="E-mail"
        required
        @input="$v.paciente.email.$touch()"
        @blur="$v.paciente.email.$touch()"
        ></v-text-field>
        </v-col>
        </v-row>
    </v-container>
  </v-form>
</v-container>
</template>
<script>
import moment from 'moment'
import { validationMixin } from 'vuelidate'
import { required, maxLength, email } from 'vuelidate/lib/validators'
import pacienteService from '../services/pacientes/paciente.js'
import Paciente from '../models/Paciente-model.js'
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
      nacionalidades: ['V', 'E', 'P'],
      listSexo: ['M', 'F'],
      edad: '',
      menu: false,
      checkbox: false,
      isInvalid: false,
      messages: ''
    }
  },
  mounted () {
    pacienteService.get()
  },
  computed: {
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
  methods: {
    async submit () {
      this.$v.$touch()
      console.log(this.$v.$invalid)
      if (this.$v.$invalid) {
        console.log(this.$v)
        this.isInvalid = true
        this.messages = 'DEBE LLENAR TODOS LOS CAMPOS OBLIGATORIOS'
      } else {
        this.isInvalid = false
        const dataResult = await pacienteService.create(this.paciente)
        if (!dataResult[0].isSucces) {
          this.isInvalid = true
          this.messages = dataResult[0].error.data.message
        } else {
          this.isInvalid = true
          this.messages = dataResult[0].data.data.message
        }
        console.log(dataResult)
      }
    },
    clear () {
      this.$v.$reset()
    },
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
    },
    functionEvents (date) {
      console.log(this.date)
    }
  }
}
</script>
