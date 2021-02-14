<template style="background: red;">
  <router-view></router-view>
</template>
<script>
export default {
  computed: {
    loggedIn () {
      return this.$store.state.auth.status.loggedIn
    }
  },
  beforeMount () {
    console.log('aquii')
  },
  created () {
    this.$store.commit('SET_LAYOUT', 'principal-layout')
  }
}
</script>
