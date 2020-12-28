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
        <v-col
          cols="12"
          sm="5"
          md="5"
        >
          <v-text-field v-model="cedula" label="Cedula"
          :error-messages="cedulaErrors"
          :counter="10"
          @input="$v.cedula.$touch()"
          @blur="$v.cedula.$touch()"
          ></v-text-field>
        </v-col>
        <v-col
          cols="1"></v-col>
         <v-col
          cols="12"
          sm="5"
          md="5"
        >
          <v-text-field v-model="firtsName" label="Firts name"
          :error-messages="firtsNameErrors"
          :counter="255"
          @input="$v.firtsName.$touch()"
          @blur="$v.firtsName.$touch()"></v-text-field>
        </v-col>
        <v-col
          cols="12"
          sm="5"
          md="5"
        >
          <v-text-field v-model="secondName" label="Second Name"
          :error-messages="secondNameErrors"
          :counter="255"
          @input="$v.secondName.$touch()"
          @blur="$v.secondName.$touch()"
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
          :return-value.sync='date'
          transition="scale-transition"
          offset-y
          min-width='290px'>
          <template v-slot:activator="{ on, attrs }">
            <v-text-field v-model="date"
              label="Birthdate"
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
        </template>
        <v-date-picker v-model="date" no-title scrollable
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
          sm="5"
          md="5"
        >
        <v-text-field v-model="email" :error-messages="emailErrors"
        label="E-mail"
        required
        @input="$v.email.$touch()"
        @blur="$v.email.$touch()"
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
export default {
  mixins: [validationMixin],

  validations: {
    cedula: { required, maxLength: maxLength(10) },
    firtsName: { required, maxLength: maxLength(255) },
    secondName: { required, maxLength: maxLength(255) },
    email: { required, email },
    select: { required },
    checkbox: {
      checked (val) {
        return val
      }
    }
  },
  data: () => ({
    cedula: '',
    firtsName: '',
    secondName: '',
    email: '',
    select: null,
    edad: '',
    items: [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4'
    ],
    date: new Date().toISOString().substr(0, 10),
    menu: false,
    checkbox: false
  }),
  mounted () {
    pacienteService.get()
  },
  computed: {
    checkboxErrors () {
      const errors = []
      if (!this.$v.checkbox.$dirty) return errors
      !this.$v.checkbox.checked && errors.push('You must agree to continue!')
      return errors
    },
    selectErrors () {
      const errors = []
      if (!this.$v.select.$dirty) return errors
      !this.$v.select.required && errors.push('Item is required')
      return errors
    },
    cedulaErrors () {
      const errors = []
      if (!this.$v.cedula.$dirty) return errors
      !this.$v.cedula.maxLength && errors.push('Cedula must be at most 10 characters long')
      !this.$v.cedula.required && errors.push('Cedula is required.')
      return errors
    },
    firtsNameErrors () {
      const errors = []
      if (!this.$v.firtsName.$dirty) return errors
      !this.$v.firtsName.maxLength && errors.push('First name must be at most 10 characters long')
      !this.$v.firtsName.required && errors.push('First name is required.')
      return errors
    },
    secondNameErrors () {
      const errors = []
      if (!this.$v.secondName.$dirty) return errors
      !this.$v.secondName.maxLength && errors.push('Second name must be at most 10 characters long')
      !this.$v.secondName.required && errors.push('Second name is required.')
      return errors
    },
    emailErrors () {
      const errors = []
      if (!this.$v.email.$dirty) return errors
      !this.$v.email.email && errors.push('Must be valid e-mail')
      !this.$v.email.required && errors.push('E-mail is required')
      return errors
    }
  },
  methods: {
    submit () {
      this.$v.$touch()
    },
    clear () {
      this.$v.$reset()
      this.cedula = ''
      this.firtsName = ''
      this.secondName = ''
      this.email = ''
      this.select = null
      this.checkbox = false
    },
    closeDatepicker () {
      const today = moment()
      const dia = today.diff(this.date, 'day')
      const mes = today.diff(this.date, 'month')
      const year = today.diff(this.date, 'year')
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
      this.$refs.menu.save(this.date)
    },
    functionEvents (date) {
      console.log(this.date)
    }
  }
}
</script>
