<template>
<v-app>
    <v-toolbar class="fondo-imagen ">
        <v-toolbar-title>Login</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items class="hidden-sm-and-down">
            <v-btn @click="$router.push('/register')" text>Registrarse</v-btn>
        </v-toolbar-items>
    </v-toolbar>
    <v-main class="main-login">
        <router-view/>
    </v-main>
</v-app>
</template>
<style scoped>
    .fondo-imagen {
        background-image: url("../../assets/images/doctor_digital_tablet.jpg");
        background-size: cover;
    }
    .main-login{
        background:#c4d0e4;

    }
</style>
