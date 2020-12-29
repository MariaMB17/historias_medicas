import Vue from 'vue'
import Vuex from 'vuex'
import { auth } from './auth.module'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    layout: 'login-layout',
    user: ''
  },
  getters: {},
  mutations: {
    SET_LAYOUT (state, newLayout) {
      state.layout = newLayout
    }
  },
  actions: {},
  modules: {
    auth
  }
})
