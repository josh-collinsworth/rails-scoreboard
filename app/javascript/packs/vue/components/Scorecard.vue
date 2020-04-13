<template>
	<article class="card" v-if="game && player">
		<h2>{{ player.name }}</h2>

		<p class="score">
			{{ player.score || 0 }}
		</p>
		<div class="button-board half">
			<button @click="incrementScore(false)">-{{ game.options.increment }}</button>
			<button @click="incrementScore(true)">+{{ game.options.increment }}</button>
		</div>
	</article>
</template>


<script>
import axios from 'axios'

export default {
	props: {
		player: {
			type: Object,
			required: true
		},
		game: {
			type: Object,
			required: true
		},
		refresh: {
			type: Function,
			required: true
		}
	},
	methods: {
		incrementScore(add) {
			let newScore = Number(this.player.score || 0)
			const increment = Number(this.game.options.increment)

			add ? newScore += increment : newScore -= increment

			const data = { new_score: newScore }
			axios
				.put(`/api/participants/${this.player.id}`, data)
				.then(response => {
					if(response.data.success) {
						this.refresh()
					} else {
						console.log("ERRORs")
					}
				})
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../../assets/stylesheets/vars';

	.card {
		padding: 1rem;
		border-radius: .25rem;
		background: $white;
		text-align: center;

		h2 {
			margin-top: 0;
		}

		.score {
			text-align: center;
			font-size: 2.5rem;
			font-weight: bold;
			margin: 0;
		}

		.button-board {
			display: grid;
			grid-gap: 1rem;

			&.half {
				grid-template-columns: 1fr 1fr;
			}
		}
	}
</style>
