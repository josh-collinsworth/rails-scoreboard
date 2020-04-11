<template>
  <div id="app">
    <Header />
    <p>{{ message }}<strong> SUCKAS</strong></p>
  </div>
</template>

<script>
import Header from './components/Header.vue'

export default {
  data: () => ({
    message: "Hello Vue!"
  }),
  components: { Header }
}
</script>

<style lang="scss">
@import '../../../assets/stylesheets/vars';

p {
  font-size: 2em;
  text-align: center;

  strong {
    color: $lightBlue;
  }
}
</style>
