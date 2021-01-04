<template>
  <v-container>
      <v-layout row>
          <v-flex xs12 sm6 m4 offset-xs0 offset-sm3 offset-m4>
              <v-form>
                  <v-text-field v-model="user.email" label="Email"></v-text-field>
                  <v-text-field v-model="user.password" label="Contraseña" type="password"></v-text-field>
                  <v-btn block color="primary" @click="loginUser">Entrar</v-btn>
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
      loading: false,
      message: ''
    }
  },
  computed: {
    loggedIn () {
      return this.$store.state.auth.status.loggedIn
    }
  },
  created () {
    this.$store.commit('SET_LAYOUT', 'login-layout')
    if (this.loggedIn) {
      this.$router.push('/principal')
    } else {
      this.$router.push('/')
    }
  },
  methods: {
    loginUser: function (event) {
      if (this.user.email && this.user.password) {
        this.$store.dispatch('auth/login', this.user).then(() => {
          this.$router.push('/principal')
        },
        error => {
          console.log(error)
          this.message =
          (error.response && error.response.data) ||
          error.message || error.toString()
        })
      }
    }
  }
}
</script>
