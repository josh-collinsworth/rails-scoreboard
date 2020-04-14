<template>
	<div class="container">
		<transition name="fade">
			<div v-if="loading" key="isLoading">
				<Loader />
			</div>

			<div v-else key="isLoaded">
				<h1>Rails Scoreboard</h1>
				<h2><a href="/game/new">Start a new game</a></h2>
				<p class="or">OR</p>
				<h2>Resume a game in progress:</h2>
				<ul id="games-list">
					<li v-for="game in gamesList" :key="game.updated_at">
						<a :href="`/game/${game.id}`">
							<h2>{{ game.name }}</h2>
						</a>
						<p class="details">Last played: {{ parseDate(game.updated_at) }}</p>
					</li>
				</ul>
				<h3 v-if="!gamesList.length">(No games found)</h3>
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
			const jsDate = new Date(date)
			return `${jsDate.toLocaleDateString()} at ${jsDate.toLocaleTimeString()}`
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../assets/stylesheets/vars';

	.container {
		text-align: center;
	}

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

	p.or {
		font-style: italic;
		color: $lightGray;
		width: 100%;
		text-align: center;
		position: relative;

		&:before, &:after {
			content: '';
			width: calc(50% - 1rem);
			height: 0;
			border-bottom: 1px solid $lightGray;
			position: absolute;
			left: 0;
			top: calc(50% - 1px);
		}

		&:after {
			left: unset;
			right: 0;
		}
	}
</style>
