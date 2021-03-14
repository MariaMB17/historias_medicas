import Vue from 'vue'
import Vuex from 'vuex'
import { auth } from './auth.module'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    layout: 'login-layout',
    userName: (JSON.parse(localStorage.getItem('userNane'))) ? JSON.parse(localStorage.getItem('userNane')).name : '',
    userEmail: (JSON.parse(localStorage.getItem('userNane'))) ? JSON.parse(localStorage.getItem('userNane')).email : ''
  },
  getters: {},
  mutations: {
    SET_LAYOUT (state, newLayout) {
      state.layout = newLayout
    },
    SET_USER_NAME (state, name) {
      state.userName = name
    },
    SET_USER_EMAIL (state, email) {
      state.userEmail = email
    }
  },
  actions: {},
  modules: {
    auth
  }
})
