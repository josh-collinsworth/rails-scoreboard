<template>
	<div class="container">
		<transition name="fade">
			<div v-if="loading" key="isLoading">
				<Loader />
			</div>

			<div v-else key="isLoaded">
				<h1>Rails Scoreboard</h1>
				<a class="btn" href="/game/new">Start a new game</a>
				<p class="or">OR</p>
				<h2>Resume a game in progress:</h2>
				<ul id="games-list">
					<li v-for="game in gamesList" :key="game.updated_at">
						<a :href="`/game/${game.id}`">
							{{ game.name }}
						</a>
						<span class="details">Last played: {{ parseDate(game.updated_at) }}</span>
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
	created() {
		axios.get('/api/games').then(response => {
			this.gamesList = response.data
			setTimeout(() => { this.loading = false }, 200)
		})
	},
	mounted() {
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

	h1 {
		margin: 0 0 .5em;
		font-size: calc(2.6rem + 2vw);
		line-height: 1;
	}

	h2 {
		font-style: italic;
	}

	.container {
		text-align: center;
	}

	.btn {
		margin: 0 auto .5rem;
	}

	#games-list {
		padding-left: 0;

		li {
			list-style-type: none;
			display: flex;
			justify-content: space-between;
			align-items: baseline;
			padding: .5rem 0;
			border-bottom: 1px solid lighten($lightGray, 25%);

			a {
				margin: 0;
				font-weight: bold;
				font-size: 1.125rem;
			}

			.details {
				font-style: italic;
				font-weight: normal;
				margin: 0;
				font-size: .875rem;
				color: $mediumGray;
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
