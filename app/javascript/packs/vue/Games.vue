<template>
	<div class="container">
    <h1>Games</h1>

		<ul id="games-list">
			<li v-for="game in gamesList" :key="game.created_at">
				<a :href="`/game/${game.id}`">
					<h2>{{ game.name }}</h2>
				</a>
				<p class="details">Last updated {{ parseDate(game.updated_at) }}</p>
				<p><small>{{game.options.increment}}</small></p>
			</li>
		</ul>
	</div>
</template>


<script>
import axios from 'axios'

export default {
	data: () => ({
		gamesList: []
	}),
	mounted() {
		axios.get('/api/games').then(response => {
			this.gamesList = response.data
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
