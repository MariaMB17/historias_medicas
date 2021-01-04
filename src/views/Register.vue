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
          console.log(data.message)
          this.successful = true
          this.$router.push('/').catch(error => {
            if (error.name !== 'NavigationDuplicated') {
              throw error
            }
          })
        },
        error => {
          console.log(this.user.passwordConfirmation)
          this.message =
          (error.request.status && error.data) ||
          error.data.message ||
          error.toString()
          this.successful = false
        }
      )
    }
  }
}
</script>
