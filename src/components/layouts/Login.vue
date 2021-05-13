<template>
  <v-app>
    <v-toolbar>
      <v-toolbar-items>
        <v-btn link
            :to="`/`"  text>Login</v-btn>
      </v-toolbar-items>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn @click="$router.push('/register')" text>Registrarse</v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <v-main class="main-login">
      <router-view />
    </v-main>
  </v-app>
</template>
<style scoped>
header {
  max-height: 56px;
  background: #c4d0e4 !important;
}
.fondo-imagen {
  background-image: url("../../assets/images/doctor_digital_tablet.jpg");
  background-size: cover;
}
.main-login {
  background-image: url("../../assets/images/doctor_digital_tablet.jpg");
  background-image: no-repeat;
  background-image: fixed;
  background-image: center;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
