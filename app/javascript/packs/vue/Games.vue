<template>
	<div class="container">
		<transition name="fade">
			<div v-if="loading" key="isLoading">
				<Loader />
			</div>

			<div v-else key="isLoaded">
				<h1>Resume a game in progress</h1>
				<p>Or, <a href="/game/new">start a new game</a>!</p>
				<hr>
				<ul id="games-list">
					<li v-for="game in gamesList" :key="game.created_at">
						<a :href="`/game/${game.id}`">
							<h2>{{ game.name }}</h2>
						</a>
						<p class="details">Last played: {{ parseDate(game.updated_at) }}</p>
					</li>
				</ul>
			</div>
		</transition>
	</div>
</template>


<script>
import axios from 'axios'
import Loader from './components/Loader'

export default {
	data: () => ({
		gamesList: [],
		loading: true
	}),
	components: { Loader },
	mounted() {
		axios.get('/api/games').then(response => {
			this.gamesList = response.data
			setTimeout(() => { this.loading = false }, 200)
		})
	},
	methods: {
		parseDate(date) {
			return new Date(date).toString().split('GMT')[0]
		}
	}
}
</script>


<style scoped lang="scss">
	#games-list {
		padding-left: 0;

		li {
			list-style-type: none;

			a {
				margin: 0;
			}

			h2 {
				margin-bottom: 0;
			}

			p.details {
				font-style: italic;
				margin-top: 0;
			}
		}
	}
</style>
