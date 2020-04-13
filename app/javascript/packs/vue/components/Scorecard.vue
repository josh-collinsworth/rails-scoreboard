<template>
	<article class="card" v-if="game && player">
		<h2>{{ player.name }}</h2>

		<p class="score">
			<span class="prepend">{{ game.options.prepend }}</span>{{ player.score || 0 }}<span class="append">{{ game.options.append }}</span>
		</p>
		<div class="button-board half">
			<button  v-if="showOnes" @click="incrementScore(-1)">-1</button>
			<button  v-if="showOnes" @click="incrementScore(1)">+1</button>

			<button @click="incrementScore(game.options.increment * -1)">-{{ game.options.increment }}</button>
			<button @click="incrementScore(game.options.increment)">+{{ game.options.increment }}</button>
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
		incrementScore(amount) {
			let newScore = Number(this.player.score || 0)

			newScore += Number(amount)

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
	},
	computed: {
		showOnes() {
			return this.game.options.include_increment_by_one && this.game.options.increment != 1
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../../assets/stylesheets/vars';

	.card {
		padding: 1rem;
		border-radius: .5rem;
		background: $white;
		text-align: center;
		border: 2px solid $darkGray;

		h2 {
			margin: 0;
		}

		.score {
			text-align: center;
			font-size: 2.5rem;
			font-weight: bold;
			margin: .5em auto;

			.prepend,
			.append {
				font-size: .75em;
				font-weight: normal;
				color: $mediumGray;
			}
		}

		.button-board {
			display: grid;
			grid-gap: 1rem;

			button {
				margin: 0;
				/* background: $lightBlue; */
				font-size: 1.25rem;
				border-color: $darkGray;

				&:hover {
					box-shadow: none;
					background: $yellow;
				}

				&:focus {
					background: $yellow;
				}
			}

			&.half {
				grid-template-columns: 1fr 1fr;
			}
		}
	}
</style>
