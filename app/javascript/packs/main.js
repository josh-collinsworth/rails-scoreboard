/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import Scoreboard from './vue/Scoreboard.vue'
import Games from './vue/Games.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  //Look for elements where we mount the Vues
  const scoreboardEl = document.querySelector('#scoreboard')
  const gamesEl = document.querySelector('#games')

  // Create the Vues
  const scoreboard = new Vue({ render: h => h(Scoreboard) })
  const games = new Vue({ render: h => h(Games) })

  // Conditionally mount the Vues
  if (gamesEl) games.$mount(gamesEl)
  if (scoreboardEl) scoreboard.$mount(scoreboardEl)
})
