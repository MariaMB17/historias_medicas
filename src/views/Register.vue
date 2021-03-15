<template>
  <v-container>
      <v-layout row>
          <v-flex xs12 sm6 m4 offset-xs0 offset-sm3 offset-m4>
              <v-form>
                  <v-text-field label="Nombre de Usuario" v-model="user.name"></v-text-field>
                  <v-text-field label="Email" v-model="user.email"></v-text-field>
                  <v-text-field label="Contraseña" type="password" v-model="user.password"></v-text-field>
                  <v-text-field label="Confirmar Contraseña" type="password" v-model="user.passwordConfirmation"></v-text-field>
                  <v-btn block color="primary" @click="handleRegister">Registrarse</v-btn>
                  <v-snackbar
                    v-model="snackbar"
                    :color="colorValue"
                    :bottom="y === 'bottom'"
                    :right="x"
                    :multi-line="mode === 'multi-line'"
                    :timeout="timeout"
                    :top="y === 'top'"
                    :vertical="mode === 'vertical'"
                  >
                  {{ message }}
                <v-btn
                  dark
                  text
                  @click="snackbar = false"
                >
                  Close
                </v-btn>
                </v-snackbar>
              </v-form>
        </v-flex>
      </v-layout>
  </v-container>
</template>
<script>
import User from '../models/User-model.js'
export default {
  data () {
    return {
      snackbar: false,
      y: 'top',
      x: 'right',
      mode: '',
      colorValue: 'cyan darken-2',
      timeout: 4000,
      user: new User('', '', '', '', false),
      successful: false,
      message: ''
    }
  },
  created () {
    this.$store.commit('SET_LAYOUT', 'login-layout')
  },
  methods: {
    handleRegister () {
      this.$store.dispatch('auth/register', this.user).then(
        data => {
          this.successful = true
          this.$router.push('/').catch(error => {
            if (error.name !== 'NavigationDuplicated') {
              throw error
            }
          })
        },
        error => {
          if (error.request.status) {
            this.successful = false
            this.colorValue = 'error'
            const objeto = JSON.parse(error.request.responseText)
            if (objeto.errors) {
              this.message = ''
              const mensaje = Object.keys(objeto.errors).map(function (key, index) {
                return objeto.errors[key][index]
              })
              this.message = mensaje[0]
              this.snackbar = true
            } else {
              this.message = objeto.message
              this.snackbar = true
            }
            console.log(objeto, this.message)
          }
        }
      )
    }
  }
}
</script>
