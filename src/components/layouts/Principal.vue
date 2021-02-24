<template>
  <v-app>
    <v-navigation-drawer app
         v-model="drawer">
         <v-list>
          <v-list-item class="px-2">
            <v-list-item-avatar>
              <v-img src="https://randomuser.me/api/portraits/women/85.jpg"></v-img>
            </v-list-item-avatar>
          </v-list-item>

          <v-list-item link>
            <v-list-item-content>
              <v-list-item-title class="title">
                {{ userName }}
              </v-list-item-title>
              <v-list-item-subtitle>{{ userEmail }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>

        <v-list-item>
            <v-list-item-content>
              <v-list-item-title class="title">
               <v-btn block color="primary" @click="logout">Logout</v-btn>
              </v-list-item-title>
              <v-list-item-subtitle></v-list-item-subtitle>
            </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>

        <v-list
          nav
          dense
        >
          <v-list-item link>
            <v-list-item-icon>
              <v-icon>mdi-house</v-icon>
            </v-list-item-icon>
            <v-list-item-title>Inicio</v-list-item-title>
          </v-list-item>
          <v-list-item link
            :to="`/principal/persona`"
            @click="rutasPaciente">
            <v-list-item-icon>
              <v-icon>mdi-account-multiple</v-icon>
            </v-list-item-icon>
            <v-list-item-title>Registro de persona</v-list-item-title>
          </v-list-item>
          <v-list-item link
            :to="`/principal/pacienteEmergencia`">
            <v-list-item-icon>
              <v-icon>mdi-star</v-icon>
            </v-list-item-icon>
            <v-list-item-title>paciente emergencia</v-list-item-title>
          </v-list-item>
        </v-list>
        </v-navigation-drawer>
      <v-app-bar app >
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      </v-app-bar>
      <v-main class="fondo-main">
      <!-- Provides the application the proper gutter -->
      <v-container fluid>
        <!-- If using vue-router -->
        <router-view></router-view>
      </v-container>
    </v-main>
    <v-footer app>
      <span>&copy;2020</span>
    </v-footer>
  </v-app>
</template>
<style scoped>
 .fondo-main {
   background: #c4d0e4;
 }
</style>

<script>
import DatosUser from '@/models/DatosUser-model.js'
export default {
  data () {
    return {
      drawer: null,
      userLogueado: new DatosUser('', ''),
      items: [{
        icon: 'bubble_chart',
        title: 'Inspire'
      }],
      title: 'Principal Layout',
      userName: '',
      userEmail: ''
    }
  },
  created () {
    let usuario = JSON.parse(localStorage.getItem('userNane'))
    this.userEmail = (usuario) ? usuario.email : ''
    usuario = JSON.parse(localStorage.getItem('userNane'))
    this.userName = (usuario) ? usuario.name : ''
  },
  methods: {
    rutasPaciente () {
      console.log(this.$router)
    },
    logout: function (event) {
      this.$store.dispatch('auth/logout').then((data) => {
        if (data.success) {
          localStorage.clear()
          this.$router.push({ path: '/' })
        }
      })
    }
  },
  name: 'App'
}
</script>
