<template>
  <v-container class="login-container">
      <v-layout row class="login-layout">
          <v-flex offset-lg4 lg4 xs12 sm6 m4 offset-xs0 offset-sm3 offset-m4>
              <v-snackbar
                :timeout="3000"
                :value="isInvalid"
                :color="colorValue"
                absolute
                right
                shaped
                top>
                {{ messages }}
              </v-snackbar>
              <v-form>
                  <v-text-field
                    v-model="user.email"
                    label="Email"
                    :error-messages="emailErrors"
                    @input="$v.user.email.$touch()"
                    @blur="$v.user.email.$touch()"
                  ></v-text-field>
                  <v-text-field
                    v-model="user.password"
                    :error-messages="passwordErrors"
                    label="Contraseña"
                    type="password"
                    @input="$v.user.password.$touch()"
                    @blur="$v.user.password.$touch()"
                  ></v-text-field>
                  <v-btn color="primary" @click="loginUser">Entrar</v-btn>
              </v-form>
          </v-flex>
      </v-layout>
  </v-container>
</template>
<script>
import User from '../models/User-model.js'
import AuthService from '../services/auth.service'
import moment from 'moment'
import { validationMixin } from 'vuelidate'
import { required, maxLength, email } from 'vuelidate/lib/validators'
export default {
  mixins: [validationMixin],
  validations: {
    user: {
      email: { required, email },
      password: { required, maxLength: maxLength(255) }
    }
  },
  data () {
    return {
      user: new User('', '', '', '', false),
      loading: false,
      isInvalid: false,
      messages: '',
      colorValue: 'cyan darken-2'
    }
  },
  computed: {
    loggedIn () {
      return this.$store.state.auth.status.loggedIn
    },
    passwordErrors () {
      const errors = []
      if (!this.$v.user.password.$dirty) return errors
      !this.$v.user.password.maxLength && errors.push('Password must be at most 10 characters long')
      !this.$v.user.password.required && errors.push('Password is required.')
      return errors
    },
    emailErrors () {
      const errors = []
      if (!this.$v.user.email.$dirty) return errors
      !this.$v.user.email.email && errors.push('Must be valid e-mail')
      !this.$v.user.email.required && errors.push('E-mail is required')
      return errors
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
      this.isInvalid = false
      this.$v.$touch()
      if (this.$v.$invalid) {
        this.isInvalid = true
        this.colorValue = 'error'
        this.messages = 'Usuario o contraseña invalidos'
      } else {
        // if (this.user.email && this.user.password) {
        this.$store.dispatch('auth/login', this.user).then(() => {
          AuthService.getUserInf().then(() => {
            const userName = JSON.parse(localStorage.getItem('userNane')).name
            const userEmail = JSON.parse(localStorage.getItem('userNane')).email
            this.$store.commit('SET_USER_NAME', userName)
            this.$store.commit('SET_USER_EMAIL', userEmail)
            this.$router.replace({ path: '/principal' })
          }, error => {
            console.log(error)
          })
        },
        error => {
          this.messages =
          (error.response && error.response.data.message) ||
          error.message || error.toString()
          this.colorValue = 'error'
          this.isInvalid = true
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
    padding-bottom: 70px !important;
    padding-top: 50px !important;
    display:block;
    background-color:white
  }
  @media screen and (max-width: 600px) {
    .login-layout{
      padding-left: 30px;
      padding-right: 30px;
      padding-bottom: 30px !important;
      padding-top: 30px !important;
      display:block;
      background-color:white
    }
  }
</style>
