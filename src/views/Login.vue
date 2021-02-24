<template>
  <v-container class="login-container">
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
import moment from 'moment'
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
    const user = JSON.parse(localStorage.getItem('user'))
    const now = moment(new Date(), 'YYYY-MM-DD')
    const expirateToken = (user) ? moment(user.expires_at, 'YYYY-MM-DD') : null
    const changeToken = (user) ? now.isAfter(expirateToken) : false
    if (this.loggedIn && !changeToken) {
      this.$router.replace({ path: '/principal' })
    } else {
      this.$router.push({ path: '/' })
    }
  },
  methods: {
    loginUser: function (event) {
      if (this.user.email && this.user.password) {
        this.$store.dispatch('auth/login', this.user).then(() => {
          this.$router.replace({ path: '/principal' })
        },
        error => {
          this.message =
          (error.response && error.response.data) ||
          error.message || error.toString()
        })
      }
    }
  }
}
</script>
<style scoped>
  .login-container {
    margin-top: 150px;
    margin-bottom: 150px;
  }

</style>
